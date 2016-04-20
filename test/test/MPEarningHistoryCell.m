//
//  MPEarningHistoryCell.m
//  test
//
//  Created by Mikhail Prysiazhniy on 26.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPEarningHistoryCell.h"

@implementation MPEarningHistoryCell


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
    _amount = [[UILabel alloc] init];
    _date = [[UILabel alloc] init];
    [self addSubview:self.amount];
    [self addSubview:self.date];
    self.amount.textAlignment = NSTextAlignmentCenter;
    self.date.textAlignment = NSTextAlignmentRight;
    
    [self.amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(10.f);
        make.right.lessThanOrEqualTo(self.date.mas_left).with.offset(-10.f);
    }];
    
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right).with.offset(-10.f);
    }];
}




@end
