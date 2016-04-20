//
//  MPTransactionHistoryCell.m
//  test
//
//  Created by Michail on 10.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPTransactionHistoryCell.h"

@implementation MPTransactionHistoryCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setup];
    return self;
}

- (void)setup{
    UIFont *font = [UIFont fontWithName:@"OpenSans" size:10];
    _lbl_type = [[UILabel alloc] init];
    _lbl_amount = [[UILabel alloc] init];
    _lbl_place = [[UILabel alloc] init];
    _lbl_time = [[UILabel alloc] init];
    self.lbl_type.textAlignment = NSTextAlignmentLeft;
    self.lbl_amount.textAlignment = NSTextAlignmentCenter;
    self.lbl_place.textAlignment = NSTextAlignmentLeft;
    self.lbl_time.textAlignment = NSTextAlignmentRight;
    self.lbl_type.adjustsFontSizeToFitWidth = YES;
    self.lbl_amount.adjustsFontSizeToFitWidth = YES;
    self.lbl_place.adjustsFontSizeToFitWidth = YES;
    [self.lbl_place setFont:font];
    self.lbl_time.adjustsFontSizeToFitWidth = YES;
    self.lbl_place.numberOfLines = 0;
    self.lbl_time.numberOfLines = 1;
    [self addSubview:self.lbl_type];
    [self addSubview:self.lbl_amount];
    [self addSubview:self.lbl_place];
    [self addSubview:self.lbl_time];
    
    [self.lbl_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(10.f);
        make.right.equalTo(self.lbl_amount.mas_left).with.offset(0.f);
    }];
    
    [self.lbl_amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.lbl_place.mas_left).with.offset(0.);
        make.width.equalTo(self.lbl_type);
    }];
    
    [self.lbl_place mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.lbl_time.mas_left).with.offset(-5.);
        make.width.equalTo(self.lbl_type).with.multipliedBy(1.7);
    }];
    
    [self.lbl_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right).with.offset(-10.f);
        make.width.equalTo(self.lbl_type).with.multipliedBy(1.2);
    }];
}


@end
