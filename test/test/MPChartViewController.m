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
#import "MPCountingLine.h"
#import "NSDate+Formatter.h"

@interface MPChartViewController () <PNChartDelegate>


@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UISegmentedControl *segmentControl;
@property (strong, nonatomic) PNPieChart *pieChart;
@property (strong, nonatomic) MPCountingLine *products;
@property (strong, nonatomic) MPCountingLine *sport;
@property (strong, nonatomic) MPCountingLine *party;
@property (strong, nonatomic) MPCountingLine *kartoha;
@property (strong, nonatomic) UILabel *moveLabel;


@property (strong, nonatomic) NSString *textTemplate;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) MPCalendarHelper *calendarHelper;
@end


@implementation MPChartViewController

#pragma mark - view controller methods


- (void)viewDidLoad{
    [self initStartUp];
    [self getDataByPeriod:MPWeek];
}

- (void)viewWillAppear:(BOOL)animated{
    
}


#pragma mark - accessors

- (void)setDataSource:(NSArray *)dataSource{
    if(dataSource.count == 0){
        _dataSource = nil;
        self.pieChart.hideValues = YES;
        NSArray *initItem = @[[PNPieChartDataItem dataItemWithValue:0 color:PNRed description:@"NO INFO"]];
        [self.pieChart updateChartData:initItem];
        [self.pieChart strokeChart];
        [self updateStatisticView];
        return;
    }
    self.pieChart.hideValues = NO;
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

- (NSString *)textTemplate{
    if (!_textTemplate){
        _textTemplate = @"Maximum waste for this period is: %@\n it was on :%@";
    }
    return _textTemplate;
}





#pragma mark - make UI

- (void)initStartUp{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createUI];
    [self makeConstraints];
}

- (void)createUI{
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    NSArray *initItem = @[[PNPieChartDataItem dataItemWithValue:0 color:PNRed description:@"NO INFO"]];
    _pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, 0, 0) items:initItem];
    self.pieChart.labelPercentageCutoff = 0.05;
    self.pieChart.hideValues = YES;
    [self.scrollView addSubview:_pieChart];

    _pieChart.delegate = self;

    _pieChart.descriptionTextColor = [UIColor blackColor];
    _pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:10.0];
    [_pieChart strokeChart];
    
    _segmentControl = [[UISegmentedControl alloc] initWithItems:self.calendarHelper.getPeriodsName];
    self.segmentControl.selectedSegmentIndex = 0;
    [self.segmentControl addTarget:self
                            action:@selector(action:)
                  forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:self.segmentControl];
    [self makeCountingStatisticView];
    [self createAnimationView];

    
    
}


- (void)createAnimationView{
    self.moveLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.moveLabel.backgroundColor = [UIColor clearColor];
    self.moveLabel.textAlignment = NSTextAlignmentCenter;
    self.moveLabel.numberOfLines = 2;
    self.moveLabel.adjustsFontSizeToFitWidth = YES;
//    [self.moveLabel sizeToFit];
    [self.moveLabel setHidden:YES];
    [self.scrollView addSubview:self.moveLabel];
    
    [self.moveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@100.f);
        make.top.equalTo(self.kartoha.mas_bottom);
        make.bottom.equalTo(self.scrollView.mas_bottom).with.offset(-10);

    }];
    
}
    
