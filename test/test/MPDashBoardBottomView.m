//
//  MPDashBoardBottomView.m
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPDashBoardBottomView.h"


@interface MPDashBoardBottomView () <MPDashBoardBottomViewDelegate>

@property (assign, nonatomic) CGSize cellSize;

@end


@implementation MPDashBoardBottomView

static NSString *const cellIdentifier = @"dashboardBottomCollectionViewCell";


#pragma mark - init methods

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self creator];
//    }
//    return self;
//}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self creator];
//    }
//    return self;
//}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self){
        [self creator];
    }
    return self;
}
- (void)creator{
    _cellSize = CGSizeZero;
    [self setUserInteractionEnabled:YES];
    [self setDelegate:self];
    [self setDataSource:self];
    [self registerNib:[UINib nibWithNibName:@"MPDashboardBottomCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setShowsVerticalScrollIndicator:NO];
    [self setBackgroundColor:[UIColor colorWithWhite:0.667 alpha:0.05f]];
//    [self initFlowLayout];
}

- (void)initFlowLayout{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self setCollectionViewLayout:flowLayout];
}

- (CGSize)cellSize{
    if (!CGSizeEqualToSize(_cellSize, CGSizeZero)) {
        return _cellSize;
    }
    float width = 92.f;
    float height = self.frame.size.height - 1;
    _cellSize = CGSizeMake(width, height);
    return _cellSize;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MPDashboardBottomCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell) {
        [cell setTypeCell:indexPath.row];
        
    }
    cell.contentView.frame = cell.bounds;
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1.f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2.f, 1.f, 2.f, 1.f);
}



#pragma mark - UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MPDashboardBottomCellCollectionViewCell *cell = (id)[collectionView cellForItemAtIndexPath:indexPath];
//    if (![cell canToBeSelected]) {
//        return;
//    }
    if ([_bottomViewDelegate respondsToSelector:@selector(collectionView:didSelectAtIndex:typeCell:)]) {
        [_bottomViewDelegate collectionView:collectionView didSelectAtIndex:indexPath typeCell:indexPath.row];
    }
}

@end
