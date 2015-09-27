//
//  DataController.h
//  Lesson1
//
//  Created by Ильда  Залялов on 27.09.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KVOMutableArray+ReactiveCocoaSupport.h>
@class NewObject;

@interface DataController : NSObject

+ (instancetype)sharedInstance;

@property (strong, nonatomic, readonly) KVOMutableArray *items;

- (NewObject *)objectAtIndex:(NSInteger)index;
- (void)saveObject:(NewObject *)item atIndex:(NSInteger)index;
- (void)addObject:(NewObject *)item;
- (void)deleteObjectAtIndex:(NSInteger)index;

@end
