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
#import "MPExtension.h"

@interface MPChartViewController ()

@property (strong, nonatomic) PNPieChart *pieChart;
@property (strong, nonatomic) NSArray *dataSource;

@end

typedef void (^CompletitionResult)(NSArray *result);

@implementation MPChartViewController

#pragma mark - view controller methods


- (void)viewDidLoad{
    [self initStartUp];
    
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
    [self getData:^(NSArray *result) {
        NSInteger value = [result.firstObject integerValue];
        NSArray *items = @[[PNPieChartDataItem dataItemWithValue:value color:PNRed],
                           [PNPieChartDataItem dataItemWithValue:value  color:PNBlue description:@"WWDC"],
                           [PNPieChartDataItem dataItemWithValue:value color:PNGreen description:@"GOOL I/O"],
                           ];
        
        
        _pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, 200, 200) items:items];
        [self.view addSubview:self.pieChart];
        _pieChart.descriptionTextColor = [UIColor whiteColor];
        _pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
        [_pieChart strokeChart];
    }];
    }
    
- (void)makeConstraints{
    [self.pieChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(200.));
        make.centerX.centerY.equalTo(self.view);
    }];
}


- (void)getData:(CompletitionResult)completition{
    dispatch_queue_t queueExecuter = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_queue_t mainQueueq = dispatch_get_main_queue();
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [delegate.coreDataBridge managedObjectContext];

    dispatch_async(queueExecuter, ^{
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 0 ; i <=2; i ++){
            NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                      @"trans_type like %@", [NSString stringWithFormat:@"%d",i]];
            [request setPredicate:predicate];
            NSArray *results = [context executeFetchRequest:request error:nil];
            id sum = [results valueForKeyPath:@"@sum.trans_amount"];
            [array addObject:sum];
        }
        if (completition){
            dispatch_async(mainQueueq, ^{
                completition([array copy]);
            });
        }
    });
    
}


@end
