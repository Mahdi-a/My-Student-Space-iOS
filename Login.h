//
//  Login.h
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 26/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *txtUserName;

@property (retain, nonatomic) IBOutlet UITextField *txtPassWord;

@property (retain, nonatomic) IBOutlet UILabel *lblError;


- (IBAction)btnLogin:(id)sender;

@end
