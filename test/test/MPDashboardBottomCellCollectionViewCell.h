//
//  MPDashboardBottomCellCollectionViewCell.h
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MPBottomTypeCellEnum) {
    OPTKBottomTypeCellDeposit               = 0,
    OPTKBottomTypeCellOpenTrades            = 1,
    OPTKBottomTypeCellClosedTrades          = 2,
    OPTKBottomTypeCellFavorites             = 3,
    OPTKBottomTypeCellOrders                = 4,
    OPTKBottomTypeCellPriceAlerts           = 5,
    OPTKBottomTypeCellPendingBonus          = 6,
    OPTKBottomTypeCellReports               = 7
};

@interface MPDashboardBottomCellCollectionViewCell : UICollectionViewCell


@property (weak,   nonatomic) IBOutlet UILabel *lbl_name;
@property (assign, nonatomic) MPBottomTypeCellEnum  typeCell;


@end
