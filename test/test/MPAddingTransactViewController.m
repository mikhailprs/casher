//
//  MPAddingTransactViewController.m
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPAddingTransactViewController.h"
#import "Companion+CoreDataProperties.h"
#import "Transaction+CoreDataProperties.h"
#import "MPInputTextView.h"
#import <Masonry/Masonry.h>
#import "MPLocationManager.h"
#import "MPTransTypeSwitcherView.h"
#import "MPExtension.h"
#import "Balance+CoreDataProperties.h"
#import "NSDate+Formatter.h"
#import "AppDelegate.h"

@interface MPAddingTransactViewController () <OPTKTransactionTypeSwitchesViewProtocol>

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) MPInputTextView *view_input;
@property (strong, nonatomic) UIButton *btn_confirmTransaction;
@property (strong, nonatomic) NSString *street;
@property (strong, nonatomic) dispatch_queue_t queueSerial;
@property (strong, nonatomic) MPTransTypeSwitcherView *view_typeSwitch;
@property (strong, nonatomic) NSArray *arrayWithTypes;
@property (assign, nonatomic) MPTransactionType transactionType;
@end


@implementation MPAddingTransactViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    MPLocationManager *locationManager = [MPLocationManager sharedLocationManager];
    locationManager.locationFinder = ^(NSString *str1 , NSString *str2){
        _street = str1;
    };
    
    [self makeUI];
    [self makeConstraints];
    [self printAllObjects];
    [self initDefaultValues];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
}


#pragma mark - init methods

- (void)initDefaultValues{
    _transactionType = Products;
}

#pragma mark - init UI

- (void)makeUI{
    [self createInputView];
    [self createTransactionButton];
    [self createTransTypeSwitcher];
}


- (void)createInputView{
    _view_input = [[MPInputTextView alloc] init];
    [self.view addSubview:self.view_input];
    [self.view_input.lbl_titile setText:@"Enter amount"];
}


- (void)createTransactionButton{
    _btn_confirmTransaction = [[UIButton alloc] init];
    [self.view addSubview:self.btn_confirmTransaction];
    [self.btn_confirmTransaction setTitle:@"Transaction" forState:UIControlStateNormal];
    self.btn_confirmTransaction.backgroundColor = [UIColor blackColor];
    [self.btn_confirmTransaction addTarget:self action:@selector(actionTransaction:) forControlEvents:UIControlEventTouchDown];
}

- (void)createTransTypeSwitcher{
    _view_typeSwitch = [[MPTransTypeSwitcherView alloc] init];
    _view_typeSwitch.leftLabel.text = @"Type:";
    _view_typeSwitch.typeSwitchesProtocol = self;
    [self.view addSubview:self.view_typeSwitch];
}

#pragma mark - init constraints

- (void)makeConstraints{
    [self makeInputViewConstraints];
    [self makeTransTypeSwitchConstraints];
    [self makeTransactionButtonConstraints];
}

- (void)makeInputViewConstraints{
    [self.view_input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0.f);
        make.top.equalTo(self.view.mas_top).with.offset(70.f);
        make.height.equalTo(@(50.f));
    }];
}
- (void)makeTransTypeSwitchConstraints{
    [self.view_typeSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0.f);
        make.right.equalTo(self.view.mas_right).with.offset(0.f);
        make.top.equalTo(self.view_input.mas_bottom).with.offset(10.f);
        make.height.equalTo(@(25.f));
    }];
}

- (void)makeTransactionButtonConstraints{
    [self.btn_confirmTransaction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(50.f);
        make.right.equalTo(self.view.mas_right).with.offset(-50.f);
        make.top.equalTo(self.view_typeSwitch.mas_bottom).with.offset(10.f);
        make.height.equalTo(@(25.f));
    }];
}





#pragma mark - IB action

- (void)actionTransaction:(UIButton *)sender{
    dispatch_async(self.queueSerial, ^{
        Transaction *transaction = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Transaction class]) inManagedObjectContext:self.context];
        transaction.trans_amount = [NSNumber numberWithDouble:[self.view_input.tf_amount.text doubleValue]];
        transaction.trans_time = [NSDate date];
        if (!_street){
            MPLocationManager *localManager = [MPLocationManager sharedLocationManager];
            _street = localManager.lastKnownStreet;
        }
        transaction.trans_location = self.street;
        transaction.trans_type = [NSNumber numberWithInt:self.transactionType];
        [self.context insertObject:transaction];
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Balance"];
        NSError *error = nil;
        NSArray *results = [self.context executeFetchRequest:request error:&error];
        if (!results) {
            NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
            abort();
        }
        if (results.count){
            Balance *balance = [results firstObject];
            balance.loss = transaction;
            [self.context processPendingChanges];
        }else{
            Balance *balance = [NSEntityDescription insertNewObjectForEntityForName:@"Balance" inManagedObjectContext:self.context];
            balance.loss= transaction;
            [self.context insertObject:balance];
        }

        [self.context save:nil];
    });
    
    NSLog(@"JEsus");
}


#pragma mark - setters and getters

- (NSManagedObjectContext *)context{
    if (!_context){
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        _context = [delegate.coreDataBridge managedObjectContext];
    }
    return _context;
}

- (void)setStreet:(NSString *)street{
    if(!_street){
        _street = street;
    }
}

- (dispatch_queue_t)queueSerial{
    if (_queueSerial == nil) {
        _queueSerial = dispatch_queue_create("com.mp.addingtransction", DISPATCH_QUEUE_SERIAL);
    }
    return _queueSerial;
}


//////// Testing core data methods


- (Transaction *)addNewTransaction{
    Transaction *transaction = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Transaction class]) inManagedObjectContext:self.context];
    transaction.trans_amount = [NSNumber numberWithDouble:200];
    return transaction;
}

- (Companion *)addNewCompanion{
    Companion *companion = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Companion class]) inManagedObjectContext:self.context];
    companion.comp_name = @"Mukola";
    return companion;
}

- (NSArray *)getAllObjects {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:self.context];
    [request setEntity:description];
    NSError *requestError = nil;
    NSArray *resultArray = [self.context executeFetchRequest:request error:&requestError];
    if (requestError){
        NSLog(@"%@",[requestError localizedDescription]);
    }
    return resultArray;
}

- (void)deleteAllObjects {
    NSArray *allObject = [self getAllObjects];
    for (id object in allObject){
        [self.context deleteObject:object];
    }
    [self.context save:nil];
}

- (void)printAllObjects {
    NSArray *allObject = [self getAllObjects];
    for (id object in allObject){
        NSLog(@"%@",object);
    }
}

- (void)thingsForAdding{
    
    Companion *companion = [self addNewCompanion];
    Transaction *transact = [self addNewTransaction];

}

- (void)savePerson{
    Transaction *tr = [self addNewTransaction];
    Companion *comp = [self addNewCompanion];
    [tr addCompanionObject:comp];
    [self.context insertObject:tr];
    [self.context save:nil];
}


#pragma mark - OPTKTransactionTypeSwitchesViewProtocol

- (NSArray *)dataSourceForView{
    if (!_arrayWithTypes) {
        _arrayWithTypes = [MPExtension getTransactionTypes];
    }
    return _arrayWithTypes;

}
- (UIViewController *)viewControllerForPresenter{
    return self;
}
- (NSString *)cancelTextForAction{
    return @"Cancel";
}
- (void)transactionTypeSwitcherView:(MPTransTypeSwitcherView *)view didSelectedValueAtIndex:(NSInteger)idx{
    NSLog(@"%ld",(long)idx);
    _transactionType = (MPTransactionType)idx;
}


@end
