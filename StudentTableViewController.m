//
//  StudentTableViewController.m
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 24/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import "StudentTableViewController.h"
#import "AppDelegate.h"
#import "AddStudentViewController.h"
#import "EditStudentViewController.h"
#import "CustomTableViewCell.h"


@interface StudentTableViewController ()

@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong)NSFetchedResultsController *fetchedResultsController;


@end

@implementation StudentTableViewController

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

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

-(NSManagedObjectContext*) managedObjectContext{
    
    return [(AppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell* )sender{
    
    if ([[segue identifier]isEqualToString:@"addStudent"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        AddStudentViewController *addStudentViewController = (AddStudentViewController*) navigationController.topViewController;
        
        Student *addStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:[self managedObjectContext]];
        
        addStudentViewController.addStudent = addStudent;
    }
    
    if ([[segue identifier]isEqualToString:@"editStudent"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        EditStudentViewController *editStudentViewController = (EditStudentViewController*) navigationController.topViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        Student *editStudent = (Student*)[self.fetchedResultsController objectAtIndexPath:indexPath];
        editStudentViewController.editStudent = editStudent; 
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [[self.fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    Student *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString *studentFullName = [NSString stringWithFormat:@"%@ %@", student.studentFirstName, student.studentLastName];
    
    customCell.customCellFirstLabel.text = [student.studentID stringValue];
    customCell.customCellSecondLabel.text = studentFullName;
    customCell.customCellImage.image = [UIImage imageWithData:student.studentPhoto];

    
    
    return customCell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *context = [self managedObjectContext];
        Student *studentToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:studentToDelete];
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            NSLog(@"Error! %@", error);
        }
    }
}


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
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"studentID" ascending:YES];
    
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
            Student *changeStudent = [self.fetchedResultsController objectAtIndexPath:indexPath];
            CustomTableViewCell *customCell = [tableView cellForRowAtIndexPath:indexPath];
            
            NSString *studentFullName = [NSString stringWithFormat:@"%@ %@", changeStudent.studentFirstName, changeStudent.studentLastName];
            
            customCell.customCellFirstLabel.text = [changeStudent.studentID stringValue];
            customCell.customCellSecondLabel.text = studentFullName;
            customCell.customCellImage.image = [UIImage imageWithData:changeStudent.studentPhoto];
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

@end
