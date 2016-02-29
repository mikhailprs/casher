//
//  MPStatisticView.m
//  test
//
//  Created by Michail on 26.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPStatisticView.h"
#import <Masonry/Masonry.h>

@implementation MPStatisticView


- (instancetype)init{
    self = [super init];
    [self setup];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup{
    _lbl_left = [[UILabel alloc] init];
    _lbl_left.textAlignment = NSTextAlignmentLeft;

    _lbl_right = [[UILabel alloc] init];
    _lbl_right.textAlignment = NSTextAlignmentRight;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *leftSubview = [[UIView alloc] initWithFrame:CGRectZero];
    [leftSubview addSubview:self.lbl_left];
    [self addSubview:leftSubview];
    
    UIView *rightSubview = [[UIView alloc] initWithFrame:CGRectZero];
    [rightSubview addSubview:self.lbl_right];
    [self addSubview:rightSubview];
    
    
    [self.lbl_left mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.bottom.right.equalTo(leftSubview).with.offset(0.f);
    }];
    [self.lbl_right mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.bottom.right.equalTo(rightSubview).with.offset(0.f);
    }];
    
    [leftSubview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.bottom.equalTo(self).with.offset(0.f);
        make.width.equalTo(self.lbl_left.mas_width);
        make.right.greaterThanOrEqualTo(self.lbl_right.mas_left);
    }];
    [rightSubview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.right.bottom.equalTo(self).with.offset(0.f);
        make.width.equalTo(self.lbl_right.mas_width);
        make.left.greaterThanOrEqualTo(self.lbl_left.mas_right);
    }];
}

- (CGFloat)defaultHeight{
    return 44.f;
}

@end
