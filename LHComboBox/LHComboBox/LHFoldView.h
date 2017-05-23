//
//  LHFoldView.h
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHTreeNode.h"
typedef NS_ENUM(NSUInteger, LHFoldViewStatus) {  //面料大类的展开
      LHFoldViewClose,
      LHFoldViewOpen,
};


@protocol LHFoldViewDelegate;
@interface LHFoldView : UIView
@property (nonatomic, strong) LHLayout *layout;
@property (nonatomic, weak) id<LHFoldViewDelegate> delegate;
@property (nonatomic, assign) LHFoldViewStatus foldViewStatus;

- (instancetype)initWithFrame:(CGRect)frame tag:(NSUInteger)tag;
@end

@protocol LHFoldViewDelegate <NSObject>
- (void)foldViewdidTapTopView:(LHFoldView *)foldView foldViewStatus:(LHFoldViewStatus)status;
- (void)foldView:(LHFoldView *)foldView didTapButtonAtIndex:(NSUInteger)index;
@end
