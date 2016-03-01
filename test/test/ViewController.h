//
//  ViewController.h
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPDashBoardBottomView.h"
@class MPStatisticView;

@interface ViewController : UIViewController

@property (strong, nonatomic) MPDashBoardBottomView *bottomView;
@property (strong, nonatomic) MPStatisticView *view_avialable;

@property (weak,   nonatomic) IBOutlet UIView *view_container;

@end

