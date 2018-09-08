//
//  AddStudentViewController.m
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 24/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import "AddStudentViewController.h"
#import "CoreViewController.h"

@interface AddStudentViewController ()

@end

@implementation AddStudentViewController



@synthesize addStudent;

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
    
    studentImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageView setImage:studentImage];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
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
    
    _studentGender.delegate = self;
    _studentDateOfBirth.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    
    if (_studentGender.editing) {
        
        CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
        pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
        
//        _studentGender.text = [dataPicker objectAtIndex:0];
        _studentGender.inputView = pickerView;
        
        pickerView.delegate = self;
    }
    
    if (_studentDateOfBirth.editing) {
        
        datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
        
        _studentDateOfBirth.inputView = datePicker;
    }
    
    
}

-(void)updateTextField:(id)sender
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    UIDatePicker *picker = (UIDatePicker*)self.studentDateOfBirth.inputView;
    
    NSDate *dob = picker.date;
    NSString *date = [formatter stringFromDate:dob];
    
    
    self.studentDateOfBirth.text = date;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_studentGender resignFirstResponder];
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
    
    _studentGender.text = [dataPicker objectAtIndex:row];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(UIBarButtonItem *)sender {
    
//    [self.managedObjectContext rollback];
    
    [super cancelAndDismiss];
}

- (IBAction)save:(UIBarButtonItem *)sender {
    
//    NSString *sID = _studentID.text;
//    int studentID = [sID intValue];
    
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    
//    addStudent.studentID = [NSNumber numberWithInt:studentID];
    addStudent.studentID = [nf numberFromString:_studentID.text];
    addStudent.studentFirstName = _studentFirstName.text;
    addStudent.studentLastName = _studentLastName.text;
    addStudent.studentGender = _studentGender.text;
    addStudent.studentDateOfBirth = [df dateFromString:_studentDateOfBirth.text];
    addStudent.studentAddress = _studentAddress.text;
    addStudent.studentCourse = _studentCourse.text;
    addStudent.studentGPA = @"N/A";
    addStudent.studentPhoto = UIImageJPEGRepresentation(studentImage, 1);
    
    
    [super saveAndDismiss];
}

//- (IBAction)addPhotoButton:(id)sender {
//    
//    
//}
- (void)dealloc {
    [_test release];
    [super dealloc];
}
@end
