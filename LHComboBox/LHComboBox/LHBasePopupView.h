//
//  LHBasePopupView.h
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHTree.h"
#import "LHComboBoxHeader.h"

@protocol LHBasePopupViewDelegate;
@interface LHBasePopupView : UIView
@property (nonatomic, assign) CGRect sourceFrame;                                       /* tapBar的frame**/
@property (nonatomic, strong) LHTree *tree;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *temporaryArray;                            /* 暂存最初的状态**/
@property (nonatomic, strong) NSMutableArray *selectedArray;                            /* 记录所选的item**/
@property (nonatomic, weak) id<LHBasePopupViewDelegate> delegate;
- (id)initWithTree:(LHTree *)tree;
- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void (^)(void))completion;
+ (LHBasePopupView *)getSubPopupViewWithTree:(LHTree *)tree;
- (void)dismiss;
@end

@protocol LHBasePopupViewDelegate <NSObject>
@optional
- (void)popupView:(LHBasePopupView *)popupView didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index;
- (void)popupViewWillDismiss:(LHBasePopupView *)popupView;
@end
