//
//  LHTreeNode.h
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHLayout.h"


typedef NS_ENUM(NSUInteger, LHTreeNodeFirstStatus) {  //面料大类的展开
    LHTreeNodeFirstNone = 0,                   //默认不存在
    LHTreeNodeFirstClose = 1,
    LHTreeNodeFirstOpen = 2
};

typedef NS_ENUM(NSUInteger, LHTreeNodeSecondStatus) {  //面料小类的展开，当numbersOfLayers == 1或者面料大类没有选择的时候 该枚举不起作用
    LHTreeNodeSecondNone  = 0,                //默认不存在
    LHTreeNodeSecondClose = 1,
    LHTreeNodeSecondOpen = 2,
};

@interface LHTreeNode : NSObject
@property (nonatomic, copy) NSNumber *idNumber;
@property (nonatomic, copy) NSNumber *parentIdNumber;
@property (nonatomic, copy) NSString *title;


@property (nonatomic, strong) LHLayout *layout;


@property (nonatomic, strong) NSMutableArray <LHTreeNode *>*childrenNodes;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign, readonly) NSUInteger numbersOfLayers;

@property (nonatomic, assign) LHTreeNodeFirstStatus firstOpenStatus;
@property (nonatomic, assign) LHTreeNodeSecondStatus secondOpenStatus;

+ (instancetype)nodeWithTitle:(NSString *)title
                   isSelected:(BOOL)isSelected
                     idNumber:(NSNumber *)number;

+ (instancetype)nodeWithTitle:(NSString *)title
                   isSelected:(BOOL)isSelected
                     idNumber:(NSNumber *)number
               parentIdNumber:(NSNumber *)parentIdNumber;

- (void)addNode:(LHTreeNode *)node;
- (void)settingAboutnumbersOfLayers:(NSInteger)count;
- (void)calculateLayout;

- (CGFloat)getCellHeight;
- (BOOL)isLargeClassSelected;
- (LHTreeNode *)nodeOfLargeClassSelected;
@end
