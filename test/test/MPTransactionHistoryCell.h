//
//  MPTransactionHistoryCell.h
//  test
//
//  Created by Michail on 10.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPTransactionHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_type;
@property (weak, nonatomic) IBOutlet UILabel *lbl_amount;
@property (weak, nonatomic) IBOutlet UILabel *lbl_place;
@property (weak, nonatomic) IBOutlet UILabel *lbl_time;

@end
