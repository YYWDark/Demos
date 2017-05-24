//
//  LHPopupView.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHPopupView.h"
#import "LHFiltersCell.h"
#import "LHSelectedPath.h"
@interface LHPopupView () <UITableViewDelegate, UITableViewDataSource, LHFiltersCellDelegate>
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, assign) NSInteger lastIndex;
@property (nonatomic, assign) BOOL isSuccessfulToCallBack;
@end

@implementation LHPopupView
- (id)initWithTree:(LHTree *)tree {
    self = [self init];
    if (self) {
        self.lastIndex = -1;
        self.tree = tree;
        [self _findSelectedItem];
        self.temporaryArray= [[[NSMutableArray alloc] initWithArray:self.selectedArray copyItems:YES] mutableCopy];
    }
    return self;
}

- (void)_findSelectedItem {
    [self.tree.rootNode.childrenNodes enumerateObjectsUsingBlock:^(LHTreeNode * _Nonnull firstNode, NSUInteger firstIndex, BOOL * _Nonnull stop) {
        [self.selectedArray addObject:[NSMutableArray array]];
        for (int secondIndex = 0; secondIndex < firstNode.childrenNodes.count; secondIndex ++) {
            LHTreeNode *secondNode = firstNode.childrenNodes[secondIndex];
            switch (firstNode.numbersOfLayers) {
                    case 1:{//二级的为多选
                        if (secondNode.isSelected == YES) {
                           LHSelectedPath *path = [LHSelectedPath pathWithFirstPath:firstIndex secondPath:secondIndex];
                           NSMutableArray *array = [self.selectedArray lastObject];
                           [array addObject:path];
                        }
                        firstNode.firstOpenStatus = LHTreeNodeFirstClose;
                        
                        break;}
                    case 2:{//二级的为单选，因为还有三级
                        firstNode.firstOpenStatus = LHTreeNodeFirstClose;
                        if (secondNode.isSelected == YES) {//第二层选中，然后遍历第三层的
                            for (int thirdIndex = 0; thirdIndex <secondNode.childrenNodes.count; thirdIndex++) {
                                LHTreeNode *thirdNode = secondNode.childrenNodes[thirdIndex];
                                if (thirdNode.isSelected == YES) {
                                    LHSelectedPath *path = [LHSelectedPath pathWithFirstPath:firstIndex secondPath:secondIndex thirdPath:thirdIndex];
                                    NSMutableArray *array = [self.selectedArray lastObject];
                                    [array addObject:path];
                                }
                            }
                            break;
                        }
                        break;}
                    default:
                        break;
                }
        }
    }];
}

//清除掉self.selectedArray里面的选中项
- (void)_clearItemsStateOfSelectedArray {
    //可能e
    for (LHTreeNode *firstNode in self.tree.rootNode.childrenNodes) {
        if (firstNode.numbersOfLayers == 2) {
            for (LHTreeNode *node in firstNode.childrenNodes) {
                node.isSelected = NO;
            }
        }
    }
    
    for (int i = 0; i < self.selectedArray.count; i ++) {
        NSMutableArray *mutableArray = self.selectedArray[i];
        for (int j = 0; j < mutableArray.count; j ++) {
            LHSelectedPath *path  =  mutableArray[j];
            LHTreeNode *node = [self findNodeByPath:path];
            node.isSelected = NO;
            if (path.thirdPath != -1) {
                LHTreeNode *secondNode = self.tree.rootNode.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
                secondNode.isSelected = NO;
            }
        }
        [mutableArray removeAllObjects];
    }
}

- (void)_setTreeTheOriginalState {
    // 因为取消的操作 把树结构的值恢复到最初的状态
    for (int i = 0; i < self.selectedArray.count; i ++) {
        NSMutableArray *mutableArray = self.temporaryArray[i];
        for (int j = 0; j < mutableArray.count; j ++) {
            LHSelectedPath *path  =  mutableArray[j];
            LHTreeNode *node = [self findNodeByPath:path];
            node.isSelected = YES;
            if (path.thirdPath != -1) {
                LHTreeNode *secondNode = self.tree.rootNode.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
                secondNode.isSelected = YES;
            }
        }
    }
    
}
//恢复到最初状态
- (void)_recoverToTheOriginalState {
    if (self.isSuccessfulToCallBack == NO) {
        [self _clearItemsStateOfSelectedArray];
        [self _setTreeTheOriginalState];
    }
}

- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void (^)(void))completion {
   UIView *rootView = [[UIApplication sharedApplication] keyWindow];
   self.sourceFrame = frame;
   CGFloat top =  CGRectGetMaxY(self.sourceFrame);
   CGFloat resultHeight = kScreenHeigth - top - PopupViewTabBarHeight;
   self.frame = CGRectMake(0, top, kScreenWidth, 0);
   [rootView addSubview:self];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    self.mainTableView.backgroundColor = [UIColor colorWithHexString:@"E7E7E7"];
    self.mainTableView.rowHeight = PopupViewRowHeight;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [UIView new];
    [self.mainTableView registerClass:[LHFiltersCell class] forCellReuseIdentifier:MainCellID];
    [self addSubview:self.mainTableView];
    
    //出现的动画
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.frame = CGRectMake(0, top, kScreenWidth, resultHeight);
        self.mainTableView.frame = self.bounds;
    } completion:^(BOOL finished) {
        completion();
        self.height += PopupViewTabBarHeight;
        self.bottomView = [[UIView alloc] init];
        self.bottomView.backgroundColor = [UIColor colorWithHexString:@"FCFAFD"];
        self.bottomView.frame = CGRectMake(0, self.mainTableView.bottom, self.width, PopupViewTabBarHeight);
        [self addSubview:self.bottomView];
        
        NSArray *titleArray = @[@"重置",@"开始筛选"];
        for (int i = 0; i < 2 ; i++) {
            UIColor *titleColor = ((i == 0)?[UIColor colorWithHexString:ThemeColor]:[UIColor whiteColor]);
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = ((i == 1)?[UIColor colorWithHexString:ThemeColor]:[UIColor whiteColor]);
            button.frame = CGRectMake(i*kScreenWidth/2, 0, kScreenWidth/2, PopupViewTabBarHeight);
            button.tag = i;
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:titleColor forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:ButtonFontSize];
            [button addTarget:self action:@selector(respondsToButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:button];
        }
    }];
}

- (void)dismiss{
    if ([self.delegate respondsToSelector:@selector(popupViewWillDismiss:)]) {
        [self.delegate popupViewWillDismiss:self];
    }
    
    [self closeUIControl];
    [self _recoverToTheOriginalState];
    self.bottomView.hidden = YES;
    CGFloat top =  CGRectGetMaxY(self.sourceFrame);
    //消失的动画
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.frame = CGRectMake(0, top, kScreenWidth, 0);
        self.mainTableView.frame = self.bounds;
        
    } completion:^(BOOL finished) {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
}

 //UI都要关闭
- (void)closeUIControl {
    for (LHTreeNode *firstNode in self.tree.rootNode.childrenNodes) {
        firstNode.firstOpenStatus = LHTreeNodeFirstClose;
        firstNode.secondOpenStatus = LHTreeNodeSecondClose;
    }
}
#pragma mark - Action
- (LHTreeNode *)findNodeByPath:(LHSelectedPath *)path {
    if (path.thirdPath == -1) {
        return self.tree.rootNode.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
    }
    return self.tree.rootNode.childrenNodes[path.firstPath].childrenNodes[path.secondPath].childrenNodes[path.thirdPath];
}

- (void)respondsToButtonAction:(UIButton *)sender {
    if (sender.tag == 0) {//重置
        //将self.selectedArray数组选中项设置为NO
        [self _clearItemsStateOfSelectedArray];
        
        [self closeUIControl];
    } else if (sender.tag == 1) {//开始筛选
        if ([self.delegate respondsToSelector:@selector(popupView:didSelectedItemsPackagingInArray:atIndex:)]) {
             self.isSuccessfulToCallBack = YES;
            [self.delegate popupView:self didSelectedItemsPackagingInArray:self.selectedArray atIndex:self.tag];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismiss];
                self.isSuccessfulToCallBack = NO;
            });
        }
    }    
    [self.mainTableView reloadData];
}

- (void)respondsToTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
   [self dismiss];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tree.rootNode.childrenNodes.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHFiltersCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LHTreeNode *node = self.tree.rootNode.childrenNodes[indexPath.section];
    cell.node = node;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   LHTreeNode *node = self.tree.rootNode.childrenNodes[indexPath.section];
    CGFloat heigth = [node getCellHeight];
