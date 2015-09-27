//
//  RegisterVC.h
//  Lesson1
//
//  Created by Ильда  Залялов on 24.09.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "KeyboardViewController.h"
#import <UIKit/UIKit.h>

@interface RegisterVC : KeyboardViewController
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UILabel *codeNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end
