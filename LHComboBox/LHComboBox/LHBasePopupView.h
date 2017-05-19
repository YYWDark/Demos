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

@interface LHBasePopupView : UIView
@property (nonatomic, assign) CGRect sourceFrame;                                       /* tapBar的frame**/
@property (nonatomic, strong) LHTree *tree;
@property (nonatomic, strong) UITableView *mainTableView;

- (id)initWithTree:(LHTree *)tree;
- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void (^)(void))completion;

+ (LHBasePopupView *)getSubPopupViewWithTree:(LHTree *)tree;
- (void)dismiss;
@end
