//
//  CoreViewController.m
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 24/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import "CoreViewController.h"
#import "AppDelegate.h"

@interface CoreViewController ()

//@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation CoreViewController

-(NSManagedObjectContext*)managedObjectContext{
    
    return [(AppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)cancelAndDismiss{
    
    
    [self.managedObjectContext rollback];

    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)saveAndDismiss{
    
    NSError *error= nil;
    
    if([self.managedObjectContext hasChanges]){
        if(![self.managedObjectContext save:&error]){
            NSLog(@"Save Failed: %@", [error localizedDescription]);
        }else{
            NSLog(@"Save Succeeded");
        }
    }

        [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
