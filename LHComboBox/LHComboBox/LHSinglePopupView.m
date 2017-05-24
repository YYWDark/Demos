//
//  LHSinglePopupView.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHSinglePopupView.h"
#import "LHComboBoxHeader.h"
#import "MMNormalCell.h"
#import "LHSelectedPath.h"

@interface LHSinglePopupView () <UITableViewDelegate, UITableViewDataSource>

@end
@implementation LHSinglePopupView
- (id)initWithTree:(LHTree *)tree {
    self = [self init];
    if (self) {
        self.shadowView = [[UIView alloc] init];
        self.shadowView.backgroundColor = [UIColor colorWithHexString:@"484848"];
        self.tree = tree;
        
        //将默认选中的值
        for (int i = 0; i < self.tree.rootNode.childrenNodes.count; i++) {
            LHTreeNode *node = self.tree.rootNode.childrenNodes[i];
            if (node.isSelected == YES){
                LHSelectedPath *path = [LHSelectedPath pathWithFirstPath:i];
                [self.selectedArray addObject:path];
            }
        }
    }
    return self;
}

#pragma mark - public method
- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void (^ __nullable)(void))completion {
    UIView *rootView = [[UIApplication sharedApplication] keyWindow];
    self.sourceFrame = frame;
    CGFloat top =  CGRectGetMaxY(self.sourceFrame);
    CGFloat maxHeight = kScreenHeigth - DistanceBeteewnPopupViewAndBottom - top - PopupViewTabBarHeight;
    CGFloat resultHeight = MIN(maxHeight, self.tree.rootNode.childrenNodes.count * PopupViewRowHeight);
    self.frame = CGRectMake(0, top, kScreenWidth, 0);
    [rootView addSubview:self];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.mainTableView.rowHeight = PopupViewRowHeight;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[MMNormalCell class] forCellReuseIdentifier:MainCellID];
    [self addSubview:self.mainTableView];
    
    //add shadowView
    self.shadowView.frame = CGRectMake(0, top, kScreenWidth, kScreenHeigth - top);
    self.shadowView.alpha = 0;
    self.shadowView.userInteractionEnabled = YES;
    [rootView insertSubview:self.shadowView belowSubview:self];
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToTapGestureRecognizer:)];
    tap.numberOfTouchesRequired = 1; //手指数
    tap.numberOfTapsRequired = 1; //tap次数
    [self.shadowView addGestureRecognizer:tap];
    
    //出现的动画
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.frame = CGRectMake(0, top, kScreenWidth, resultHeight);
        self.mainTableView.frame = self.bounds;
        self.shadowView.alpha = ShadowAlpha;
    } completion:^(BOOL finished) {
        completion();
        self.height += PopupViewTabBarHeight;
    }];
    
}


- (void)_callBackDelegate {
    if ([self.delegate respondsToSelector:@selector(popupView:didSelectedItemsPackagingInArray:atIndex:)]) {
        [self.delegate popupView:self didSelectedItemsPackagingInArray:self.selectedArray  atIndex:self.tag];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismiss];
        });
    }
}

#pragma mark - Action
- (void)respondsToTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self dismiss];
}

- (void)dismiss{
    [super dismiss];
    if ([self.delegate respondsToSelector:@selector(popupViewWillDismiss:)]) {
        [self.delegate popupViewWillDismiss:self];
    }
    
    CGFloat top =  CGRectGetMaxY(self.sourceFrame);
    //消失的动画
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.frame = CGRectMake(0, top, kScreenWidth, 0);
        self.mainTableView.frame = self.bounds;
        self.shadowView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tree.rootNode.childrenNodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MMNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCellID forIndexPath:indexPath];
    LHTreeNode *node = self.tree.rootNode.childrenNodes[indexPath.row];
    cell.node = node;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (self.selectedArray.count != 0) {//没有选中
        LHSelectedPath *path = [self.selectedArray lastObject];
        LHTreeNode *lastNode = self.tree.rootNode.childrenNodes[path.firstPath];
        lastNode.isSelected = NO;
        [self.selectedArray removeAllObjects];
    }
    
    LHTreeNode *node = self.tree.rootNode.childrenNodes[indexPath.row];
    node.isSelected = YES;
    [self.selectedArray addObject:[LHSelectedPath pathWithFirstPath:indexPath.row]];
    [self.mainTableView reloadData];
    [self _callBackDelegate];
}
@end
