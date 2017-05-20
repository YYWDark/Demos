//
//  LHSelectedPath.h
//  LHComboBox
//
//  Created by wyy on 2017/5/20.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHSelectedPath : NSObject
@property (nonatomic, assign) NSInteger firstPath;
@property (nonatomic, assign) NSInteger secondPath;         //default is -1. 全部的意思
@property (nonatomic, assign) NSInteger thirdPath;          //default is -1. 全部的意思


+ (instancetype)pathWithFirstPath:(NSInteger)firstPath
                       secondPath:(NSInteger)secondPath;

+ (instancetype)pathWithFirstPath:(NSInteger)firstPath
                       secondPath:(NSInteger)secondPath
                        thirdPath:(NSInteger)thirdPath;
@end
