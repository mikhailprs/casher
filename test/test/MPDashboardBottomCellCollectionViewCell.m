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
    }
    return self;
}


- (void)setTypeCell:(MPBottomTypeCellEnum)typeCell{
    _typeCell = typeCell;
    [self updateCellViewByCellType];
    [self.lbl_name setText:[NSString stringWithFormat:@"%d",(int)typeCell]];
}



- (void)updateCellViewByCellType{
    NSString *textForLabel;
    NSString *imageName;
    switch (self.typeCell) {
        case OPTKBottomTypeCellFavorites:{
//            textForLabel = [self.localizationManager getCurrentLocalizedStringForKey:@"bottom_cell_favorites"];
//            imageName = @"bottomCellFavorites";
            break;}
        case OPTKBottomTypeCellOpenTrades:{
//            textForLabel = [self.localizationManager getCurrentLocalizedStringForKey:@"bottom_cell_open_trades"];
//            imageName = @"bottomCellOpenTrades";
            break;}
        case OPTKBottomTypeCellClosedTrades:{
//            textForLabel = [self.localizationManager getCurrentLocalizedStringForKey:@"bottom_cell_closed_trades"];
//            imageName = @"bottomCellClosedTrades";
            break;}
        case OPTKBottomTypeCellDeposit:{
//            textForLabel = [self.localizationManager getCurrentLocalizedStringForKey:@"bottom_cell_deposit"];
//            imageName = @"bottomCellDeposit";
            break;}
        case OPTKBottomTypeCellOrders:{
//            textForLabel = [self.localizationManager getCurrentLocalizedStringForKey:@"bottom_cell_orders"];
//            imageName = @"bottomCellOrders";
            break;}
        case OPTKBottomTypeCellPriceAlerts:{
//            textForLabel = [self.localizationManager getCurrentLocalizedStringForKey:@"bottom_cell_price_alert"];
//            imageName = @"bottomCellPriceAlerts";
            break;}
        case OPTKBottomTypeCellPendingBonus:{
//            textForLabel = [self.localizationManager getCurrentLocalizedStringForKey:@"bottom_cell_pending_bonus"];
//            imageName = @"bottomCellPendingBonus";
            break;}
        case OPTKBottomTypeCellReports:{
//            textForLabel = [self.localizationManager getCurrentLocalizedStringForKey:@"bottom_cell_reports"];
//            imageName = @"bottomCellReports";
            break;}
        default:{
//            textForLabel = [self.localizationManager getCurrentLocalizedStringForKey:@"bottom_cell_favorites"];
//            imageName = @"bottomCellFavorites";
            break;}
    }
    
//    [self setImageByName:imageName labelText:textForLabel];
}

@end