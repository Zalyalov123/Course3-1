//
//  TestViewController.h
//  Lesson1
//
//  Created by Ильда  Залялов on 26.09.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TestViewDelegate <NSObject>


@end
@interface TestViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *sliderMy;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;


@property (nonatomic) BOOL isNew;
@property (assign, nonatomic) NSInteger objectIndex;

@end
