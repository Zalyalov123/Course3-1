//
//  TestViewController.m
//  Lesson1
//
//  Created by Ильда  Залялов on 26.09.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "TestViewController.h"
#import "NetManager.h"
#import "DataController.h"
#import "NewObject.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NewObject *newObject;
    
    if (self.isNew) {
        newObject = [[NewObject alloc] initWithNumber:0 text:@""];
        self.myLabel.text = [NSString stringWithFormat:@"%ld",(long)newObject.number];
        [self.sliderMy setValue:0 animated:YES];
        ;
    } else {
        newObject = [[DataController sharedInstance]objectAtIndex:self.objectIndex];
        self.myLabel.text = [NSString stringWithFormat:@"%ld", newObject.number];
        
        [self.sliderMy setValue:newObject.number animated:YES];
        self.myTextField.text = newObject.text;
    }
    
    @weakify(self);
    [[self.sliderMy rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISlider *slider) {
        @strongify(self);
        newObject.number = slider.value;
        self.myLabel.text = [NSString stringWithFormat:@"%ld", newObject.number];
    }];
    
    RAC(self.saveButton, enabled) = [RACSignal combineLatest:@[self.myTextField.rac_textSignal,RACObserve(newObject,number)] reduce:^(NSString *login,NSNumber *number){
        NSInteger sliderValue = [number integerValue];
        return @(login.length == sliderValue);
    }];
    
    [[self.saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] 
      subscribeNext:^(id x) {
        @strongify(self);
        newObject.text = self.myTextField.text;
       // newObject.number = self.myLabel.text.intValue;
        if (self.isNew) {
            [[DataController sharedInstance]addObject:newObject];
        }else{
            [[DataController sharedInstance]saveObject:newObject atIndex:self.objectIndex];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderDidChange:(id)sender {
    self.myLabel.text = [NSString stringWithFormat:@"%d", (int)self.sliderMy.value];
}


@end
