//
//  LHComboBoxHeader.h
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#ifndef LHComboBoxHeader_h
#define LHComboBoxHeader_h
#import "UIView+ComboBoxExtension.h"
#import "UIColor+ComboBoxExtension.h"
#import "NSObject+Calculate.h"
#define scale [UIScreen mainScreen].scale
static  NSString *titleSelectedColor = @"4EBC72";
static const CGFloat  ButtonFontSize = 14.0f;

//MMPopupView
static const CGFloat PopupViewRowHeight = 44.0f;
static const CGFloat DistanceBeteewnPopupViewAndBottom =80.0f;
static const CGFloat PopupViewTabBarHeight = 40.0f;
static const CGFloat LeftCellHorizontalMargin = 10.0f;
static CGFloat LeftCellWidth = 100.0f;
static const CGFloat ShadowAlpha = 0.5;
//static const CGFloat
static  NSString *MainCellID = @"MainCellID";
static  NSString *SubCellID = @"SubCellID";
static const NSTimeInterval AnimationDuration= .25;
static const CGFloat ButtonHorizontalMargin = 10.0f;

/* fontSize*/
static const CGFloat MainTitleFontSize = 13.0f;
static const CGFloat SubTitleFontSize = 12.0f;
/* color */
static  NSString *SelectedBGColor = @"F2F2F2";
static  NSString *UnselectedBGColor = @"FFFFFF";

static NSString *ThemeColor = @"3797FF";
static NSString *LightColor = @"cccccc";
//MMComBoBoxView

//MMCombinationFitlerView
static const CGFloat AlternativeTitleVerticalMargin = 10.0f;
static const CGFloat AlternativeTitleHeight = 31.0f;

static const CGFloat TitleVerticalMargin = 10.0f;
static const CGFloat TitleHeight  = 20.0f;

static const CGFloat ItemHeight  = 30.0f;
static const CGFloat ItemWidth  = 80.0f;
static const CGFloat ItemHorizontalMargin = 10.0f;
static const CGFloat ItemHorizontalDistance = 5.0f;
//MMDropDownBox
static const CGFloat DropDownBoxFontSize = 12.0f;
static const CGFloat ArrowSide = 8.0f;
static const CGFloat ArrowToRight = 5.0f;
static const CGFloat DropDownBoxTitleHorizontalToArrow = 10.0f;
static const CGFloat DropDownBoxTitleHorizontalToLeft  = 10.0f;

//LHFoldView
static const CGFloat FoldLableSize = 14.0f;
static const CGFloat FoldButtonSize = 14.0f;

static const CGFloat FoldVerticalMargin = 10.0f;
static const CGFloat FoldHorizontalMargin = 10.0f;

static const CGFloat FoldToolViewHeight = 44.0f;
static const CGFloat FoldButtonHeight = 25.0f;
#define kScreenHeigth [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#endif /* LHComboBoxHeader_h */
