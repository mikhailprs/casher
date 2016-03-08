//
//  ViewController.m
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "ViewController.h"
#import "MPStatisticView.h"
#import <Masonry/Masonry.h>

@interface ViewController () <MPDashBoardBottomViewDelegate>

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    [self makeConstraints];
    [self initDelegates];
    [self initHardCode];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - init methods


- (void)makeUI {
    [self initBottomCollectionView];
    [self initAvailableView];
}

- (void)initBottomCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _bottomView = [[MPDashBoardBottomView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.view_container addSubview:_bottomView];
}

- (void)initAvailableView{
    _view_avialable = [[MPStatisticView alloc] init];
    UIView *view = self.view_container;
    [self.view_container addSubview:self.view_avialable];
    [self.view_avialable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(30.f);
        make.right.equalTo(view.mas_right).with.offset(-30.f);
        make.top.equalTo(view.mas_top).with.offset(30.f);
        make.height.equalTo(@(self.view_avialable.defaultHeight));
    }];
}



#pragma mark - init constraints

- (void)makeConstraints{
    [self bottomCollectionConstraints];
}

- (void)bottomCollectionConstraints{
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view_container).with.offset(0.f);
        make.height.equalTo(@85.f);
        make.bottom.equalTo(self.view_container.mas_bottom).with.offset(-50.f);
    }];
}


#pragma init delegate and settings

- (void)initDelegates{
    self.bottomView.bottomViewDelegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;  // для автоматической подстройки ячеек collection view
    [self.navigationItem setTitle:@"Balances"];
}

#pragma mark - common methods

- (void)initHardCode{
    self.view_avialable.lbl_left.text = @"Available:";
    self.view_avialable.lbl_right.text = @"1234$";
}

#pragma mark - MPDashBoardBottomViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectAtIndex:(NSIndexPath *)indexPath typeCell:(MPBottomTypeCellEnum)typeOfCell{
    switch (typeOfCell) {
        case OPTKBottomTypeCellFavorites:{
            NSLog(@"%ld",(long)indexPath.row);
            [self performSegueWithIdentifier:@"adding_transaction" sender:collectionView];
//            [self performSegueWithIdentifier:@"push_to_favorites" sender:collectionView];
            break;}
        case OPTKBottomTypeCellOpenTrades:{
            [self performSegueWithIdentifier:@"history" sender:collectionView];
             NSLog(@"%ld",(long)indexPath.row);
            break;}
        case OPTKBottomTypeCellClosedTrades:{
             NSLog(@"%ld",(long)indexPath.row);
//            [self performSegueWithIdentifier:@"push_to_closed_trades" sender:collectionView];
            break;}
        case OPTKBottomTypeCellDeposit:{
             NSLog(@"%ld",(long)indexPath.row);
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
