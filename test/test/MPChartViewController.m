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

@property (strong, nonatomic) PNPieChart *pieChart;
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createUI];
    [self makeConstraints];
}

- (void)createUI{
    [self.view addSubview:self.pieChart];
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNBlue description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNGreen description:@"GOOL I/O"],
                       ];
    
    
    _pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, 200, 200) items:items];
    [self.view addSubview:self.pieChart];
    _pieChart.descriptionTextColor = [UIColor whiteColor];
    _pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    [_pieChart strokeChart];}

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
    id sum = [results valueForKeyPath:@"@sum.trans_amount"];
    
    self.pieChart.legendStyle = PNLegendItemStyleSerial;
    UIView *legend = [self.pieChart getLegendWithMaxWidth:200];
    
    //Move legend to the desired position and add to view
    [legend setFrame:CGRectMake(130, 350, legend.frame.size.width, legend.frame.size.height)];
    [self.view addSubview:legend];
//    NSLog(@"%lu",(unsigned long)results.count);
    
}

@end
