//
//  MPTransactionsHistoryVIewControllerViewController.m
//  test
//
//  Created by Mikhail Prysiazhniy on 08.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPTransactionsHistoryVIewControllerViewController.h"
#import <Masonry/Masonry.h>
#import <CoreData/CoreData.h>
#import "Companion+CoreDataProperties.h"
#import "Transaction+CoreDataProperties.h"
#import "MPTransactionHistoryCell.h"
#import "MPExtension.h"

@interface MPTransactionsHistoryVIewControllerViewController () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSArray *arrayOfTypes;

@end

@implementation MPTransactionsHistoryVIewControllerViewController

static NSString *const cellHistoryIdentifier = @"transactionHistoryIdentifier";
//@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // Fail
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"MPTransactionHistoryCell" bundle:nil] forCellReuseIdentifier:cellHistoryIdentifier];
//    [self deleteAllObjects];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - accesors

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    // на сколько понял кеш для search норм использовать когда по буквам поиск
    [NSFetchedResultsController deleteCacheWithName:@"Root"];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"trans_amount" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:5];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:_managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    _fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (NSManagedObjectContext *)managedObjectContext{
    if (!_managedObjectContext){
        id delegate = [[UIApplication sharedApplication] delegate];
        _managedObjectContext = [delegate managedObjectContext];
    }
    return _managedObjectContext;
}



#pragma mark - delegates methods


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

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

#pragma mark - helper methods


- (void)configureCell:(MPTransactionHistoryCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Transaction *transaction = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.lbl_amount.text = [NSString stringWithFormat:@"%@",transaction.trans_amount];
    cell.lbl_place.text = [NSString stringWithFormat:@"%@",transaction.trans_location];
    if (!_arrayOfTypes){
        _arrayOfTypes = [MPExtension getTransactionTypes];
    }
    cell.lbl_type.text = [NSString stringWithFormat:@"%@",self.arrayOfTypes[[transaction.trans_type integerValue]]];
    cell.lbl_time.text = [NSString stringWithFormat:@"%@",transaction.trans_time];
    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",
//                                 info.city, info.state];
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
