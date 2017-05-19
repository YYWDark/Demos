//
//  LHTree.h
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHTreeNode.h"

typedef NS_ENUM(NSUInteger, LHPopupViewDisplayType) {  //分辨弹出来的view类型
    LHPopupViewDisplayTypeNormal = 0,                //一层
    LHPopupViewDisplayTypeFilters = 1,               //混合
};

typedef NS_ENUM(NSUInteger, LHNumbersOfTreeLayers) {
    LHNumbersOfTreeLayersSingle = 0,             //两层
    LHNumbersOfTreeLayersMutl = 1,               //多层
};

@interface LHTree : NSObject
@property (nonatomic, strong) LHTreeNode *rootNode;
@property (nonatomic, assign) LHPopupViewDisplayType displayType;
@property (nonatomic, assign) LHNumbersOfTreeLayers numbersOfTreeLayers;
- (instancetype)initWithDataArray:(NSArray *)sourceArray;
@end
