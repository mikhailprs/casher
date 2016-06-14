//
//  MPTransactionsHistoryVIewControllerViewController.m
//  test
//
//  Created by Mikhail Prysiazhniy on 08.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPTransactionsHistoryViewController.h"
#import <Masonry/Masonry.h>
#import <CoreData/CoreData.h>
#import "Companion+CoreDataProperties.h"
#import "Transaction+CoreDataProperties.h"
#import "MPTransactionHistoryCell.h"
#import "MPExtension.h"
#import "NSDate+Formatter.h"
#import "AppDelegate.h"


@interface MPTransactionsHistoryViewController () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSArray *arrayOfTypes;

@end

@implementation MPTransactionsHistoryViewController

static NSString *const cellHistoryIdentifier = @"transactionHistoryIdentifier";
//@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
//    [self deleteAllObjects];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setup{
     [self.tableView registerClass:[MPTransactionHistoryCell class] forCellReuseIdentifier:cellHistoryIdentifier];
//    [self.tableView setEditing:YES];
    
}

#pragma mark - accesors

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    // на сколько понял кеш для search норм использовать когда по буквам поиск
//    [NSFetchedResultsController deleteCacheWithName:@"Root"];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"trans_time" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:5];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:_managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:nil];
    _fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
    }
   
    return _fetchedResultsController;
}

- (NSManagedObjectContext *)managedObjectContext{
    if (!_managedObjectContext){
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        _managedObjectContext = [delegate.coreDataBridge managedObjectContext];
    }
    return _managedObjectContext;
}



#pragma mark - delegates methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    [self printAllObjects];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MPTransactionHistoryCell *cell =
    [tableView dequeueReusableCellWithIdentifier:cellHistoryIdentifier];
    
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}



#pragma mark - fetchedResultController delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}



#pragma mark - editing rows

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *task = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:task];
        [self.managedObjectContext save:nil];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - helper methods


- (void)configureCell:(MPTransactionHistoryCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Transaction *transaction = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.lbl_amount.text = [NSString stringWithFormat:@"%@",transaction.trans_amount];
    cell.lbl_place.text = [NSString stringWithFormat:@"%@",transaction.trans_location];
    if (!_arrayOfTypes){
        _arrayOfTypes = [MPExtension getTransactionTypes];
    }
    cell.lbl_type.text = [NSString stringWithFormat:@"%@",self.arrayOfTypes[[transaction.trans_type integerValue]]];
    cell.lbl_time.text = [NSString stringWithFormat:@"%@",transaction.trans_time.getFormattedGMTTimeWithoutYear];
}

- (NSArray *)getAllObjects {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    NSError *requestError = nil;
    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError){
        NSLog(@"%@",[requestError localizedDescription]);
    }
    return resultArray;
}



- (void)printAllObjects {
    NSArray *allObject = [self getAllObjects];
    for (id object in allObject){
        Transaction *trans = object;
        
        NSLog(@"%@ %@ %@ %@",trans.trans_amount, trans.trans_time, trans.trans_location, trans.trans_type);
    }
}

- (void)deleteAllObjects{
    NSArray *allObject = [self getAllObjects];
    for (id object in allObject){
        [self.managedObjectContext deleteObject:object];
    }
    [self.managedObjectContext save:nil];
}
@end
