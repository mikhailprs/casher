//
//  ViewController.h
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPDashBoardBottomView.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) MPDashBoardBottomView *bottomView;
@property (weak,   nonatomic) IBOutlet UIView *view_container;

@end

