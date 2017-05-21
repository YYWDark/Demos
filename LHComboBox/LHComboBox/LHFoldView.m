//
//  LHFoldView.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHFoldView.h"
#import "LHComboBoxHeader.h"

//#define Debug
@interface LHFoldView ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *mediumLabel;
@property (nonatomic, strong) UIImageView *imageView ;
@property (nonatomic, strong) UIView *bgView;
@end

@implementation LHFoldView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.foldViewStatus = LHFoldViewClose;
        [self addSubview:self.topView];
        [self.topView addSubview:self.leftLabel];
        [self.topView addSubview:self.mediumLabel];
        [self.topView addSubview:self.imageView];
        
        [self addSubview:self.bgView];
    }
    return self;
}

- (void)setLayout:(LHLayout *)layout {
    _leftLabel.text = [NSString stringWithFormat:@"%ld",[layout.node.idNumber integerValue]];
    //默认显示
    NSString *mediumStr  = @"全部";
    if ([layout.node isLargeClassSelected]) {
        //如果下一级有选中则不显示全部
        NSArray *array = [layout.node nodesOfLargeClassSelected];
       NSMutableString *title = [NSMutableString string];
        [array enumerateObjectsUsingBlock:^(LHTreeNode * node, NSUInteger idx, BOOL * _Nonnull stop) {
            [title appendString:[NSString stringWithFormat:@";%@",[NSString stringWithFormat:@"%ld",[[node idNumber] integerValue]]]];
        }];
        mediumStr = [title copy];
    }
    _mediumLabel.text = mediumStr;
    
    //frame
    _topView.frame = CGRectMake(0, 0, kScreenWidth, layout.toolViewHeight);
    _leftLabel.frame = CGRectMake(layout.horizontalMargin, 0, layout.leftWidth, layout.toolViewHeight);
    _mediumLabel.frame = CGRectMake(_leftLabel.right + layout.horizontalMargin, _leftLabel.top, kScreenWidth - 2*layout.horizontalMargin - layout.dropDwonButtonWidth - _leftLabel.right - layout.horizontalMargin, layout.toolViewHeight);
    
        if (self.foldViewStatus == LHFoldViewClose) {
            self.bgView.hidden = YES;
             self.bgView.frame = CGRectMake(0, _topView.bottom, kScreenWidth, 0);
        }else if (self.foldViewStatus == LHFoldViewOpen){
            self.bgView.hidden = NO;
            self.bgView.frame = CGRectMake(0, _topView.bottom, kScreenWidth, layout.totalHeight - layout.foldHeight);
        }
        
        if (self.bgView.subviews.count) {
            for (UIButton *btn in self.bgView.subviews) {
                [btn removeFromSuperview];
            }
        }
        
        for (int index = 0; index < layout.buttonWidthArray.count; index ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake([layout.buttonPositionX[index] floatValue], [layout.buttonPositionY[index] floatValue] - layout.foldHeight, [layout.buttonWidthArray[index] floatValue], layout.buttonHeight);
            [button setTitle: [NSString stringWithFormat:@"%ld",[[layout.node.childrenNodes[index] idNumber] integerValue]] forState:UIControlStateNormal];
            button.backgroundColor = [layout.node.childrenNodes[index] isSelected] ?[UIColor greenColor]:[UIColor yellowColor];
            button.titleLabel.font = [UIFont systemFontOfSize:layout.buttonFontSize];
            [button addTarget:self action:@selector(resopndsToButtonTap:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = index;
            [self.bgView addSubview:button];
        }
        
 
}

#pragma mark - action
- (void)resopndsToTapGestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer {
    NSLog(@"resopndsToTapGestureRecognizer");
    if ([self.delegate respondsToSelector:@selector(foldViewdidTapTopView:foldViewStatus:)]) {
        [self.delegate foldViewdidTapTopView:self foldViewStatus:self.foldViewStatus];
    }
}

- (void)resopndsToButtonTap:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(foldView:didTapButtonAtIndex:)]) {
        [self.delegate foldView:self didTapButtonAtIndex:sender.tag];
    }
}
#pragma mark - get
- (UILabel *)leftLabel {
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font = [UIFont systemFontOfSize:FoldLableSize];
#ifdef Debug
        _leftLabel.backgroundColor = [UIColor redColor];
#endif
//        [self addSubview:_leftLabel];
    }
    return _leftLabel;
}

- (UILabel *)mediumLabel {
    if (_mediumLabel == nil) {
        _mediumLabel = [[UILabel alloc] init];
        _mediumLabel.font = [UIFont systemFontOfSize:FoldLableSize];
        _mediumLabel.textColor = [UIColor redColor];
#ifdef Debug
        _mediumLabel.backgroundColor = [UIColor purpleColor];
#endif
//        [self addSubview:_mediumLabel];
    }
    return _mediumLabel;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resopndsToTapGestureRecognizer:)];
         [_topView addGestureRecognizer:tap];
#ifdef Debug
        _topView.backgroundColor = [UIColor greenColor];
#endif
    }
    return _topView;
}

- (UIImageView *)imageView {
    if (_imageView != nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pulldown.png"]];
    }
    return _imageView;
}

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
#ifdef Debug
        _bgView.backgroundColor = [UIColor lightGrayColor];
#endif
    }
    return _bgView;
}
@end
