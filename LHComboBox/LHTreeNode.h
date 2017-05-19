//
//  LHTreeNode.h
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHLayout.h"

@interface LHTreeNode : NSObject
@property (nonatomic, copy) NSString *idNumber;
@property (nonatomic, copy) NSString *parentIdNumber;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) LHLayout *layout;
@property (nonatomic, strong) NSMutableArray <LHTreeNode *>*childrenNodes;
@property (nonatomic, assign) BOOL isSelected;

+ (instancetype)nodeWithTitle:(NSString *)title
                   isSelected:(BOOL)isSelected
                     idNumber:(NSString *)number;

+ (instancetype)nodeWithTitle:(NSString *)title
                   isSelected:(BOOL)isSelected
                     idNumber:(NSString *)number
               parentIdNumber:(NSString *)parentIdNumber;

- (void)addNode:(LHTreeNode *)node;
@end
