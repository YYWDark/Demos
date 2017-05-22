//
//  LHLayout.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHLayout.h"
#import "LHTreeNode.h"
#import "LHComboBoxHeader.h"

@implementation LHLayout
- (instancetype)initWithNode:(LHTreeNode *)node {
    self = [super init];
    if (self) {
        self.buttonPositionX = [NSMutableArray array];
        self.buttonPositionY = [NSMutableArray array];
        self.buttonWidthArray = [NSMutableArray array];
        self.node = node;
        [self layoutWithNode:node];
    }
    return self;
}

- (void)layoutWithNode:(LHTreeNode *)node {
    int number = [node.idNumber integerValue];
    _lableFontSize = 14.0f;
    _buttonFontSize = 14.0f;
    _buttonHeight = 35.0f;
    _dropDwonButtonWidth = 40;
    //间距
    _verticalMargin = FoldVerticalMargin;
    _horizontalMargin = FoldHorizontalMargin;
    
    _toolViewHeight = FoldToolViewHeight;
    _foldHeight = _toolViewHeight;
    
    _totalHeight = _foldHeight;
    //计算按钮的布局和总的高度
    
    //我们默认第一个按钮距离左边的宽度为_horizontalMargin 离上面标题的距离为_verticalMargin
   __block CGFloat leftDitance = _horizontalMargin;
   __block CGFloat topDitance =  _totalHeight + _verticalMargin;
    [node.childrenNodes enumerateObjectsUsingBlock:^(LHTreeNode * _Nonnull node, NSUInteger idx, BOOL * _Nonnull stop) {
      
       [self.buttonPositionY addObject:@(topDitance)];
        
       CGFloat width = [NSObject widthFromString:[NSString stringWithFormat:@"%ld",[node.idNumber integerValue]] withFont:[UIFont systemFontOfSize:_buttonFontSize] constraintToHeight:_buttonHeight] + 20;
       [self.buttonWidthArray addObject:@(width)];
        NSInteger number = [node.idNumber integerValue];
       if (width + leftDitance > kScreenWidth - _horizontalMargin) {
            leftDitance = _horizontalMargin;
            topDitance += (_buttonHeight + _verticalMargin);
            [self.buttonPositionX addObject:@(leftDitance)];
       }else {
            [self.buttonPositionX addObject:@(leftDitance)];
           leftDitance += (width + _horizontalMargin);
       }
        
    }];
    
    //总的高度
    _totalHeight = [[self.buttonPositionY lastObject] floatValue] + _buttonHeight + _verticalMargin;
    
    
    //宽度
//    _leftWidth = [NSObject widthFromString:node.title withFont:[UIFont systemFontOfSize:_lableFontSize] constraintToHeight:_toolViewHeight];
    _leftWidth = 60.0f;
    
}


@end
