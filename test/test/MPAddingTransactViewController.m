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
@interface MPAddingTransactViewController ()

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) MPInputTextView *view_input;
@end

@implementation MPAddingTransactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self savePerson];
    [self printAllObjects];
    [self deleteAllObjects];
    [self createInputView];
    [MPLocationManager sharedLocationManager];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - init methods

- (void)createInputView{
    _view_input = [[MPInputTextView alloc] init];
    [self.view addSubview:self.view_input];
    [self.view_input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0.f);
        make.top.equalTo(self.view.mas_top).with.offset(70.f);
        make.height.equalTo(@(50.f));
    }];
}



#pragma mark - setters and getters

- (NSManagedObjectContext *)context{
    if (!_context){
        id delegate = [[UIApplication sharedApplication] delegate];
        _context = [delegate managedObjectContext];
    }
    return _context;
}

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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
