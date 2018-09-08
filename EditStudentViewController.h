//
//  EditStudentViewController.h
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 25/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student+CoreDataProperties.h"
#import "CoreViewController.h"


@interface EditStudentViewController : CoreViewController<UITextFieldDelegate, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    NSMutableArray *dataPicker;
    UIPickerView *pickerView;
    UIDatePicker *datePicker;
    
    UIImagePickerController *studentImagePicker;
    UIImage *studentImage;
    IBOutlet UIImageView *imageView;
}


@property (strong, nonatomic) Student *editStudent;

@property (strong, nonatomic) IBOutlet UITextField *ID;

@property (strong, nonatomic) IBOutlet UITextField *firstName;

@property (strong, nonatomic) IBOutlet UITextField *lastName;

@property (strong, nonatomic) IBOutlet UITextField *gender;

@property (strong, nonatomic) IBOutlet UITextField *dateOfBirth;

@property (strong, nonatomic) IBOutlet UITextField *address;

@property (strong, nonatomic) IBOutlet UITextField *course;

@property (strong, nonatomic) IBOutlet UIImageView *studentPhoto;

@property (retain, nonatomic) IBOutlet UIButton *takePhotoButton;

@property (retain, nonatomic) IBOutlet UIButton *choosePhotoButton;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *editSaveButton;

- (IBAction)cancel:(UIBarButtonItem *)sender;

- (IBAction)editSave:(UIBarButtonItem *)sender;

-(IBAction)TakePhoto;

-(IBAction)ChoosePhoto;

@end
