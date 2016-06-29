//
//  MPCountingLine.m
//  Jewarator
//
//  Created by Michail on 15.06.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPCountingLine.h"


@interface MPCountingLine ()

@property (strong, nonatomic, readwrite) UILabel *title;
@property (strong, nonatomic, readwrite) UICountingLabel *value;

@end

@implementation MPCountingLine


- (instancetype)init{
    self = [super init];
    if (self){
        [self setup];
    }
    return self;
}



- (void)setup{
    _title = [[UILabel alloc] initWithFrame:CGRectZero];
    _title.textAlignment = NSTextAlignmentLeft;
    _value = [[UICountingLabel alloc] initWithFrame:CGRectZero];
    _value.textAlignment = NSTextAlignmentRight;
    _value.format = @"%.0f%";
    [self addSubview:self.title];
    [self addSubview:self.value];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(40.f);
        make.right.equalTo(self.value.mas_left).with.offset(0.f);
    }];
    
    [self.value mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right).with.offset(-40.f);
    }];
    
    
}


@end
