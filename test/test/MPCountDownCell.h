//
//  MPCountDownCell.h
//  Jewarator
//
//  Created by Michail on 01.07.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction+CoreDataProperties.h"
#import "MPStatisticView.h"

@interface MPCountDownCell : UITableViewCell

@property (strong, nonatomic) Transaction *dataSource;
@property (strong, nonatomic) MPStatisticView *container;

- (void)updateViewCell;

@end
