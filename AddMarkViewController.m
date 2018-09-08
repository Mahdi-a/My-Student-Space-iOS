//
//  AddMarkViewController.m
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 24/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import "AddMarkViewController.h"
#import "MarksTableViewController.h"


@interface AddMarkViewController ()

@end

@implementation AddMarkViewController

@synthesize addMark, marksStudent;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataPicker = [[NSMutableArray alloc] init];
    [dataPicker addObject:@"--"];
    [dataPicker addObject:@"HD"];
    [dataPicker addObject:@"D"];
    [dataPicker addObject:@"C"];
    [dataPicker addObject:@"P"];
    [dataPicker addObject:@"CP"];
    [dataPicker addObject:@"F"];
    
    _unitGrade.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    
    CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
    pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
    _unitGrade.text = [dataPicker objectAtIndex:0];
    _unitGrade.inputView = pickerView;
    
    pickerView.delegate = self;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_unitGrade resignFirstResponder];
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
    
    _unitGrade.text = [dataPicker objectAtIndex:row];
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
    
    
    [super cancelAndDismiss];
}

- (IBAction)save:(UIBarButtonItem *)sender {
    
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    
    
    addMark.student = marksStudent;
    addMark.markUnitID = [nf numberFromString:_unitCode.text];
    addMark.markUnitName = _unitName.text;
    addMark.markUnitGrade = _unitGrade.text;
    [super saveAndDismiss];
}
@end