- (void)makeConstraints{
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_top).with.offset(40.f);
        make.centerX.equalTo(self.pieChart.mas_centerX);
        make.height.equalTo(@40.);
        make.width.equalTo(@300.f);
    }];
    
    [self.pieChart mas_makeConstraints:^(MASConstraintMaker *make){
//        make.centerX.centerY.equalTo(self.view);
//        make.left.right.top.bottom.equalTo(self.view).with.offset(0.f);
        make.height.width.equalTo(@300);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.segmentControl.mas_bottom).with.offset(20.f);
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


- (void)makeCountingStatisticView{
    _products = [[MPCountingLine alloc] init];
    self.products.title.text = @"Products";
    self.products.value.format = @"%.0f%";
    _sport = [[MPCountingLine alloc] init];
    self.sport.title.text = @"Sport";
    self.sport.value.format = @"%.0f%";
    _party = [[MPCountingLine alloc] init];
    self.party.title.text = @"Party";
    self.party.value.format = @"%.0f%";
    _kartoha = [[MPCountingLine alloc] init];
    self.kartoha.title.text = @"Kartoha";
    self.kartoha.value.format = @"%.0f%";
    
    [self.view addSubview:self.products];
    [self.view addSubview:self.sport];
    [self.view addSubview:self.party];
    [self.view addSubview:self.kartoha];
    
    [self.products mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@30);
        make.top.equalTo(self.pieChart.mas_bottom).with.offset(30.f);
    }];
    
    [self.sport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@30);
        make.top.equalTo(self.products.mas_bottom).with.offset(10.f);
    }];
    
    [self.party mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@30);
        make.top.equalTo(self.sport.mas_bottom).with.offset(10.f);
    }];
    
    [self.kartoha mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@30);
        make.top.equalTo(self.party.mas_bottom).with.offset(10.f);
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
    [self updateStatisticView];

    
}

- (void)updateStatisticView{
    [self.products.value countFromCurrentValueTo:[self.dataSource[0] floatValue]];
    [self.sport.value countFromCurrentValueTo:[self.dataSource[1] floatValue]];
    [self.party.value countFromCurrentValueTo:[self.dataSource[2] floatValue]];
    [self.kartoha.value countFromCurrentValueTo:[self.dataSource[3] floatValue]];
}



- (void)action:(id)sender{
    UISegmentedControl *segmentControl = (id)sender;
    [self.moveLabel setHidden:YES];
    [self getDataByPeriod:(MPPeriodType)segmentControl.selectedSegmentIndex];
//    NSArray *results = [context executeFetchRequest:request error:nil];
//    id sum = [results valueForKeyPath:@"@sum.trans_amount"];
}

#pragma mark - delegate

- (void)userClickedOnPieIndexItem:(NSInteger)pieIndex{
    if(!_dataSource) return;
    id sum = _dataSource[pieIndex];
    if (![self.moveLabel isHidden]){
        [self.moveLabel swing:NULL];
    }else{
        [self.moveLabel setHidden:NO];
        [self.moveLabel snapIntoView:self.scrollView direction:DCAnimationDirectionBottom];
    }
    [self anotherFetch:pieIndex];
    
}

- (void)anotherFetch:(NSInteger)index{
    NSMutableArray *compaundPredicate = [NSMutableArray new];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];
    NSPredicate *predicate = [self.calendarHelper periodInterval:(MPPeriodType)self.segmentControl.selectedSegmentIndex];
    if (predicate) [compaundPredicate addObject:predicate];
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"trans_type = %d",index];
    if (predicate2) [compaundPredicate addObject:predicate2];
//    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"trans_amount == max(trans_amount)"];
    NSCompoundPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:compaundPredicate];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [request setPredicate:compoundPredicate];
    NSManagedObjectContext *context = [delegate.coreDataBridge managedObjectContext];
    __weak typeof (self) wSelf = self;
    [context executeAsyncFetchRequest:request completion:^(NSArray *objects, NSError *error) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"trans_amount == max(trans_amount)"];
        
        NSArray *mutable = [objects sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            Transaction *trans1 = obj1;
            Transaction *trans2 = obj2;
            if (trans1.trans_amount > trans2.trans_amount){
                return NSOrderedAscending;
            }else{
                return NSOrderedDescending;
            }
        }];
        Transaction *neededValue = mutable.firstObject;
        NSString *date = neededValue.trans_time.getFormattedGMTTimeWithoutYear;
        if (neededValue.trans_location){
            date = [date stringByAppendingString:neededValue.trans_location];
        }
        self.moveLabel.text = [NSString stringWithFormat:self.textTemplate, neededValue.trans_amount, date];
    }];
    
}


@end
