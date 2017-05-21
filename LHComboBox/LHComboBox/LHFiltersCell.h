//
//  LHFiltersCell.h
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHTreeNode.h"

@protocol LHFiltersCellDelegate;

@interface LHFiltersCell : UITableViewCell
@property (nonatomic, strong) LHTreeNode *node;
@property (nonatomic, weak) id<LHFiltersCellDelegate> delegate;
@end


@protocol LHFiltersCellDelegate <NSObject>
- (void)filtersCell:(LHFiltersCell *)cell didTapTopViewAtIndex:(NSUInteger)index;
- (void)filtersCell:(LHFiltersCell *)cell didTapButtonAtIndex:(NSUInteger)index topViewTag:(NSUInteger)tag;
@end
