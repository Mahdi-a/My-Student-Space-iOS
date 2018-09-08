//
//  EditStudentViewController.m
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 25/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import "EditStudentViewController.h"

@interface EditStudentViewController ()

@end

@implementation EditStudentViewController

@synthesize editStudent;

-(void)TakePhoto{
    
    studentImagePicker = [[UIImagePickerController alloc] init];
    studentImagePicker.delegate = self;
    [studentImagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:studentImagePicker animated:YES completion:NULL];
    [studentImagePicker release];

}

-(void)ChoosePhoto{
    
    studentImagePicker = [[UIImagePickerController alloc] init];
    studentImagePicker.delegate = self;
    [studentImagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:studentImagePicker animated:YES completion:NULL];
    [studentImagePicker release];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
//    studentImage.image 
    studentImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageView setImage:studentImage];
    [self dismissViewControllerAnimated:YES completion:NULL];
    _studentPhoto.image = studentImage;
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataPicker = [[NSMutableArray alloc] init];
    [dataPicker addObject:@"--"];
    [dataPicker addObject:@"Male"];
    [dataPicker addObject:@"Female"];
    
    _gender.delegate = self;
    _dateOfBirth.delegate = self;

    
    _ID.enabled = NO;
    _firstName.enabled = NO;
    _lastName.enabled = NO;
    _gender.enabled = NO;
    _dateOfBirth.enabled = NO;
    _address.enabled = NO;
    _course.enabled = NO;
    
    _takePhotoButton.enabled = NO;
    _choosePhotoButton.enabled = NO;
    
    _ID.borderStyle = UITextBorderStyleNone;
    _firstName.borderStyle = UITextBorderStyleNone;
    _lastName.borderStyle = UITextBorderStyleNone;
    _gender.borderStyle = UITextBorderStyleNone;
    _dateOfBirth.borderStyle = UITextBorderStyleNone;
    _address.borderStyle = UITextBorderStyleNone;
    _course.borderStyle = UITextBorderStyleNone;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSDate *dob = editStudent.studentDateOfBirth;
    NSString *dateOfBirth = [formatter stringFromDate:dob];
    
    _ID.text = editStudent.studentID.stringValue;
    _firstName.text = editStudent.studentFirstName;
    _lastName.text = editStudent.studentLastName;
    _gender.text = editStudent.studentGender;
    _dateOfBirth.text = dateOfBirth;
    _address.text = editStudent.studentAddress;
    _course.text = editStudent.studentCourse;
    _studentPhoto.image = [UIImage imageWithData:self.editStudent.studentPhoto];
    
}

-(void)updateTextField:(id)sender
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    UIDatePicker *picker = (UIDatePicker*)self.dateOfBirth.inputView;
    
    NSDate *dob = picker.date;
    NSString *date = [formatter stringFromDate:dob];
    
    
    self.dateOfBirth.text = date;
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

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    
    if (_gender.editing) {
        
        CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
        pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
        
//        _gender.text = [dataPicker objectAtIndex:0];
        _gender.inputView = pickerView;
        
        pickerView.delegate = self;
    }
    
    if (_dateOfBirth.editing) {
        
        datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
        
        _dateOfBirth.inputView = datePicker;
    }
    
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_gender resignFirstResponder];
}

#pragma mark - UIPickerView Delegate

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [dataPicker count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [dataPicker objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _gender.text = [dataPicker objectAtIndex:row];
}




- (IBAction)cancel:(UIBarButtonItem *)sender {
    
    [super cancelAndDismiss];
}

- (IBAction)editSave:(UIBarButtonItem *)sender {
    
    if ([_editSaveButton.title isEqualToString:@"Edit"]) {
        
        NSLog(@"Edit Button Has Been Pressed");
        
        [self setTitle:@"Edit Student"];
        
        _ID.enabled = YES;
        _firstName.enabled = YES;
        _lastName.enabled = YES;
        _gender.enabled = YES;
        _dateOfBirth.enabled = YES;
        _address.enabled = YES;
        _course.enabled = YES;
        _takePhotoButton.enabled = YES;
        _choosePhotoButton.enabled = YES;
        
        _ID.borderStyle = UITextBorderStyleRoundedRect;
        _firstName.borderStyle = UITextBorderStyleRoundedRect;
        _lastName.borderStyle = UITextBorderStyleRoundedRect;
        _gender.borderStyle = UITextBorderStyleRoundedRect;
        _dateOfBirth.borderStyle = UITextBorderStyleRoundedRect;
        _address.borderStyle = UITextBorderStyleRoundedRect;
        _course.borderStyle = UITextBorderStyleRoundedRect;
        
        _editSaveButton.title = @"Save";
        
    }else if ([_editSaveButton.title isEqualToString:@"Save"]){
        
        NSLog(@"Save Button Has Been Pressed");
        
        self.title = @"Student";
        
//        _ID.enabled = NO;
//        _firstName.enabled = NO;
//        _lastName.enabled = NO;
//        _gender.enabled = NO;
//        _dateOfBirth.enabled = NO;
//        _address.enabled = NO;
//        _course.enabled = NO;
//        _takePhotoButton.enabled = NO;
//        _choosePhotoButton.enabled = NO;
        
        _ID.borderStyle = UITextBorderStyleNone;
        _firstName.borderStyle = UITextBorderStyleNone;
        _lastName.borderStyle = UITextBorderStyleNone;
        _gender.borderStyle = UITextBorderStyleNone;
        _dateOfBirth.borderStyle = UITextBorderStyleNone;
        _address.borderStyle = UITextBorderStyleNone;
        _course.borderStyle = UITextBorderStyleNone;
        
        _editSaveButton.title = @"Edit";
        
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd-MM-yyyy"];
        
        editStudent.studentID = [nf numberFromString:_ID.text];
        editStudent.studentFirstName = _firstName.text;
        editStudent.studentLastName = _lastName.text;
        editStudent.studentGender = _gender.text;
        editStudent.studentDateOfBirth = [df dateFromString:_dateOfBirth.text];
        editStudent.studentAddress = _address.text;
        editStudent.studentCourse = _course.text;
        editStudent.studentPhoto = UIImageJPEGRepresentation(_studentPhoto.image, 1);
        
        [super saveAndDismiss];
        
    }
}

//- (void)dealloc {
//    [_takePhotoButton release];
//    [_choosePhotoButton release];
//    [super dealloc];
//}
@end
