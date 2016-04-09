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
    self.layer.borderWidth = 2.f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.backgroundColor = [UIColor lightGrayColor];
    [self makeUI];
    [self makeConstraints];
}

- (void)makeUI{
    _lbl_titile = [[UILabel alloc] init];
    _tf_amount = [[UITextField alloc] init];
    self.tf_amount.backgroundColor = [UIColor grayColor];
    [self addSubview:self.lbl_titile];
    [self addSubview:self.tf_amount];
}

- (void)makeConstraints{
    [self.lbl_titile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self).with.offset(0.f);
        make.right.equalTo(self.tf_amount.mas_left).with.offset(0.f);
        make.width.equalTo(self.tf_amount.mas_width).with.offset(0.f);
    }];
    
    [self.tf_amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self).with.offset(0.f);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
