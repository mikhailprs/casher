//
//  MPDashBoardBottomView.h
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPDashboardBottomCellCollectionViewCell.h"

@protocol MPDashBoardBottomViewDelegate <NSObject>

- (void)collectionView:(UICollectionView *)collectionView didSelectAtIndex:(NSIndexPath *)indexPath typeCell:(MPBottomTypeCellEnum)typeOfCell;

@end

@interface MPDashBoardBottomView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) id <MPDashBoardBottomViewDelegate> bottomViewDelegate;

@end
