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
#import "MPChartViewController.h"
#import "MPAlertAction.h"
#import "DCPathButton.h"



@interface ViewController () <MPDashBoardBottomViewDelegate, DCPathButtonDelegate>

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) DCPathButton *keeperButton;

@end

@implementation ViewController



#pragma mark - view controller methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    [self makeConstraints];
    [self initDelegates];
    [self initText];
    
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
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Clear"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(clearDB)]; // пока что по убогому сразу все / затем заменить на отдельные
    self.navigationItem.rightBarButtonItem = flipButton;
    
    UIImage *image = [UIImage imageNamed:@"plus"];
    UIImage *imageHighlited = [UIImage imageNamed:@"lightbulb"];
    _keeperButton = [[DCPathButton alloc] initWithButtonFrame:CGRectZero centerImage:image highlightedImage:imageHighlited];

    self.keeperButton.bloomRadius = 100;
    CGFloat xPos = self.view.frame.size.width / 2;
    self.keeperButton.dcButtonCenter = CGPointMake(xPos , 370);
    
    _keeperButton.allowSounds = NO;
    self.keeperButton.bloomDirection = kDCPathButtonBloomDirectionTop;
    self.keeperButton.delegate = self;
    
    
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"plus"]
                                                           highlightedImage:[UIImage imageNamed:@"plus"]
                                                            backgroundImage:[UIImage imageNamed:@"plus"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"plus"]];
    
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"plus"]
                                                           highlightedImage:[UIImage imageNamed:@"plus"]
                                                            backgroundImage:[UIImage imageNamed:@"plus"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"plus"]];
    


    NSArray *elements = @[itemButton_1, itemButton_2];
    [self.keeperButton addPathItems:elements];
    [self.view addSubview:self.keeperButton];

    
}


- (void)clearDB{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Chose Action"
                                                                             message:@"Beware! You will delete whole history of those"
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *names = @[@"All", @"Earning", @"Transaction"];
    for ( NSInteger i = 0; i < names.count; i++){
        MPAlertAction *actionBalance = [MPAlertAction actionWithTitle:names[i] style:UIAlertActionStyleDestructive handler:^(UIAlertAction *alert){
            MPAlertAction *action = (id)alert;
            if (action.index == 0){
                [self removeAllEntities:nil];
            }else{
                [self executeBatchRequestWithEntityName:names[action.index]];
            }
            
        }];
        actionBalance.index = i;
        [alertController addAction:actionBalance];
    }
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
};


- (void)removeAllEntities:(id)sender{
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        NSArray *stores = [delegate.coreDataBridge.persistentStoreCoordinator persistentStores];
        NSURL *URL = [NSURL new];
    
        for(NSPersistentStore *store in stores) {
            [delegate.coreDataBridge.persistentStoreCoordinator removePersistentStore:store error:nil];
            [[NSFileManager defaultManager] removeItemAtPath:store.URL.path error:nil];
            URL = store.URL;
        }
        if (![delegate.coreDataBridge.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:URL options:nil error:nil]) {
            // do something with the error
            NSLog(@"Эта часть кода делетит все нах и создает новый персистент стор");
        }
    [self initDataSource];
}

- (void)executeBatchRequestWithEntityName:(NSString *)entityName{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    NSError *deleteError = nil;
    [delegate.coreDataBridge.persistentStoreCoordinator executeRequest:delete withContext:self.context error:&deleteError];
    
    [self initDataSource];
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
            MPChartViewController *vc = [[MPChartViewController alloc] init];
            [self.navigationController pushViewController:vc animated:NO];
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

#pragma makr - DCPathButtonDelegate

- (void)pathButton:(DCPathButton *)dcPathButton clickItemButtonAtIndex:(NSUInteger)itemButtonIndex{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Balance"];
    
    NSError *error = nil;
    NSArray *results = [self.context executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    Balance *balance = [results firstObject];
    double amount = [balance.amount doubleValue];
    if (amount > 0){
        balance.amount = 0;
        balance.keeped = [NSNumber numberWithDouble:amount];
    }
    [self.context save:nil];
    self.view_avialable.lbl_right.text = [NSString stringWithFormat:@"%.2f",[balance.amount doubleValue]];
    self.view_keeped.lbl_right.text = [NSString stringWithFormat:@"%.2f",[balance.keeped doubleValue]];
    
}


@end
