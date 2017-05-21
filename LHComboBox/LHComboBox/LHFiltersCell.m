//
//  LHFiltersCell.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHFiltersCell.h"
#import "LHFoldView.h"
#import "LHComboBoxHeader.h"
@interface LHFiltersCell () <LHFoldViewDelegate>
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
    _node = node;
//    for (LHFoldView *view in self.subviews) {
//            [view removeFromSuperview];
//    }
//    [_firstView removeFromSuperview];
//    [_secondView removeFromSuperview];
//    
    CGFloat firstViewHeight = (node.firstOpenStatus == LHTreeNodeFirstClose)?self.node.layout.foldHeight:self.node.layout.totalHeight;
    if (_firstView == nil) {
        _firstView = [[LHFoldView alloc] initWithFrame:CGRectMake(0 ,0 ,kScreenWidth,firstViewHeight)];
        _firstView.delegate = self;
        _firstView.tag = 0;
        [self addSubview:_firstView];
    }else {
        _firstView.frame = CGRectMake(0 ,0 ,kScreenWidth,firstViewHeight);
    }
    self.firstView.foldViewStatus = (node.firstOpenStatus == LHTreeNodeFirstClose)?LHFoldViewClose:LHFoldViewOpen;
    [self.firstView setLayout:node.layout];
    
    switch (node.numbersOfLayers) {
        case 1:{
            
            break;}
        case 2:
            if ([node isLargeClassSelected]) {
                LHTreeNode *secondNode = [[node nodesOfLargeClassSelected] lastObject] ;
                secondNode.firstOpenStatus = node.firstOpenStatus;
                secondNode.secondOpenStatus = node.secondOpenStatus;
                CGFloat secondViewHeight = (node.secondOpenStatus == LHTreeNodeFirstClose)?secondNode.layout.foldHeight:secondNode.layout.totalHeight;
                if (_secondView == nil) {
                    _secondView = [[LHFoldView alloc] initWithFrame:CGRectMake(0, _firstView.bottom, kScreenWidth, secondViewHeight)];
                    _secondView.delegate = self;
                    _secondView.tag = 1;
                    [self addSubview:_secondView];
                }else {
                    _secondView.frame = CGRectMake(0, _firstView.bottom, kScreenWidth, secondViewHeight);
                }
                _secondView.hidden = NO;
                self.secondView.foldViewStatus = (secondNode.secondOpenStatus == LHTreeNodeSecondClose)?LHFoldViewClose:LHFoldViewOpen;
                [self.secondView setLayout:secondNode.layout];
            }else {
                _secondView.hidden = YES;
            }
           
            break;
        default:
            break;
    }
    
}
#pragma mark - LHFoldViewDelegate
- (void)foldViewdidTapTopView:(LHFoldView *)foldView foldViewStatus:(LHFoldViewStatus)status {
    if ([self.delegate respondsToSelector:@selector(filtersCell:didTapTopViewAtIndex:)]) {
        [self.delegate filtersCell:self didTapTopViewAtIndex:foldView.tag];
    }
}

- (void)foldView:(LHFoldView *)foldView didTapButtonAtIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(filtersCell:didTapButtonAtIndex:topViewTag:)]) {
        [self.delegate filtersCell:self didTapButtonAtIndex:index topViewTag:foldView.tag];
    }
}


//- (LHFoldView *)firstView {
//    if (_firstView == nil) {
//        
//        _firstView = [[LHFoldView alloc] initWithFrame:CGRectMake(0 ,0 ,kScreenWidth,self.node.layout.foldHeight)];
//        _firstView.delegate = self;
//        _firstView.tag = 0;
//        [self addSubview:_firstView];
//    }
//    return _firstView;
//}

//- (LHFoldView *)secondView {
//    if (_secondView == nil) {
//        _secondView = [[LHFoldView alloc] initWithFrame:CGRectMake(0, _firstView.top, kScreenWidth, self.node.layout.foldHeight)];
//        _secondView.delegate = self;
//        _secondView.tag = 1;
//        [self addSubview:_secondView];
//    }
//    return _secondView;
//}
@end
