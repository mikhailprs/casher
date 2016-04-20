//
//  MPInputTextView.m
//  test
//
//  Created by Mikhail Prysiazhniy on 03.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPInputTextView.h"
#import <Masonry/Masonry.h>


@implementation MPInputTextView



#pragma mark - init methods

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self create];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self create];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self){
        [self create];
    }
    return self;
}

#pragma mark - accesors



#pragma mark - common methods

- (void)create{
    MPColorManager *colorManager = [MPColorManager sharedColorManager];
    self.layer.borderWidth = 1.f;
    self.layer.cornerRadius = 7.f;
    self.layer.borderColor = colorManager.purple_67327f.CGColor;
    self.backgroundColor = colorManager.purple_d8c9de;
    [self makeUI];
    [self makeConstraints];
}

- (void)makeUI{
    _lbl_titile = [[UILabel alloc] init];
    [self.lbl_titile setTextColor:[MPColorManager sharedColorManager].purple_3e1d4f];
    [self.lbl_titile setFont:[UIFont fontWithName:@"OpenSans" size:40]];
    
    _tf_amount = [[UITextField alloc] init];
    self.tf_amount.textAlignment = NSTextAlignmentRight;
    self.tf_amount.placeholder = @"Enter amount";
    self.tf_amount.borderStyle = UITextBorderStyleRoundedRect;
    self.tf_amount.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.lbl_titile];
    [self addSubview:self.tf_amount];
}

- (void)makeConstraints{
    [self.lbl_titile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20.f);
        make.top.bottom.equalTo(self).with.offset(0.f);
        make.width.equalTo(self.tf_amount.mas_width).with.offset(-20);
    }];
    
    [self.tf_amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10.f);
        make.left.equalTo(self.lbl_titile.mas_right).with.offset(20.f);
        make.top.equalTo(self.mas_top).with.offset(15.f);
        make.bottom.equalTo(self.mas_bottom).with.offset(-15.f);
    }];
}



@end
