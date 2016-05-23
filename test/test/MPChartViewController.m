//
//  MPChartViewController.m
//  Jewarator
//
//  Created by Michail on 23.05.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPChartViewController.h"
#import "PNChart.h"

#import <CoreData/CoreData.h>
#import "Transaction+CoreDataProperties.h"
#import "AppDelegate.h"

@interface MPChartViewController ()

@property (strong, nonatomic) PNBarChart *pieChart;
@property (strong, nonatomic) NSArray *dataSource;

@end



@implementation MPChartViewController

#pragma mark - view controller methods


- (void)viewDidLoad{
    [self initStartUp];
    [self initDataSource];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
}


#pragma mark - accessors

- (void)initStartUp{
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self createUI];
    [self makeConstraints];
}

- (void)createUI{
    _pieChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:self.pieChart];
    [self.pieChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    [self.pieChart setYValues:@[@1,  @10, @2, @6, @3]];
    [self.pieChart strokeChart];
}

- (void)makeConstraints{
    [self.pieChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(200.));
        make.centerX.centerY.equalTo(self.view);
    }];
}

- (void)initDataSource{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];
    
    NSError *error = nil;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [delegate.coreDataBridge managedObjectContext];
    NSArray *results = [context executeFetchRequest:request error:&error];
    NSLog(@"%lu",(unsigned long)results.count);

}

@end
