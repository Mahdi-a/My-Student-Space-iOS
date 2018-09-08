//
//  GPAViewController.h
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 26/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreViewController.h"
#import "StudentTableViewController.h"
#import "MarksTableViewController.h"
#import "Student+CoreDataProperties.h"
#import "Mark+CoreDataProperties.h"


@interface GPAViewController : CoreViewController

@property(strong, nonatomic) Student *selectedStudent;


@property (strong, nonatomic) IBOutlet UITextField *studentID;

@property (strong, nonatomic) IBOutlet UITextField *studentFirstName;

@property (strong, nonatomic) IBOutlet UITextField *studentLastName;

@property (strong, nonatomic) IBOutlet UITextField *studentGPA;

- (IBAction)backButton:(UIBarButtonItem *)sender;






@end
