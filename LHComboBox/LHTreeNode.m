//
//  LHTreeNode.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHTreeNode.h"

@implementation LHTreeNode
- (instancetype)init {
    self = [super init];
    if (self) {
        self.childrenNodes = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)nodeWithTitle:(NSString *)title
                   isSelected:(BOOL)isSelected
                     idNumber:(NSString *)number {
    return [self nodeWithTitle:title isSelected:isSelected idNumber:number parentIdNumber:nil];
}

+ (instancetype)nodeWithTitle:(NSString *)title
                   isSelected:(BOOL)isSelected
                     idNumber:(NSString *)number
               parentIdNumber:(NSString *)parentIdNumber {
    LHTreeNode *node = [[self alloc] init];
    node.title = title;
    node.isSelected = isSelected;
    node.idNumber = number;
    node.parentIdNumber = parentIdNumber;
    return node;
}


- (void)addNode:(LHTreeNode *)node {
    [self.childrenNodes addObject:node];
}
@end
