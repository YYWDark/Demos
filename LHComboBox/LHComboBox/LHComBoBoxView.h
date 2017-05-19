//
//  LHComBoBoxView.h
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHTree.h"
#import "LHComboBoxHeader.h"

@protocol LHComBoBoxViewDataSource;
@protocol LHComBoBoxViewDelegate;
@interface LHComBoBoxView : UIView
@property (nonatomic, weak) id<LHComBoBoxViewDataSource> dataSource;
@property (nonatomic, weak) id<LHComBoBoxViewDelegate> delegate;

- (void)reload;
- (void)dimissPopView;
@end

@protocol LHComBoBoxViewDataSource <NSObject>

@required;
- (NSUInteger)numberOfColumnsIncomBoBoxView:(LHComBoBoxView *)comBoBoxView;
- (LHTree *)comBoBoxView:(LHComBoBoxView *)comBoBoxView infomationForColumn:(NSUInteger)column;
@end

@protocol LHComBoBoxViewDelegate <NSObject>
@optional
- (void)comBoBoxView:(LHComBoBoxView *)comBoBoxViewd didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index;
@end
