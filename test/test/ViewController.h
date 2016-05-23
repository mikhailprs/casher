//
//  ViewController.h
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MPDashBoardBottomView;
@class MPStatisticView;

@interface ViewController : UIViewController

@property (strong, nonatomic) MPDashBoardBottomView *bottomView;
@property (strong, nonatomic) MPStatisticView *view_avialable;
@property (strong, nonatomic) MPStatisticView *view_keeped;
@property (strong, nonatomic) MPStatisticView *view_lastEarn;
@property (strong, nonatomic) MPStatisticView *view_lastWaste;


@end

