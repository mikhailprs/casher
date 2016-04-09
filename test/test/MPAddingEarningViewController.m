//
//  MPAddingEarningViewController.m
//  test
//
//  Created by Mikhail Prysiazhniy on 24.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPAddingEarningViewController.h"
#import "MPInputTextView.h"
#import <Masonry/Masonry.h>
#import "Earning+CoreDataProperties.h"
#import "Balance+CoreDataProperties.h"
@interface MPAddingEarningViewController ()

@property (strong, nonatomic) MPInputTextView           *view_input;
@property (strong, nonatomic) UIButton                  *btn_confirm;
@property (strong, nonatomic) NSManagedObjectContext    *context;

@end

@implementation MPAddingEarningViewController

#pragma mark - view controller methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStartUp];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
}

#pragma mark - init methods

- (void)initStartUp{
    [self makeUI];
    [self makeConstraints];
}

- (void)makeUI{
    [self createInputView];
    [self createConfirmButtton];
}

- (void)makeConstraints{
    [self makeInputViewConstraints];
    [self makeConfirmButtonConstraint];
}

- (void)createInputView{
    _view_input = [[MPInputTextView alloc] init];
    [self.view_input.lbl_titile setText:@"Earning:"];
    [self.view addSubview:self.view_input];
}


- (void)makeInputViewConstraints{
    [self.view_input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0.f);
        make.top.equalTo(self.view.mas_top).with.offset(70.f);
        make.height.equalTo(@(60.f));
    }];
}


- (void)createConfirmButtton{
    _btn_confirm = [[UIButton alloc] init];
    [self.btn_confirm setTitle:@"Confirm" forState:UIControlStateNormal];
    self.btn_confirm.backgroundColor = [UIColor grayColor];
    [self.btn_confirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn_confirm addTarget:self action:@selector(confirnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn_confirm];
}

- (void)makeConfirmButtonConstraint{
    [self.btn_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(70.f);
        make.right.equalTo(self.view.mas_right).with.offset(-70);
        make.top.equalTo(self.view_input.mas_bottom).with.offset(20.f);
        make.height.equalTo(@50.f);
    }];
}

#pragma mark - accessors


- (NSManagedObjectContext *)context{
    if (!_context){
        id delegate = [[UIApplication sharedApplication] delegate];
        _context = [delegate managedObjectContext];
    }
    return _context;
}


#pragma mark - common

- (void)confirnAction{
    Earning *earning = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Earning class]) inManagedObjectContext:self.context];
    
    earning.earn_amount = [NSNumber numberWithDouble:[self.view_input.tf_amount.text doubleValue]];
    earning.earn_date = [NSDate date];
    [self.context insertObject:earning];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Balance"];
    NSError *error = nil;
    NSArray *results = [self.context executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    if (results.count){
        Balance *balance = [results firstObject];
        balance.profit = earning;
        NSNumber *num = [NSNumber numberWithFloat:([balance.amount floatValue] + [earning.earn_amount floatValue])];
        balance.amount = num;
        [self.context processPendingChanges];
    }else{
        Balance *balance = [NSEntityDescription insertNewObjectForEntityForName:@"Balance" inManagedObjectContext:self.context];
        balance.profit = earning;
        balance.amount = earning.earn_amount;
        [self.context insertObject:balance];
    }
    [self.context save:nil];
}
@end
