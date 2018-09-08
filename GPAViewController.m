//
//  GPAViewController.m
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 26/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import "GPAViewController.h"
#import "CoreViewController.h"
#import "AppDelegate.h"
#import "Mark+CoreDataProperties.h"


@interface GPAViewController ()

@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong)NSFetchedResultsController *fetchedResultsController;

@end

@implementation GPAViewController

@synthesize selectedStudent;

-(NSManagedObjectContext*) managedObjectContext{
    
    return [(AppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _studentID.enabled = NO;
    _studentFirstName.enabled = NO;
    _studentLastName.enabled = NO;
    _studentGPA.enabled = NO;
    
    _studentID.text = selectedStudent.studentID.stringValue;
    _studentFirstName.text = selectedStudent.studentFirstName;
    _studentLastName.text = selectedStudent.studentLastName;
//    _studentGPA.text = [NSString stringWithFormat:@"%g", gpa];
    _studentGPA.text = selectedStudent.studentGPA;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backButton:(UIBarButtonItem *)sender {
    
    [super cancelAndDismiss];
}


@end
