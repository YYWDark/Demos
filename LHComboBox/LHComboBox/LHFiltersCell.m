//
//  LHFiltersCell.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHFiltersCell.h"
#import "LHFoldView.h"
@interface LHFiltersCell ()
@property(nonatomic, strong) LHFoldView *firstView;
@property(nonatomic, strong) LHFoldView *secondView;
@end
@implementation LHFiltersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
}
- (void)setNode:(LHTreeNode *)node {
    [self.firstView setLayout:node.layout];
}


- (LHFoldView *)firstView {
    if (_firstView == nil) {
        _firstView = [[LHFoldView alloc] initWithFrame:CGRectZero];
        [self addSubview:_firstView];
    }
    return _firstView;
}
@end
