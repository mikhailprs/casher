//
//  MPCountingLine.h
//  Jewarator
//
//  Created by Michail on 15.06.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UICountingLabel.h"

@interface MPCountingLine : UIView

@property (strong, nonatomic, readonly) UILabel *title;
@property (strong, nonatomic, readonly) UICountingLabel *value;

@end
