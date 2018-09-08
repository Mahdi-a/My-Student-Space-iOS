//
//  Login.m
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 26/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import "Login.h"

@interface Login ()

@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _lblError.text = @"";
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
- (IBAction)btnLogin:(id)sender {
    
    if ([_txtUserName.text  isEqual: @"user"] && [_txtPassWord.text  isEqual: @"password"]) {
        
        [self performSegueWithIdentifier:@"loginSucess" sender:self];
        _lblError.text = @"";
        
    }
    else{
        _lblError.text = @"Please enter correct username and password";
    }
}





- (void)dealloc {
    [_txtUserName release];
    [_txtPassWord release];
    [_lblError release];
    [super dealloc];
}

@end
