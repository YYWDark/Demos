//
//  LHSelectedPath.m
//  LHComboBox
//
//  Created by wyy on 2017/5/20.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHSelectedPath.h"
@interface LHSelectedPath () <NSCopying>
@end
@implementation LHSelectedPath
- (instancetype)init {
    self = [super init];
    if (self) {
        self.secondPath = -1;
        self.thirdPath = -1;
    }
    return self;
}

+ (instancetype)pathWithFirstPath:(NSInteger)firstPath {
    return [self pathWithFirstPath:firstPath secondPath:-1];
}

+ (instancetype)pathWithFirstPath:(NSInteger)firstPath
                       secondPath:(NSInteger)secondPath {
    return [self pathWithFirstPath:firstPath secondPath:secondPath thirdPath:-1];
}

+ (instancetype)pathWithFirstPath:(NSInteger)firstPath
                       secondPath:(NSInteger)secondPath
                        thirdPath:(NSInteger)thirdPath {
    LHSelectedPath *path = [LHSelectedPath new];
    path.firstPath = firstPath;
    path.secondPath = secondPath;
    path.thirdPath = thirdPath;
    return path;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return  [[self class] pathWithFirstPath:self.firstPath secondPath:self.secondPath thirdPath:self.thirdPath];
}
@end
