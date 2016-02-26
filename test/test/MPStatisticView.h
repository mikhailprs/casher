//
//  MPStatisticView.h
//  test
//
//  Created by Michail on 26.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPStatisticView : UIView

@property (strong, nonatomic) UILabel *lbl_left;
@property (strong, nonatomic) UILabel *lbl_right;

- (CGFloat)defaultHeight;

@end
