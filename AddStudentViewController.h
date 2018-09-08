//
//  AddStudentViewController.h
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 24/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreViewController.h"
#import "Student+CoreDataProperties.h"



@interface AddStudentViewController : CoreViewController <UITextFieldDelegate, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    NSMutableArray *dataPicker;
    UIPickerView *pickerView;
    UIDatePicker *datePicker;
    
    UIImagePickerController *studentImagePicker;
    UIImage *studentImage;
    IBOutlet UIImageView *imageView;
    

}

@property (retain, nonatomic) IBOutlet UITextField *test;

@property (nonatomic, strong) Student *addStudent;

@property (strong, nonatomic) IBOutlet UITextField *studentID;

@property (strong, nonatomic) IBOutlet UITextField *studentFirstName;

@property (strong, nonatomic) IBOutlet UITextField *studentLastName;

@property (strong, nonatomic) IBOutlet UITextField *studentGender;

@property (strong, nonatomic) IBOutlet UITextField *studentDateOfBirth;

@property (strong, nonatomic) IBOutlet UITextField *studentAddress;

@property (strong, nonatomic) IBOutlet UITextField *studentCourse;

@property (strong, nonatomic) IBOutlet UIImageView *studentPhoto;

- (IBAction)cancel:(UIBarButtonItem *)sender;

- (IBAction)save:(UIBarButtonItem *)sender;

//- (IBAction)addPhotoButton:(id)sender;

-(IBAction)TakePhoto;
-(IBAction)ChoosePhoto;

@end
