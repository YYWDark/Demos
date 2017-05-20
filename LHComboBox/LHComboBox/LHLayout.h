//
//  LHLayout.h
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LHTreeNode;
@interface LHLayout : NSObject
@property (nonatomic, assign) CGFloat verticalMargin;
@property (nonatomic, assign) CGFloat horizontalMargin;

@property (nonatomic, assign) CGFloat toolViewHeight;

@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, assign) CGFloat foldHeight;     //折叠时候的高度
@property (nonatomic, assign) CGFloat totalHeight;    //展开的高度

@property (nonatomic, assign) CGFloat lableFontSize;
@property (nonatomic, assign) CGFloat buttonFontSize;

@property (nonatomic, strong) NSMutableArray *buttonPositionX;
@property (nonatomic, strong) NSMutableArray *buttonPositionY;    //储存按钮的起点Y
@property (nonatomic, strong) NSMutableArray *buttonWidthArray;   //储存按钮的宽度，每一个宽度不一样

@property (nonatomic, strong) LHTreeNode *node;
- (instancetype)initWithNode:(LHTreeNode *)node;
@end
