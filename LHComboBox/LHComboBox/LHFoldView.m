//
//  LHFoldView.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHFoldView.h"
#import "LHComboBoxHeader.h"
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
        [self addSubview:self.topView];
        [self.topView addSubview:self.leftLabel];
        [self.topView addSubview:self.mediumLabel];
        [self.topView addSubview:self.imageView];
    }
    return self;
}



- (void)setLayout:(LHLayout *)layout {
    _leftLabel.text = layout.node.title;
    _mediumLabel.text = @"全部";
    
    for (int index = 0; index < layout.buttonWidthArray.count; index ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake([layout.buttonPositionX[index] floatValue], [layout.buttonPositionY[index] floatValue], [layout.buttonWidthArray[index] floatValue], layout.buttonHeight);
        [button setTitle:[layout.node.childrenNodes[index] title] forState:UIControlStateNormal];
        [self addSubview:button];
    }
    
}

#pragma mark - get
- (UILabel *)leftLabel {
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font = [UIFont systemFontOfSize:FoldLableSize];
        [self addSubview:_leftLabel];
    }
    return _leftLabel;
}

- (UILabel *)mediumLabel {
    if (_mediumLabel == nil) {
        _mediumLabel = [[UILabel alloc] init];
        _mediumLabel.font = [UIFont systemFontOfSize:FoldLableSize];
        [self addSubview:_mediumLabel];
    }
    return _mediumLabel;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
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
    }
    return _bgView;
}
@end
