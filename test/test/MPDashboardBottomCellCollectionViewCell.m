//
//  MPDashboardBottomCellCollectionViewCell.m
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPDashboardBottomCellCollectionViewCell.h"

@implementation MPDashboardBottomCellCollectionViewCell

#pragma mark - init methods


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self.contentView setBackgroundColor:self.backgroundColor];
        [self setup];
    }
    return self;
}


- (void)setTypeCell:(MPBottomTypeCellEnum)typeCell{
    _typeCell = typeCell;
    [self updateCellViewByCellType];
    
}

- (void)setup{
    self.lbl_name.numberOfLines = 0;
    self.lbl_name.adjustsFontSizeToFitWidth = YES;
    self.lbl_name.textAlignment = NSTextAlignmentLeft;
    self.lbl_name.minimumScaleFactor = 0.5;
}



- (void)updateCellViewByCellType{
    NSString *textForLabel;
    NSString *imageName;
    switch (self.typeCell) {
        case OPTKBottomTypeCellDeposit:{
            textForLabel = @"Add Earn";
//            imageName = @"bottomCellFavorites";
            break;}
        case OPTKBottomTypeCellOpenTrades:{
            textForLabel = @"Add Waste";
//            imageName = @"bottomCellOpenTrades";
            break;}
        case OPTKBottomTypeCellClosedTrades:{
            textForLabel = @"Earning History";
//            imageName = @"bottomCellClosedTrades";
            break;}
        case OPTKBottomTypeCellFavorites:{
            textForLabel = @"Wasting History";
//            imageName = @"bottomCellDeposit";
            break;}
        case OPTKBottomTypeCellOrders:{
            textForLabel = @"Statistic";
//            imageName = @"bottomCellOrders";
            break;}
        case OPTKBottomTypeCellPriceAlerts:{
            textForLabel = @"Timer";
//            imageName = @"bottomCellPriceAlerts";
            break;}
        case OPTKBottomTypeCellPendingBonus:{
            textForLabel = @"NULL";
//            imageName = @"bottomCellPendingBonus";
            break;}
        case OPTKBottomTypeCellReports:{
            textForLabel = @"NULL";
//            imageName = @"bottomCellReports";
            break;}
        default:{
            textForLabel = @"NULL";
//            imageName = @"bottomCellFavorites";
            break;}
    }
    [self.lbl_name setText:[NSString stringWithFormat:@"%@",textForLabel]];
//    [self setImageByName:imageName labelText:textForLabel];
}


@end