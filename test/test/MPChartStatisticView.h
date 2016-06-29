//
//  MPChartStatisticView.h
//  Jewarator
//
//  Created by Michail on 29.06.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPChartStatisticView : UIView

@property(strong, nonatomic) NSArray *dataSource;

- (instancetype)initWithDataSource:(NSArray *)data;

@end
