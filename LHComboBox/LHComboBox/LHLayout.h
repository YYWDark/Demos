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


@property (nonatomic, assign) CGFloat foldHeight;
@property (nonatomic, assign) CGFloat totalHeight;

@property (nonatomic, strong) NSMutableArray *buttonPositionX;
@property (nonatomic, strong) NSMutableArray *buttonPositionY;

+ (instancetype)layoutWithItem:(LHTreeNode *)item;
@end
