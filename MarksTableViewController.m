//
//  MarksTableViewController.m
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 24/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import "MarksTableViewController.h"
#import "AppDelegate.h"
#import "AddMarkViewController.h"

@interface MarksTableViewController ()

@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong)NSManagedObjectContext *managedObjectContextGPA;

@property (nonatomic, strong)NSFetchedResultsController *fetchedResultsController;



@end

@implementation MarksTableViewController

@synthesize selectedStudent;

-(NSManagedObjectContext*) managedObjectContext{
    
    return [(AppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
}

-(NSManagedObjectContext*) managedObjectContextGPA{
    
    return [(AppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"AddMark"]) {
        
        UINavigationController *navigationController = [segue destinationViewController];
        
        AddMarkViewController *addMarkViewController = (AddMarkViewController*)navigationController.topViewController;
        
        Mark *addMark = [NSEntityDescription insertNewObjectForEntityForName:@"Mark" inManagedObjectContext:[self managedObjectContext]];
    
        addMarkViewController.marksStudent = self.selectedStudent;
        
        addMarkViewController.addMark = addMark;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [self.tableView reloadData];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSManagedObjectContext *context = [self managedObjectContextGPA];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Mark" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    //    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"markUnitID" ascending:YES];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"student = %@", selectedStudent];
    
    [fetchRequest setPredicate:predicate];
    
    //    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    NSArray *grades = [self.managedObjectContextGPA executeFetchRequest:fetchRequest error:nil];
    
    if ([grades count] > 0) {
        
        float sumOfMarks = 0;
        
        for (Mark *unitsResult in grades) {
            
            NSString *mark = unitsResult.markUnitGrade;
            
            if ( [mark  isEqual: @"HD"]) {
                sumOfMarks = sumOfMarks + 7;
            }
            
            if ( [mark  isEqual: @"D"]) {
                sumOfMarks = sumOfMarks + 6;
            }
            
            if ( [mark  isEqual: @"C"]) {
                sumOfMarks = sumOfMarks + 5;
            }
            
            if ( [mark  isEqual: @"P"]) {
                sumOfMarks = sumOfMarks + 4;
            }
            
            if ( [mark  isEqual: @"CP"]) {
                sumOfMarks = sumOfMarks + 3;
            }
            
            if ( [mark  isEqual: @"F"]) {
                sumOfMarks = sumOfMarks + 0;
            }
        }
        
        float gpa = sumOfMarks / ([grades count]);
        
        selectedStudent.studentGPA = [NSString stringWithFormat:@"%1.2f", gpa];
        
        NSError *error= nil;
        
        if([self.managedObjectContextGPA hasChanges]){
            if(![self.managedObjectContext save:&error]){
                NSLog(@"Save Failed: %@", [error localizedDescription]);
            }else{
                NSLog(@"Save Succeeded");
            }
        }
        
        
    }

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    NSError *error = nil;
    
    if (![[self fetchedResultsController]performFetch:&error]){
        NSLog(@"Error! %@", error);
        abort();
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    if ([sectionInfo numberOfObjects] > 4) {
        
        _addMarkButton.enabled = NO;
    }
    else{
        _addMarkButton.enabled = YES;
    }
    
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    Mark *mark = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString *markDetails = [NSString stringWithFormat:@"%@ - %@", mark.markUnitName, mark.markUnitGrade];
    
    cell.textLabel.text = [mark.markUnitID stringValue];
    
    cell.detailTextLabel.text = markDetails;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *context = [self managedObjectContext];
        Mark *MarkToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:MarkToDelete];
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            NSLog(@"Error! %@", error);
        }
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Fetched Results Controller Section

-(NSFetchedResultsController*)fetchedResultsController{
    
    if (_fetchedResultsController != nil){
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Mark" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"markUnitID" ascending:YES];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"student = %@", selectedStudent];
    
    [fetchRequest setPredicate:predicate];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    fetchRequest.sortDescriptors = sortDescriptors;
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

#pragma mark - Fetched Results Controller Delegates

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    UITableView *tableView = self.tableView;
    
    switch (type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject: newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:{
            Mark *changeMark = [self.fetchedResultsController objectAtIndexPath:indexPath];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = changeMark.markUnitID.stringValue;
        }
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
