//
//  RegisterVC.m
//  Lesson1
//
//  Created by Ильда  Залялов on 24.09.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//
#import "AppViewController.h"
#import "RegisterVC.h"
#import "NetManager.h"

@interface RegisterVC ()
{
    NSMutableArray *valuesArr;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *V0constraint;


@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
   valuesArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 100; i++)
    {
        [valuesArr addObject:[NSNumber numberWithInteger:i]];
    }
    [self randomCode];
    @weakify(self);
    [self.keyboardSignal subscribeNext:^(NSNumber *x) {
        [UIView animateWithDuration:.3 animations:^{
            @strongify(self);
            self.V0constraint.constant = [x floatValue] / -2;
            [self.view layoutIfNeeded];
        }];
    }];
    [[self rac_signalForSelector:@selector(textFieldShouldReturn:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        UITextField *tf = tuple.first;
        if (tf == self.loginField)
            [self.passwordField becomeFirstResponder];
        else if (tf == self.passwordField){
            [self.confirmPasswordField becomeFirstResponder];
        }
        else if (tf == self.confirmPasswordField){
            [self.codeField becomeFirstResponder];
        }
        else{
            [tf resignFirstResponder];
            [self.registerButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        
    }];
    RAC(self.registerButton, enabled) = [RACSignal combineLatest:@[ self.loginField.rac_textSignal, self.passwordField.rac_textSignal, self.confirmPasswordField.rac_textSignal, self.codeField.rac_textSignal,RACObserve(self.codeNumberLabel, text)] reduce:^(NSString *login, NSString *password, NSString *confirm, NSString *code, NSString *valid){
        return @(login.length > 4 && password.length > 2 && [confirm isEqualToString:password] && [code isEqualToString:valid]);
    }];
    [[[self.registerButton rac_signalForControlEvents:UIControlEventTouchUpInside] filter:^BOOL(UIButton *sender) {
        return sender.enabled;
    }] subscribeNext:^(id x) {
        @strongify(self);
        UINavigationController *navController = self.navigationController;
        [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"AppVC"] animated:YES completion:nil];
        [navController popViewControllerAnimated:NO];
    }];

}

- (IBAction)refireshButton:(id)sender {
    [self randomCode];
}
- (void)randomCode{
    NSUInteger randomIndex = arc4random() % [valuesArr count];
    self.codeNumberLabel.text = [NSString stringWithFormat:@"%@",[valuesArr objectAtIndex:randomIndex]];
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
