//
//  ViewController.m
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <MPDashBoardBottomViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bottomView setBottomViewDelegate:self];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//            [self performSegueWithIdentifier:@"push_to_open_trades" sender:collectionView];
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
