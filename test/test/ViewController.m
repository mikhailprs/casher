//
//  ViewController.m
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//



#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import <Masonry/Masonry.h>
#import "ViewController.h"
#import "Balance+CoreDataProperties.h"
#import "Earning+CoreDataProperties.h"
#import "Transaction+CoreDataProperties.h"

#import "MPStatisticView.h"
#import "MPAddingEarningViewController.h"
#import "MPDashBoardBottomView.h"




@interface ViewController () <MPDashBoardBottomViewDelegate>

@property (strong , nonatomic) NSManagedObjectContext *context;

@end

@implementation ViewController



#pragma mark - view controller methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    [self makeConstraints];
    [self initDelegates];
    [self initText];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self initDataSource];
}


#pragma mark - accessors

- (NSManagedObjectContext *)context{
    if (!_context){
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        _context = [delegate.coreDataBridge managedObjectContext];
    }
    return _context;
}


#pragma mark - init methods


- (void)makeUI {
    [self initBottomCollectionView];
    [self initAvailableView];
    
}

- (void)initBottomCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _bottomView = [[MPDashBoardBottomView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.view addSubview:_bottomView];
}

- (void)initAvailableView{
    
    _view_avialable = [[MPStatisticView alloc] init];
    _view_keeped = [[MPStatisticView alloc] init];
    _view_lastEarn = [[MPStatisticView alloc] init];
    _view_lastWaste = [[MPStatisticView alloc] init];
    UIView *view = self.view;
    [view addSubview:self.view_avialable];
    [view addSubview:self.view_keeped];
    [view addSubview:self.view_lastEarn];
    [view addSubview:self.view_lastWaste];
    
    [self.view_avialable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(40.f);
        make.right.equalTo(view.mas_right).with.offset(-40.f);
        make.top.equalTo(view.mas_top).with.offset(84.f);
        make.height.equalTo(@(self.view_avialable.defaultHeight));
    }];
    
    [self.view_keeped mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(40.f);
        make.right.equalTo(view.mas_right).with.offset(-40.f);
        make.top.equalTo(self.view_avialable.mas_top).with.offset(40.f);
        make.height.equalTo(@(self.view_avialable.defaultHeight));
    }];
    
    [self.view_lastEarn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(40.f);
        make.right.equalTo(view.mas_right).with.offset(-40.f);
        make.top.equalTo(self.view_keeped.mas_top).with.offset(40.f);
        make.height.equalTo(@(self.view_avialable.defaultHeight));
    }];
    
    [self.view_lastWaste mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(40.f);
        make.right.equalTo(view.mas_right).with.offset(-40.f);
        make.top.equalTo(self.view_lastEarn.mas_top).with.offset(40.f);
        make.height.equalTo(@(self.view_avialable.defaultHeight));
    }];
}

- (void)initDataSource{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Balance"];
    
    NSError *error = nil;
    NSArray *results = [self.context executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    Balance *balance = [results firstObject];
    self.view_avialable.lbl_right.text = [NSString stringWithFormat:@"%.2f",[balance.amount doubleValue]];
    self.view_keeped.lbl_right.text = [NSString stringWithFormat:@"%.2f",[balance.keeped doubleValue]];
    
    Earning *lastEarn = balance.profit;

    self.view_lastEarn.lbl_right.text = [NSString stringWithFormat:@"%.2f",[lastEarn.earn_amount doubleValue]];
    
    Transaction *lastTransaction = balance.loss;
    self.view_lastWaste.lbl_right.text = [NSString stringWithFormat:@"%.2f",[lastTransaction.trans_amount doubleValue]];
    [self.context save:nil];
}

#pragma mark - init constraints

- (void)makeConstraints{
    [self bottomCollectionConstraints];
}

- (void)bottomCollectionConstraints{
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0.f);
        make.height.equalTo(@85.f);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50.f);
    }];
}


#pragma init delegate and settings

- (void)initDelegates{
    self.bottomView.bottomViewDelegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;  // для автоматической подстройки ячеек collection view
    [self.navigationItem setTitle:@"Balances"];
}

#pragma mark - common methods

- (void)initText{
    self.view_avialable.lbl_left.text = @"Available";
    self.view_keeped.lbl_left.text = @"Keeped";
    self.view_lastEarn.lbl_left.text = @"Last Earn";
    self.view_lastWaste.lbl_left.text = @"Last Waste";
}

#pragma mark - MPDashBoardBottomViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectAtIndex:(NSIndexPath *)indexPath typeCell:(MPBottomTypeCellEnum)typeOfCell{
    switch (typeOfCell) {
        case OPTKBottomTypeCellDeposit:{
            NSLog(@"%ld",(long)indexPath.row);
            [self performSegueWithIdentifier:@"addEarning" sender:collectionView];
            
//            [self performSegueWithIdentifier:@"push_to_favorites" sender:collectionView];
            break;}
        case OPTKBottomTypeCellOpenTrades:{
            [self performSegueWithIdentifier:@"adding_transaction" sender:collectionView];
            
             NSLog(@"%ld",(long)indexPath.row);
            break;}
        case OPTKBottomTypeCellClosedTrades:{
            // do any setup you need for myNewVC
           [self performSegueWithIdentifier:@"earnHistory" sender:collectionView];
             NSLog(@"%ld",(long)indexPath.row);
//            [self performSegueWithIdentifier:@"push_to_closed_trades" sender:collectionView];
            break;}
        case OPTKBottomTypeCellFavorites:{
             NSLog(@"%ld",(long)indexPath.row);
            [self performSegueWithIdentifier:@"history" sender:collectionView];
//            UIStoryboard *storyBoard = [self getCurrentStoryBoard];
//            OPTKWebViewController *webView = [storyBoard instantiateViewControllerWithIdentifier:@"webViewController"];
//            if(webView){
//                [self presentViewController:webView animated:YES completion:nil];
//            }
            break;}
        case OPTKBottomTypeCellOrders:{
             NSLog(@"%ld",(long)indexPath.row);
//            [self performSegueWithIdentifier:@"push_to_place_order_list" sender:collectionView];
            break;}
        case OPTKBottomTypeCellPriceAlerts:{
             NSLog(@"%ld",(long)indexPath.row);
//            [self performSegueWithIdentifier:@"push_to_price_alerts_list" sender:collectionView];
            break;}
        case OPTKBottomTypeCellPendingBonus:{
             NSLog(@"%ld",(long)indexPath.row);
//            [self performSegueWithIdentifier:@"push_to_bonuses" sender:collectionView];
            break;}
        case OPTKBottomTypeCellReports:{
             NSLog(@"%ld",(long)indexPath.row);
//            [self performSegueWithIdentifier:@"push_to_reports" sender:collectionView];
            break;}
        default:{
            
            break;}
    }
}



@end
