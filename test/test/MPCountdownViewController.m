//
//  MPCountdownViewController.m
//  Jewarator
//
//  Created by Michail on 29.06.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPCountdownViewController.h"
#import "MPStatisticView.h"
#import "NSManagedObjectContext+SRFetchAsync.h"
#import "Earning+CoreDataProperties.h"
#import "AppDelegate.h"
#import "MPExtension.h"
#import "Transaction+CoreDataProperties.h"

@interface MPCountdownViewController ()


@property (strong, nonatomic) MPStatisticView *lastEarnView;
@property (strong, nonatomic) dispatch_source_t timer;
@property (strong, nonatomic) NSDate *lastEarndate;
@property (strong, nonatomic) NSArray *transactionsDate;

@end

@implementation MPCountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStartUp];
    // Do any additional setup after loading the view.
}

- (void)dealloc{
    [self stopBackgroundHandlers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - accessors

- (dispatch_source_t)timer{
    if (_timer == nil) {
        dispatch_queue_t queue = dispatch_get_main_queue();//dispatch_queue_create("com.tradersoft.opteck.timerQueue", DISPATCH_QUEUE_SERIAL);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_time_t timeStart = dispatch_time(DISPATCH_TIME_NOW, 0);
        uint64_t interval = (uint64_t)(1.f * NSEC_PER_SEC);
        dispatch_source_set_timer(_timer, timeStart, interval, 0);
        __weak typeof(self) wSelf = self;
        dispatch_source_set_event_handler(_timer, ^{
            [wSelf update];
        });
        dispatch_source_set_cancel_handler(_timer, ^{
            _timer = nil;
        });
    }
    return _timer;
}




#pragma mark - init

- (void)initStartUp{
    [self startBackgoundHandler];
    self.view.backgroundColor = [UIColor whiteColor];
    [self makeFetches];
    [self makeUI];
    
}

#pragma mark - timer handelrs

- (void)stopBackgroundHandlers{
    @try{
        if(_timer != nil){
            dispatch_source_cancel(_timer);
            _timer = nil;
        }
    }
    @finally{
    }
}

- (void)startBackgoundHandler{
    if (_timer == nil) {
        dispatch_resume(self.timer);
    }
}

- (void)update{
    if (_lastEarndate){
        self.lastEarnView.lbl_right.text = [self formattedDate:self.lastEarndate];
    }
    
}

- (void)makeUI{
    _lastEarnView = [[MPStatisticView alloc] init];
    _lastEarnView.lbl_left.text = @"Last earn time pass:";
    _lastEarnView.lbl_left.textColor = [UIColor redColor];
    [self.view addSubview:self.lastEarnView];
    
    [self.lastEarnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(20.);
        make.right.equalTo(self.view.mas_right).with.offset(-20.f);
        make.top.equalTo(self.view.mas_top).with.offset(70.);
        make.height.equalTo(@35.f);
    }];
}


- (void)makeFetches{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Earning"];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate.coreDataBridge managedObjectContext];
    __weak typeof (self) wSelf = self;
    
    [context executeAsyncFetchRequest:request completion:^(NSArray *objects, NSError *error) {
        Earning *lastEarn = objects.lastObject;
        wSelf.lastEarndate = lastEarn.earn_date;
    }];
    
    NSFetchRequest *transactionRequest = [NSFetchRequest fetchRequestWithEntityName:@"Transaction"];
    [context executeAsyncFetchRequest:transactionRequest completion:^(NSArray *objects, NSError *error) {
        wSelf.transactionsDate = objects;
    }];

}

- (void)setTransactionsDate:(NSArray *)transactionsDate{
    if (!transactionsDate.count) return;
    NSMutableArray *array = [NSMutableArray new];
    NSInteger types = [MPExtension getTransactionCount];
    for (int i = 0 ; i < types; i++){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"trans_type = %d",i];
        NSArray *data = [transactionsDate filteredArrayUsingPredicate:predicate];
        id lastObject = [data lastObject];
        if (!lastObject) continue;
        [array addObject:[data lastObject]];
    }
    
    [array sortUsingComparator:^NSComparisonResult(Transaction *obj1, Transaction *obj2) {
        return [obj1.trans_time compare:obj2.trans_time];
   }];
    _transactionsDate = [array copy];

}

- (NSString *)formattedDate:(NSDate *)startDate{
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond
                                                                  fromDate:startDate
                                                                    toDate:[NSDate date]
                                                                   options:0];

    NSInteger day = (int)[component day];
    NSInteger second = (int)[component second];
    NSInteger minute = (int)[component minute];
    NSString *time;
    BOOL canToSell = NO;
    if(day > 0)
    {
        time = [NSString stringWithFormat:@"%2dd %02dh:%02dm:%02ds",(int)[component day], (int)[component hour], (int)[component minute], (int)[component second]];
        canToSell = YES;
        
    }
    else if (second >= 0 && minute >= 0 && day == 0) {
        time = [NSString stringWithFormat:@"%02dh:%02dm:%02ds", (int)[component hour], (int)[component minute], (int)[component second]];
        canToSell = YES;
    }
    else {
        time = @"00h:00m:00s";
    }
    return time;
}
@end
