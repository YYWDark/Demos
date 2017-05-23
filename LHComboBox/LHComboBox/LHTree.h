//
//  LHTree.h
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHTreeNode.h"
#import "LHSelectedPath.h"
typedef NS_ENUM(NSUInteger, LHPopupViewDisplayType) {  //分辨点击排序或者筛选弹出来的视图
    LHPopupViewDisplayTypeNormal = 0,                //一层
    LHPopupViewDisplayTypeFilters = 1,               //混合
};

typedef NS_ENUM(NSUInteger, LHNumbersOfTreeLayers) {
    LHNumbersOfTreeLayersSingle = 0,             //两层 （类似：时间）
    LHNumbersOfTreeLayersMutl = 1,               //多层（类似：大类小类）
};

@interface LHTree : NSObject
@property (nonatomic, strong) LHTreeNode *rootNode;
@property (nonatomic, assign) LHPopupViewDisplayType displayType;
@property (nonatomic, assign) LHNumbersOfTreeLayers numbersOfTreeLayers;
- (instancetype)initWithDataArray:(NSArray *)sourceArray;

- (LHTreeNode *)findNodeWithPath:(LHSelectedPath *)path;
- (LHTreeNode *)findParentNodeWithPath:(LHSelectedPath *)path;
@end
