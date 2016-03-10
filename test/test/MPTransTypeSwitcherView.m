//
//  MPTransTypeSwitcherView.m
//  test
//
//  Created by Michail on 10.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPTransTypeSwitcherView.h"
#import <Masonry/Masonry.h>


@interface MPTypeActions : UIAlertAction

@property (assign, nonatomic) NSInteger index;

@end

@implementation MPTypeActions
@end


@interface MPTransTypeSwitcherView ()

@property (strong, nonatomic, readwrite) UILabel *rightLabel;
@property (strong, nonatomic, readwrite) UILabel *leftLabel;
@property (strong, nonatomic) NSArray *dataSource;

@end


@implementation MPTransTypeSwitcherView

#pragma mark - init methods

- (instancetype)init{
    self = [super init];
    if (self){
        [self setup];
    }
    return self;
}


#pragma mark - setters and getters

- (void)setTypeSwitchesProtocol:(id<OPTKTransactionTypeSwitchesViewProtocol>)typeSwitchesProtocol{
    _typeSwitchesProtocol = typeSwitchesProtocol;
    [self setNeededData];
}

#pragma mark - common methods


- (void)setup{
    [self makeUI];
    [self makeConstraints];
    [self makeGestures];
}


- (void)makeUI{
    _rigthLabel = [[UILabel alloc] init];
    _leftLabel = [[UILabel alloc] init];
    _rigthLabel.userInteractionEnabled = YES;
    [self addSubview:self.rigthLabel];
    [self addSubview:self.leftLabel];
}

- (void)makeConstraints{
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(self.mas_centerY).with.offset(0.);
        make.left.equalTo(self.mas_left).with.offset(-1.);
        make.right.equalTo(self.rigthLabel.mas_left).with.offset(0.);
        make.top.greaterThanOrEqualTo(self.mas_top).with.offset(2);
        make.bottom.lessThanOrEqualTo(self.mas_bottom).with.offset(-2);
    }];
    
    [self.rigthLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.centerY.equalTo(self.mas_centerY).with.offset(0.);
        make.top.greaterThanOrEqualTo(self.mas_top).with.offset(2);
        make.bottom.lessThanOrEqualTo(self.mas_bottom).with.offset(-2);
        make.width.equalTo(@(50.f));
    }];

}

- (void)makeGestures{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tappedOnRightLabel:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.rigthLabel addGestureRecognizer:tapGesture];
}


- (void)tappedOnRightLabel:(UITapGestureRecognizer *)gesture{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    self.dataSource = [self.typeSwitchesProtocol dataSourceForView];
    __weak typeof (self) wSelf = self;
    for (NSInteger i = 0; i < self.dataSource.count; i++){
        MPTypeActions *action = [MPTypeActions actionWithTitle:self.dataSource[i]
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                            MPTypeActions *actionType = (id)action;
                                                           [wSelf didSelectedAtIndex:actionType.index];
                                                       }];
        action.index = i;
        [alertController addAction:action];
    }
    NSString *cancelText = [self.typeSwitchesProtocol cancelTextForAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelText
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    UIViewController *controller = [self.typeSwitchesProtocol viewControllerForPresenter];
    [controller presentViewController:alertController animated:YES completion:nil];
    if ([self.typeSwitchesProtocol respondsToSelector:@selector(viewTransactionTypeSwitchesDidPresentController:)]) {
        [self.typeSwitchesProtocol viewTransactionTypeSwitchesDidPresentController:self];
    }
}


- (void)didSelectedAtIndex:(NSInteger)idx{
    self.rigthLabel.text = self.dataSource[idx];
    
    [self.typeSwitchesProtocol transactionTypeSwitcherView:self
                                   didSelectedValueAtIndex:idx];
    
    if ([self.typeSwitchesProtocol respondsToSelector:@selector(viewTransactionTypeSwitchesDidHideController:)]) {
        [self.typeSwitchesProtocol viewTransactionTypeSwitchesDidHideController:self];
    }
    
}

- (void)setNeededData{
    self.dataSource = [self.typeSwitchesProtocol dataSourceForView];
    self.rigthLabel.text = [self.dataSource firstObject];
}

@end
