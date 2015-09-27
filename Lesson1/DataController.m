//
//  DataController.m
//  Lesson1
//
//  Created by Ильда  Залялов on 27.09.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "DataController.h"
#import "NewObject.h"

@interface DataController ()

@end

@implementation DataController

+ (instancetype)sharedInstance {
    static id _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _items = [KVOMutableArray new];
    }
    return self;
}

- (NewObject *)objectAtIndex:(NSInteger)index {
    return self.items[index];
}

- (void)saveObject:(NewObject *)obj atIndex:(NSInteger)index {
    self.items[index] = obj;
}

- (void)addObject:(NewObject *)obj {
    [self.items addObject:obj];
}

- (void)deleteObjectAtIndex:(NSInteger)index {
    [self.items removeObjectAtIndex:index];
}
@end
