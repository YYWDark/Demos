//
//  LHComBoBoxView.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHComBoBoxView.h"
#import "LHDropDownBox.h"
#import "LHBasePopupView.h"

@interface LHComBoBoxView () <LHDropDownBoxDelegate, LHBasePopupViewDelegate>
@property (nonatomic, strong) NSMutableArray <LHDropDownBox *>*dropDownBoxArray;
@property (nonatomic, strong) NSMutableArray <LHTree *>*itemArray;
@property (nonatomic, strong) NSMutableArray <LHBasePopupView *>*symbolArray;  /*当成一个队列来标记那个弹出视图**/
@property (nonatomic, strong) LHBasePopupView *popupView;
@property (nonatomic, strong) CALayer *topLine;
@property (nonatomic, strong) CALayer *bottomLine;

@property (nonatomic, assign) BOOL isAnimation;                               /*防止多次快速点击**/
@end

@implementation LHComBoBoxView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.dropDownBoxArray = [NSMutableArray array];
        self.itemArray = [NSMutableArray array];
        self.symbolArray = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void)reload {
    NSUInteger count = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsIncomBoBoxView:)]) {
        count = [self.dataSource numberOfColumnsIncomBoBoxView:self];
    }
    
    CGFloat width = self.width/count;
    if ([self.dataSource respondsToSelector:@selector(comBoBoxView:infomationForColumn:)]) {
        for (NSUInteger i = 0; i < count; i ++) {
            LHTree *tree = [self.dataSource comBoBoxView:self infomationForColumn:i];
            LHDropDownBox *dropBox = [[LHDropDownBox alloc] initWithFrame:CGRectMake(i*width, 0, width, self.height) titleName:tree.rootNode.title];
            dropBox.tag = i;
            dropBox.delegate = self;
            [self addSubview:dropBox];
            [self.dropDownBoxArray addObject:dropBox];
            [self.itemArray addObject:tree];
        }
    }
    [self _addLine];
}

- (void)dimissPopView {
    if (self.popupView.superview) {
        [self.popupView dismissWithOutAnimation];
    }
}

#pragma mark - Private Method
- (void)_addLine {
    self.topLine = [CALayer layer];
    self.topLine.frame = CGRectMake(0, 0 , self.width, 1.0/scale);
    self.topLine.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.3].CGColor;
    [self.layer addSublayer:self.topLine];
    
    self.bottomLine = [CALayer layer];
    self.bottomLine.frame = CGRectMake(0, self.height - 1.0/scale , self.width, 1.0/scale);
    self.bottomLine.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"].CGColor;
    [self.layer addSublayer:self.bottomLine];
}

#pragma mark - MMDropDownBoxDelegate
- (void)didTapDropDownBox:(LHDropDownBox *)dropDownBox atIndex:(NSUInteger)index {
     if (self.isAnimation == YES) return;
    
    //点击后更新item的颜色状态
    for (int i = 0; i <self.dropDownBoxArray.count; i++) {
        LHDropDownBox *currentBox  = self.dropDownBoxArray[i];
        [currentBox updateTitleState:(i == index)];
    }
    
    //点击后先判断symbolArray有没有标示
    if (self.symbolArray.count) {
        //移除
        LHBasePopupView * lastView = self.symbolArray[0];
        [lastView dismiss];
        [self.symbolArray removeAllObjects];
        
    }else{
        self.isAnimation = YES;
        LHTree *tree = self.itemArray[index];
        LHBasePopupView *popupView = [LHBasePopupView getSubPopupViewWithTree:tree];
        popupView.delegate = self;
        popupView.tag = index;
        self.popupView = popupView;
        [popupView popupViewFromSourceFrame:self.frame completion:^{
            self.isAnimation = NO;
        }];
        [self.symbolArray addObject:popupView];
    }
}

#pragma mark - MMPopupViewDelegate
- (void)popupView:(LHBasePopupView *)popupView didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(comBoBoxView:didSelectedItemsPackagingInArray:atIndex:)]) {
        [self.delegate comBoBoxView:self didSelectedItemsPackagingInArray:array atIndex:index];
    }
}

- (void)popupViewWillDismiss:(LHBasePopupView *)popupView {
    [self.symbolArray removeAllObjects];
    //当视图消失的时候更新LHDropDownBox的状态
    for (LHDropDownBox *currentBox in self.dropDownBoxArray) {
        [currentBox updateTitleState:NO];
    }
}
@end
