//
//  MPTransactionHistoryCell.h
//  test
//
//  Created by Michail on 10.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPTransactionHistoryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_type;
@property (strong, nonatomic) IBOutlet UILabel *lbl_amount;
@property (strong, nonatomic) IBOutlet UILabel *lbl_place;
@property (strong, nonatomic) IBOutlet UILabel *lbl_time;

@end