//    NSLog(@"heigth == %lf",heigth);
    return heigth;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.0f;
}
#pragma mark - LHFiltersCellDelegate
- (void)filtersCell:(LHFiltersCell *)cell didTapTopViewAtIndex:(NSUInteger)index {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    LHTreeNode *firstNode = self.tree.rootNode.childrenNodes[indexPath.section];
    switch (index) {
        case 0:{ //第一层，类似于大类
            //收起其他项
            for (int i = 0; i < self.tree.rootNode.childrenNodes.count; i ++) {
                if (i == indexPath.section) continue;
                LHTreeNode *node = self.tree.rootNode.childrenNodes[i];
                node.firstOpenStatus = LHTreeNodeFirstClose;
                node.secondOpenStatus = LHTreeNodeSecondClose;
            }
            
            if (firstNode.firstOpenStatus == LHTreeNodeFirstClose) {
                firstNode.firstOpenStatus = LHTreeNodeFirstOpen;
            }else if (firstNode.firstOpenStatus == LHTreeNodeFirstOpen) {
                firstNode.firstOpenStatus = LHTreeNodeFirstClose;
                firstNode.secondOpenStatus = LHTreeNodeSecondClose;
            }
            
            break;}
        case 1:
            if (firstNode.secondOpenStatus == LHTreeNodeSecondClose) {
                firstNode.secondOpenStatus = LHTreeNodeSecondOpen;
            }else if (firstNode.secondOpenStatus == LHTreeNodeSecondOpen) {
                firstNode.secondOpenStatus = LHTreeNodeSecondClose;
            }
            break;
        default:
            break;
    }
    [self.mainTableView reloadData];
}


- (void)filtersCell:(LHFiltersCell *)cell didTapButtonAtIndex:(NSUInteger)index topViewTag:(NSUInteger)tag; {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    LHTreeNode *firstNode = self.tree.rootNode.childrenNodes[indexPath.section];
    
    switch (tag) {
        case 0:{ //第一层，类似于大类
              LHTreeNode *secondNode = firstNode.childrenNodes[index];
            if (firstNode.numbersOfLayers == 1) {//多选
                //添加第二层节点
                NSMutableArray *mutableArray = self.selectedArray[indexPath.section];
                if (secondNode.isSelected) { //如果选中则去删除掉
                    [mutableArray removeObject:[self findSelectedNodeWithsecondIndex:index withArray:mutableArray]];
                }else {
                    [mutableArray addObject:[LHSelectedPath pathWithFirstPath:indexPath.section secondPath:index]];
                }
                secondNode.isSelected = !secondNode.isSelected;
            }else {//单选
                //先找出之前可能选中的设置为NO
                if([firstNode isLargeClassSelected]){
                    //拿到选中的
                    LHTreeNode *node = [[firstNode nodesOfLargeClassSelected] lastObject];
                    //把第三相应的子节点的selected属性都设置为NO
                    NSMutableArray *mutableArray = self.selectedArray[indexPath.section];
                    for (LHSelectedPath *path in mutableArray) {
                        firstNode.childrenNodes[path.secondPath].childrenNodes[path.thirdPath].isSelected = NO;
                    }
                    [mutableArray removeAllObjects];
                    
                      node.isSelected = NO;
                    //如果是同一个,取消并且收起来第三列
                    if (node == secondNode) {
                        firstNode.secondOpenStatus =  LHTreeNodeSecondClose;
                        [self.mainTableView reloadData];
                        return;
                    }
                }
                
                secondNode.isSelected = YES;
                firstNode.secondOpenStatus =  LHTreeNodeSecondOpen;
            }
            
            break;}
        case 1:{
            LHTreeNode *selectedNode = [[firstNode nodesOfLargeClassSelected] lastObject];
            LHTreeNode *thirdNode = selectedNode.childrenNodes[index];
           
            //添加第三层节点
            NSMutableArray *mutableArray = self.selectedArray[indexPath.section];
            NSUInteger secondPath  = [firstNode.childrenNodes indexOfObject:selectedNode];
            if (thirdNode.isSelected) { //如果选中则去删除掉
                [mutableArray removeObject:[self findSelectedNodeWithThirdIndex:index withArray:mutableArray]];
            }else {
               [mutableArray addObject:[LHSelectedPath pathWithFirstPath:indexPath.section secondPath:secondPath thirdPath:index]];
            }
            thirdNode.isSelected = !thirdNode.isSelected;
            break;}
        default:
            break;
    }
    [self.mainTableView reloadData];

}

- (LHSelectedPath *)findSelectedNodeWithThirdIndex:(NSInteger)index withArray:(NSMutableArray *)mutableArray {
    for (LHSelectedPath *path in mutableArray) {
        if (path.thirdPath == index) {
            return path;
        }
    }
    return nil;
}

- (LHSelectedPath *)findSelectedNodeWithsecondIndex:(NSInteger)index withArray:(NSMutableArray *)mutableArray {
    for (LHSelectedPath *path in mutableArray) {
        if (path.secondPath == index) {
            return path;
        }
    }
    return nil;
}
@end
