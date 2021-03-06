//
//  LHTreeNode.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHTreeNode.h"

@interface LHTreeNode ()

@end

@implementation LHTreeNode
- (instancetype)init {
    self = [super init];
    if (self) {
        self.childrenNodes = [NSMutableArray array];
        _firstOpenStatus = LHTreeNodeFirstNone;
        _secondOpenStatus = LHTreeNodeSecondNone;
    }
    return self;
}

+ (instancetype)nodeWithTitle:(NSString *)title
                   isSelected:(BOOL)isSelected
                     idNumber:(NSNumber *)number {
    return [self nodeWithTitle:title isSelected:isSelected idNumber:number parentIdNumber:nil];
}

+ (instancetype)nodeWithTitle:(NSString *)title
                   isSelected:(BOOL)isSelected
                     idNumber:(NSNumber *)number
               parentIdNumber:(NSNumber *)parentIdNumber {
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

//设置第一层的树的子树有几层
- (void)settingAboutnumbersOfLayers:(NSInteger)count {
    _numbersOfLayers = count;
}

- (void)calculateLayout {
    self.layout = [[LHLayout alloc] initWithNode:self];;
}

//拿到现在cell的高度，
- (CGFloat)getCellHeight {
   CGFloat totalHeight;
    if (_firstOpenStatus == LHTreeNodeFirstClose) {
        totalHeight += self.layout.foldHeight;
    }else if (_firstOpenStatus == LHTreeNodeFirstOpen) {
        totalHeight += self.layout.totalHeight;
    }
    //必须是有大类小类 而且大类一定需要被选中
    if (!(self.numbersOfLayers == 2 && [self isLargeClassSelected])) return totalHeight;
    
    
    LHTreeNode * node = [[self nodesOfLargeClassSelected] lastObject];
    if (_secondOpenStatus == LHTreeNodeSecondClose) {
        totalHeight += node.layout.foldHeight;
    }else if (_secondOpenStatus == LHTreeNodeSecondOpen) {
        totalHeight += node.layout.totalHeight;
    }
   return totalHeight;
}

//大类是否有选中项
- (BOOL)isLargeClassSelected {
    for (LHTreeNode *node in self.childrenNodes) {
        if (node.isSelected == YES) return YES;
    }
    return NO;
}

  //如果是三级的 那第二级一定是单选，存在的话只是返回一个 但是是二级就有可能返回多个了
- (NSArray *)nodesOfLargeClassSelected {
    NSMutableArray *array = [NSMutableArray array];
    for (int index = 0;index < self.childrenNodes.count; index ++) {
        LHTreeNode *node = self.childrenNodes[index];
        if (node.isSelected == YES) {
            [array addObject:node];
        }
    }
    return array;
}


@end
