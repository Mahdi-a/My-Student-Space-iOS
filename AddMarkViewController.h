//
//  AddMarkViewController.h
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 24/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreViewController.h"
#import "Student+CoreDataProperties.h"
#import "Mark+CoreDataProperties.h"


@interface AddMarkViewController : CoreViewController<UITextFieldDelegate, UIPickerViewDelegate>{
    NSMutableArray *dataPicker;
    UIPickerView *pickerView;
}

@property (nonatomic, strong) Student *marksStudent;

@property (nonatomic, strong) Mark *addMark;

@property (strong, nonatomic) IBOutlet UITextField *unitCode;

@property (strong, nonatomic) IBOutlet UITextField *unitName;

@property (strong, nonatomic) IBOutlet UITextField *unitGrade;


- (IBAction)cancel:(UIBarButtonItem *)sender;

- (IBAction)save:(UIBarButtonItem *)sender;

@end
