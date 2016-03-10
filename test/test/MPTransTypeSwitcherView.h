//
//  MPTransTypeSwitcherView.h
//  test
//
//  Created by Michail on 10.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MPTransTypeSwitcherView;

@protocol OPTKTransactionTypeSwitchesViewProtocol <NSObject>

@required

- (NSArray *)dataSourceForView;
- (UIViewController *)viewControllerForPresenter;
- (NSString *)cancelTextForAction;
- (void)transactionTypeSwitcherView:(MPTransTypeSwitcherView *)view didSelectedValueAtIndex:(NSInteger)idx;

@optional

- (void)viewTransactionTypeSwitchesDidPresentController:(MPTransTypeSwitcherView *)view;
- (void)viewTransactionTypeSwitchesDidHideController:(MPTransTypeSwitcherView *)view;

@end


@interface MPTransTypeSwitcherView : UIView

@property (strong, nonatomic, readonly) UILabel *leftLabel;
@property (strong, nonatomic, readonly) UILabel *rigthLabel;
@property (weak, nonatomic) id <OPTKTransactionTypeSwitchesViewProtocol> typeSwitchesProtocol;

@end
