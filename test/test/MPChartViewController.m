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
#import "MPCalendarHelper.h"
#import "NSManagedObjectContext+SRFetchAsync.h"
#import "UIView+DCAnimationKit.h"

@interface MPChartViewController () <PNChartDelegate>

@property (strong, nonatomic) PNPieChart *pieChart;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) UISegmentedControl *segmentControl;
@property (strong, nonatomic) MPCalendarHelper *calendarHelper;
@property (strong, nonatomic) UILabel *moveLabel;
@property (strong, nonatomic) UIView *moveView;

@end


@implementation MPChartViewController

#pragma mark - view controller methods


- (void)viewDidLoad{
    [self initStartUp];
    [self getDataByPeriod:MPDay];
}

- (void)viewWillAppear:(BOOL)animated{
    
}


#pragma mark - accessors

- (void)setDataSource:(NSArray *)dataSource{
    NSMutableArray *array = [NSMutableArray new];
    NSInteger types = [MPExtension getTransactionCount];
    for (int i = 0 ; i <= types; i++){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"trans_type = %d",i];
        NSArray *data = [dataSource filteredArrayUsingPredicate:predicate];
        [array addObject:[data valueForKeyPath:@"@sum.trans_amount"]];
    }
    
    _dataSource = [array copy];
    [self updateChartView];
}

- (MPCalendarHelper *)calendarHelper{
    if (!_calendarHelper){
        _calendarHelper = [[MPCalendarHelper alloc] init];
    }
    return _calendarHelper;
}


- (void)initStartUp{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createUI];
    [self makeConstraints];
}


#pragma mark - make UI

- (void)createUI{
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNBlue description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNGreen description:@"GOOL I/O"],
                       ];
    _pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, 0, 0) items:items];
    self.pieChart.labelPercentageCutoff = 0.05;
    [self.view addSubview:_pieChart];

    _pieChart.delegate = self;

    _pieChart.descriptionTextColor = [UIColor blackColor];
    _pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:10.0];
    [_pieChart strokeChart];
    
    _segmentControl = [[UISegmentedControl alloc] initWithItems:self.calendarHelper.getPeriodsName];
    self.segmentControl.selectedSegmentIndex = 0;
    [self.segmentControl addTarget:self
                            action:@selector(action:)
                  forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentControl];
    [self createAnimationView];
}


- (void)createAnimationView{
    self.moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 85, 200, 100)];
    self.moveLabel.backgroundColor = [UIColor clearColor];
    self.moveLabel.font = [UIFont systemFontOfSize:36];
//    [self.moveLabel sizeToFit];
    [self.view addSubview:self.moveLabel];
    
    self.moveView = [[UIView alloc] initWithFrame:CGRectMake(40, 165, 200, 100)];
    self.moveView.backgroundColor = [UIColor orangeColor];
    [self.moveView setHidden:YES];
    [self.moveLabel setHidden:YES];
    [self.view addSubview:self.moveView];
}
    
- (void)makeConstraints{
    [self.pieChart mas_makeConstraints:^(MASConstraintMaker *make){
//        make.centerX.centerY.equalTo(self.view);
//        make.left.right.top.bottom.equalTo(self.view).with.offset(0.f);
        make.height.width.equalTo(@300);
        make.centerX.centerY.equalTo(self.view);
    }];
    
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.pieChart.mas_top).with.offset(-20.f);
        make.centerX.equalTo(self.pieChart.mas_centerX);
        make.height.equalTo(@40.);
        make.width.equalTo(@300.f);
    }];
}

- (void)addLegend{
    
    self.pieChart.legendFont = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    self.pieChart.legendStyle = PNLegendItemStyleSerial;
    UIView *legend = [self.pieChart getLegendWithMaxWidth:self.pieChart.frame.size.width];
    
    //Move legend to the desired position and add to view
    [legend setFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:legend];
    
    [legend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pieChart.mas_left).with.offset(20.f);
        make.top.equalTo(self.pieChart.mas_bottom).with.offset(10.f);
    }];

}


- (void)getDataByPeriod:(MPPeriodType)period{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];
    NSPredicate *predicate = [self.calendarHelper periodInterval:period];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [request setPredicate:predicate];
    NSManagedObjectContext *context = [delegate.coreDataBridge managedObjectContext];
    __weak typeof (self) wSelf = self;
    [context executeAsyncFetchRequest:request completion:^(NSArray *objects, NSError *error) {
        wSelf.dataSource = objects;
    }];
}

- (void)updateChartView{
    NSArray *description = [MPExtension getTransactionTypes];
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:[self.dataSource[0] doubleValue] color:PNRed description:description[0]],
                       [PNPieChartDataItem dataItemWithValue:[self.dataSource[1] doubleValue]  color:PNBlue description:description[1]],
                       [PNPieChartDataItem dataItemWithValue:[self.dataSource[2] doubleValue] color:PNGreen description:description[2]],
                       [PNPieChartDataItem dataItemWithValue:[self.dataSource[3] doubleValue] color:PNBrown description:description[3]]
                       ];
    [_pieChart updateChartData:items];
    [_pieChart strokeChart];
    [self addLegend];
}

- (void)action:(id)sender{
    UISegmentedControl *segmentControl = (id)sender;
    [self getDataByPeriod:(MPPeriodType)segmentControl.selectedSegmentIndex];
//    NSArray *results = [context executeFetchRequest:request error:nil];
//    id sum = [results valueForKeyPath:@"@sum.trans_amount"];
}

#pragma mark - delegate

- (void)userClickedOnPieIndexItem:(NSInteger)pieIndex{
    id sum = _dataSource[pieIndex];
    self.moveLabel.text = [NSString stringWithFormat:@"%@",sum];
    if (![self.moveView isHidden]){
        [self.moveView swing:NULL];
        [self.moveLabel swing:NULL];
    }else{
        [self.moveView setHidden:NO];
        [self.moveLabel setHidden:NO];
        [self.moveLabel snapIntoView:self.view direction:DCAnimationDirectionTop];
        [self.moveView snapIntoView:self.view direction:DCAnimationDirectionLeft];

    }
}


@end
