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
@property (nonatomic, strong) CALayer *line;
@property (nonatomic, strong) CALayer *line1;
@property (nonatomic, strong) CAShapeLayer *line2;
@end

@implementation LHFoldView
- (instancetype)initWithFrame:(CGRect)frame tag:(NSUInteger)tag {
    self.tag = tag;
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.foldViewStatus = LHFoldViewClose;
        [self addSubview:self.topView];
        [self.topView addSubview:self.leftLabel];
        [self.topView.layer addSublayer:self.line];
        [self.topView addSubview:self.mediumLabel];
        [self.topView addSubview:self.imageView];
        if (tag == 1) {
            [self.topView.layer addSublayer:self.line2];
        }
        
        
        [self addSubview:self.bgView];
        [self.bgView.layer addSublayer:self.line1];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.userInteractionEnabled = YES;
//        self.foldViewStatus = LHFoldViewClose;
//        [self addSubview:self.topView];
//        [self.topView addSubview:self.leftLabel];
//        [self.topView.layer addSublayer:self.line];
//        [self.topView addSubview:self.mediumLabel];
//        [self.topView addSubview:self.imageView];
//       
//        [self addSubview:self.bgView];
//        [self.bgView.layer addSublayer:self.line1];
//    }
//    return self;
//}

- (void)setLayout:(LHLayout *)layout {
    _leftLabel.text = [NSString stringWithFormat:@"%ld",[layout.node.idNumber integerValue]];
    //默认显示
    NSString *mediumStr  = @"全部";
    if ([layout.node isLargeClassSelected]) {
        //如果下一级有选中则不显示全部
        NSArray *array = [layout.node nodesOfLargeClassSelected];
       NSMutableString *title = [NSMutableString string];
        [array enumerateObjectsUsingBlock:^(LHTreeNode * node, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
              [title appendString:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%ld",[[node idNumber] integerValue]]]];
            }else {
              [title appendString:[NSString stringWithFormat:@"，%@",[NSString stringWithFormat:@"%ld",[[node idNumber] integerValue]]]];  
            }
            
        }];
        mediumStr = [title copy];
    }
    _mediumLabel.text = mediumStr;
    [self updateImageViewWithStatus:self.foldViewStatus];
    //frame
    _topView.frame = CGRectMake(0, 0, kScreenWidth, layout.toolViewHeight);
    _leftLabel.frame = CGRectMake(layout.horizontalMargin, 0, layout.leftWidth, layout.toolViewHeight);
    _line.frame = CGRectMake(_leftLabel.right, _leftLabel.top + 15, 1, layout.toolViewHeight - 30);

    _mediumLabel.frame = CGRectMake(_leftLabel.right + layout.horizontalMargin, _leftLabel.top, kScreenWidth -layout.horizontalMargin - 20 - layout.dropDwonButtonWidth - _leftLabel.right - layout.horizontalMargin, layout.toolViewHeight);
    _imageView.frame = CGRectMake(_mediumLabel.right + layout.horizontalMargin , 15, layout.dropDwonButtonWidth, layout.toolViewHeight - 30);
    
    if (self.bgView.subviews.count) {
        for (UIButton *btn in self.bgView.subviews) {
            [btn removeFromSuperview];
        }
    }
    
    if (self.foldViewStatus == LHFoldViewClose) {
        self.bgView.hidden = YES;
        self.bgView.frame = CGRectMake(0, _topView.bottom, kScreenWidth, 0);
    }else if (self.foldViewStatus == LHFoldViewOpen){
        self.bgView.hidden = NO;
        self.bgView.frame = CGRectMake(0, _topView.bottom, kScreenWidth, layout.totalHeight - layout.foldHeight);
    }
    _line1.frame = CGRectMake(layout.leftWidth/2, 0, kScreenWidth - layout.leftWidth/2, 1);
    for (int index = 0; index < layout.buttonWidthArray.count; index ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake([layout.buttonPositionX[index] floatValue], [layout.buttonPositionY[index] floatValue] - layout.foldHeight, [layout.buttonWidthArray[index] floatValue], layout.buttonHeight);
        [button setTitle: [NSString stringWithFormat:@"%ld",[[layout.node.childrenNodes[index] idNumber] integerValue]] forState:UIControlStateNormal];
        button.backgroundColor = [layout.node.childrenNodes[index] isSelected]?[UIColor colorWithHexString:ThemeColor]:[UIColor whiteColor];
        [button setTitleColor:[layout.node.childrenNodes[index] isSelected]?[UIColor whiteColor]:[UIColor colorWithHexString:LightColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:layout.buttonFontSize];
        [button addTarget:self action:@selector(resopndsToButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = index;
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = [UIColor colorWithHexString:LightColor].CGColor;
        [self.bgView addSubview:button];
    }
    
}

- (void)updateImageViewWithStatus:(LHFoldViewStatus )status {
    if (status == LHFoldViewClose) {
        self.imageView.image = [UIImage imageNamed:@"pull_down.png"];
    }else {
        self.imageView.image = [UIImage imageNamed:@"pull_up"];
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
        _leftLabel.textAlignment = NSTextAlignmentCenter;
#ifdef Debug
        _leftLabel.backgroundColor = [UIColor redColor];
#endif
    }
    return _leftLabel;
}

- (UILabel *)mediumLabel {
    if (_mediumLabel == nil) {
        _mediumLabel = [[UILabel alloc] init];
        _mediumLabel.font = [UIFont systemFontOfSize:FoldLableSize];
        _mediumLabel.textColor = [UIColor colorWithHexString:LightColor];
#ifdef Debug
        _mediumLabel.backgroundColor = [UIColor purpleColor];
#endif
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
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pull_down.png"]];
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

- (CALayer *)line {
    if (_line == nil) {
        _line = [CALayer layer];
        _line.backgroundColor = [UIColor colorWithHexString:ThemeColor].CGColor;
    }
    return _line;
}

- (CALayer *)line1 {
    if (_line1 == nil) {
        _line1 = [CALayer layer];
        _line1.backgroundColor = [UIColor colorWithHexString:LightColor].CGColor;
    }
    return _line1;
}

-(CAShapeLayer *)line2 {
    if (_line2 == nil){
        _line2 = [CAShapeLayer layer];
        _line2.path = [self bezierPath].CGPath;
        _line2.fillColor = [UIColor clearColor].CGColor;
        _line2.strokeColor = [UIColor colorWithHexString:LightColor].CGColor;
    }
    return _line2;
}

- (UIBezierPath *)bezierPath {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = 1;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineCapRound;
    [bezierPath moveToPoint:CGPointMake(10, 5)];
    [bezierPath addLineToPoint:CGPointMake(40, 5)];
    [bezierPath addLineToPoint:CGPointMake(45, 0)];
    [bezierPath addLineToPoint:CGPointMake(50, 5)];
    [bezierPath addLineToPoint:CGPointMake(kScreenWidth, 5)];
    return bezierPath;
}
@end
