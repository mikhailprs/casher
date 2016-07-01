//
//  MPCountDownCell.m
//  Jewarator
//
//  Created by Michail on 01.07.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPCountDownCell.h"
#import "MPExtension.h"
@implementation MPCountDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setup];
    return self;
}

- (void)setup{
    _container = [[MPStatisticView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_container];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
}

- (void)setDataSource:(Transaction *)dataSource{
    _dataSource = dataSource;
    self.container.lbl_left.text = [[MPExtension getTransactionTypes] objectAtIndex:[dataSource.trans_type integerValue]];
}


@end
