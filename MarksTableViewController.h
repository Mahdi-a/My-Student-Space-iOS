//
//  MarksTableViewController.h
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 24/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student+CoreDataProperties.h"
#import "Mark+CoreDataProperties.h"
#import "MarksTableViewController.h"

@interface MarksTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong)Student *selectedStudent;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addMarkButton;

- (IBAction)cancel:(UIBarButtonItem *)sender;




@end
