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
#import "MPButton.h"
#import "MPAlertAction.h"
#import "MPEarningHistoryViewController.h"
#import "ViewController.h"


@interface MPAddingEarningViewController ()  <UITextFieldDelegate>

@property (strong, nonatomic) MPInputTextView           *view_input;
@property (strong, nonatomic) MPButton                  *btn_confirm;
@property (strong, nonatomic) NSManagedObjectContext    *context;

@end

@implementation MPAddingEarningViewController

#pragma mark - view controller methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStartUp];
}

- (void)viewWillAppear:(BOOL)animated{
    self.btn_confirm.highlighted = NO;
    self.btn_confirm.selected = NO;
}

#pragma mark - init methods

- (void)initStartUp{
    self.navigationItem.title = @"New earn";
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
    [self.view_input.tf_amount setDelegate:self];\
//    [self.view_input.tf_amount setKeyboardType:UIKeyboardTypeNumberPad];
    [self.view_input.lbl_titile setText:@"Earning:"];
    [self.view addSubview:self.view_input];
}


- (void)makeInputViewConstraints{
    [self.view_input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0.f);
        make.top.equalTo(self.view.mas_top).with.offset(80.f);
        make.height.equalTo(@(70.f));
    }];
}


- (void)createConfirmButtton{
    _btn_confirm = [[MPButton alloc] init];
    [self.btn_confirm setTitle:@"Confirm" forState:UIControlStateNormal];
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
    if ([self.view_input.tf_amount.text isEqualToString:@""]){
        return;
    }
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
        [self.context processPendingChanges];
    }else{
        Balance *balance = [NSEntityDescription insertNewObjectForEntityForName:@"Balance" inManagedObjectContext:self.context];
        balance.profit = earning;
        [self.context insertObject:balance];
    }
    [self.context save:&error];
    
   
    if (error){
        NSLog(@"%@", [error localizedDescription]);
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Successful" message:@"Go to the next screen" preferredStyle:UIAlertControllerStyleAlert];
        
        
       
        void(^handlerActionController)(UIAlertAction *action) = ^(UIAlertAction *action){
            MPAlertAction *actionType = (id)action;
            [self didSelectedAtIndex:actionType.index];
        };
             
        MPAlertAction *alertActionOK = [MPAlertAction actionWithTitle:@"Balance" style:UIAlertActionStyleDefault handler:handlerActionController];
        alertActionOK.index = 0;
        
        MPAlertAction *alertActionNO = [MPAlertAction actionWithTitle:@"Earn History" style:UIAlertActionStyleDefault handler:handlerActionController];
        alertActionNO.index = 1;
        
        [alertController addAction:alertActionOK];
        [alertController addAction:alertActionNO];
        self.view_input.tf_amount.text = @"";
        [self.view_input.tf_amount resignFirstResponder];
        [self presentViewController: alertController animated:YES completion:nil];
    }
    
}

- (void) didSelectedAtIndex:(NSInteger)index{
    __weak typeof (self) wSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (index == 0){
            [wSelf.navigationController popViewControllerAnimated:YES];
        }else{
            MPEarningHistoryViewController *vc = [MPEarningHistoryViewController new];
            [wSelf.navigationController pushViewController:vc animated:YES];
        }
    });
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([textField isEditing]){
        [textField resignFirstResponder];
    }
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(string.length > 0)
    {
        NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:string];
        
        BOOL stringIsValid = [numbersOnly isSupersetOfSet:characterSetFromTextField];
        return stringIsValid;
    }
    return YES;
}
@end
