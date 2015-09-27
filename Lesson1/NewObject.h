//
//  NewObject.h
//  Lesson1
//
//  Created by Ильда  Залялов on 27.09.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewObject : NSObject

@property (assign, nonatomic) NSInteger number;
@property (strong, nonatomic) NSString *text;

- (instancetype)initWithNumber:(NSInteger)number text:(NSString *)text;

@end
