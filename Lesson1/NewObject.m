//
//  NewObject.m
//  Lesson1
//
//  Created by Ильда  Залялов on 27.09.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "NewObject.h"

@implementation NewObject

- (instancetype)initWithNumber:(NSInteger)number text:(NSString *)text {
    self = [super init];
    if (self) {
        _number = number;
        _text = text;
    }
    return self;
}

@end
