//
//  LHTree.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHTree.h"
@interface LHTree ()
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
    
    //构建树结构
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
        
        [self calculateEachNodeLayout:firstNode];
        [queue removeObjectAtIndex:0];
    }
    
    [self calculateNumbersLayersOfTreeFirstNode];
    
    if (mutableArray.count != 0) {
        NSLog(@"构建树的出现了问题 有的节点没有找到父节点");
    }
}

//判断第一层的子树的深度
- (void)calculateNumbersLayersOfTreeFirstNode {
    for (LHTreeNode *firstNode in self.rootNode.childrenNodes) {
        LHTreeNode *currentNode = firstNode;
        NSUInteger numbersOflayers = 0;
        while (currentNode.childrenNodes.count) {
            currentNode = [currentNode.childrenNodes firstObject];
            numbersOflayers ++;
        }
        [firstNode settingAboutnumbersOfLayers:numbersOflayers];
        NSLog(@"当前子视图的深度：%ld 节点名称:%@",firstNode.numbersOfLayers,firstNode.title);
    }
}


- (void)calculateEachNodeLayout:(LHTreeNode *)node {
    //单层的UI不需要用到layout类了
    if (self.displayType == LHPopupViewDisplayTypeNormal) return;
    if (node == self.rootNode) return;
    if (node.childrenNodes.count == 0) return;
    [node calculateLayout];
}

- (LHTreeNode *)rootNode {
    if (_rootNode == nil) {
      _rootNode = [LHTreeNode  nodeWithTitle:@"筛选" isSelected:NO idNumber:@(0) parentIdNumber:nil];
    }
    return _rootNode;
}

//根据path来这颗树来找相应的节点，根据thirdPath是否为-1分辨出该path是选中的第三层还是第二层
- (LHTreeNode *)findNodeWithPath:(LHSelectedPath *)path {
    if (path.thirdPath == -1) {
        return self.rootNode.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
    }
    return self.rootNode.childrenNodes[path.firstPath].childrenNodes[path.secondPath].childrenNodes[path.thirdPath];
}

//根据path来这颗树来找相应的节点的父节点
- (LHTreeNode *)findParentNodeWithPath:(LHSelectedPath *)path {
    if (path.thirdPath == - 1) {
        return self.rootNode.childrenNodes[path.firstPath];
    }
    return self.rootNode.childrenNodes[path.firstPath].childrenNodes[path.secondPath];

}
@end
