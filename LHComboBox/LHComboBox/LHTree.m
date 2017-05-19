//
//  LHTree.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHTree.h"
@interface LHTree ()
//@property (nonatomic, strong) NSMutableArray *
@end

@implementation LHTree
- (instancetype)initWithDataArray:(NSArray *)sourceArray {
    self = [super init];
    if (self) {
        self.numbersOfTreeLayers = LHNumbersOfTreeLayersSingle;
        self.displayType = LHPopupViewDisplayTypeFilters;
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSDictionary *dic in sourceArray) {
            [mutableArray addObject:[LHTreeNode  nodeWithTitle:dic[@"mobile_name"] isSelected:NO idNumber:dic[@"idNumber"] parentIdNumber:dic[@"parent_id"]]];
        }
        [self createTreeBySourceArray:[mutableArray copy]];
    }
    return self;
}

- (void)createTreeBySourceArray:(NSArray *)sourceArray {
    if (sourceArray == nil || sourceArray.count == 0) return ;
    NSMutableArray *mutableArray = [sourceArray mutableCopy];
    NSMutableArray *queue = [NSMutableArray arrayWithCapacity:mutableArray.count];
    [queue addObject:self.rootNode];
    
    while (queue.count > 0) {
        LHTreeNode *firstNode = [queue firstObject];
        NSMutableArray *temArray = [NSMutableArray array]; //储存将要删除额index
        for (NSInteger index = (mutableArray.count - 1); index >= 0; index --) {
            LHTreeNode *node = mutableArray[index];
            if ([firstNode.idNumber integerValue] == [node.parentIdNumber integerValue]) {
                [queue addObject:node];
                [firstNode addNode:node];
                [temArray addObject:@(index)];
            }
        }
        
        //删除原数组已经添加的节点
        for (NSNumber *number in temArray) {
            [mutableArray removeObjectAtIndex:[number integerValue]];
        }
        
        if ([firstNode.idNumber integerValue] == 0 && mutableArray.count != 0) {//当移除掉根节点，这个时候根节点的子节点都从原数组移除点了，如果原数组还有数据证明这个树的层树不止两层
            self.numbersOfTreeLayers = LHNumbersOfTreeLayersMutl;
        }
        
        [queue removeObjectAtIndex:0];
    }
    
    if (mutableArray.count != 0) {
        NSLog(@"构建树的出现了问题 有的节点没有找到父节点");
    }
    
}

- (void)calculateEachNodeLayout {
    if (self.displayType == LHPopupViewDisplayTypeNormal) return;
    
}

- (LHTreeNode *)rootNode {
    if (_rootNode == nil) {
      _rootNode = [LHTreeNode  nodeWithTitle:@"筛选" isSelected:NO idNumber:@"0" parentIdNumber:nil];
    }
    return _rootNode;
}
@end
