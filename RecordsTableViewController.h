//
//  RecordsTableViewController.h
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 24/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student+CoreDataProperties.h"

@interface RecordsTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property(nonatomic, strong)Student *student;

@end
