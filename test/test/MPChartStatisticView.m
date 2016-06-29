//
//  MPChartStatisticView.m
//  Jewarator
//
//  Created by Michail on 29.06.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPChartStatisticView.h"
#import "MPExtension.h"
#import "MPCountingLine.h"



@interface MPChartStatisticView ()

@property (strong, nonatomic) NSMutableArray *viewContainer;
@property (assign, nonatomic) BOOL wasSetuped;

@end

@implementation MPChartStatisticView

#pragma mark - init

- (instancetype)initWithDataSource:(NSArray *)data{
    self = [super init];
    if (self){
        _dataSource = data;
        [self setup];
    }
    return self;
}


#pragma mark - accessors

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    if (!self.wasSetuped) [self setup];
    for (NSInteger i = 0; i < dataSource.count; i++ ){
        MPCountingLine *line = _viewContainer[i];
        line.title.text = [[MPExtension getTransactionTypes] objectAtIndex:i];
        [line.value countFromCurrentValueTo:[_dataSource[i] floatValue]];
    }
}

#pragma mark - setup

- (void)setup{
    UIView *previosView = nil;
    _viewContainer = [NSMutableArray new];
    for (NSInteger i = 0; i < _dataSource.count; i++){
        MPCountingLine *lineStats = [[MPCountingLine alloc] init];
        [self addSubview:lineStats];
        [self.viewContainer addObject:lineStats];
        
        [lineStats mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo( previosView ? previosView.mas_bottom : self.mas_top).with.offset(10.f);
            make.left.right.equalTo(self);
            make.height.equalTo(@30.f);
        }];
        previosView = lineStats;
        _wasSetuped = YES;
    }
}




@end
