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
@end

@implementation LHPopupView
- (instancetype)init {
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (id)initWithTree:(LHTree *)tree {
    self = [self init];
    if (self) {
        self.lastIndex = -1;
        self.tree = tree;
        [self _findSelectedItem];
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
                        if (secondNode.isSelected == YES) {
                            for (int thirdIndex = 0; thirdIndex > 0; thirdIndex++) {
                                LHTreeNode *thirdNode = firstNode.childrenNodes[thirdIndex];
                                if (thirdNode.isSelected == YES) {
                                    LHSelectedPath *path = [LHSelectedPath pathWithFirstPath:firstIndex secondPath:secondIndex thirdPath:thirdIndex];
                                    NSMutableArray *array = [self.selectedArray lastObject];
                                    [array addObject:path];
                                    firstNode.secondOpenStatus = LHTreeNodeSecondOpen;
                                }
                            }
                            continue;
                        }
                        break;}
                    default:
                        break;
                }
          
        }
    }];
}

- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void (^)(void))completion {
   UIView *rootView = [[UIApplication sharedApplication] keyWindow];
   self.sourceFrame = frame;
   CGFloat top =  CGRectGetMaxY(self.sourceFrame);
   CGFloat resultHeight = kScreenHeigth - top - DistanceBeteewnPopupViewAndBottom;
   self.frame = CGRectMake(0, top, kScreenWidth, 0);
   [rootView addSubview:self];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    self.mainTableView.backgroundColor = [UIColor darkTextColor];
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
        
        NSArray *titleArray = @[@"取消",@"确定"];
        for (int i = 0; i < 2 ; i++) {
            CGFloat left = ((i == 0)?ButtonHorizontalMargin:self.width - ButtonHorizontalMargin - 100);
            UIColor *titleColor = ((i == 0)?[UIColor blackColor]:[UIColor colorWithHexString:titleSelectedColor]);
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(left, 0, 100, PopupViewTabBarHeight);
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

#pragma mark - Action
- (void)respondsToButtonAction:(UIButton *)sender {
  
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
    NSLog(@"indexPath == %ld heigth == %lf",indexPath.section,heigth);
    return heigth;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
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
                secondNode.isSelected = !secondNode.isSelected;
            }else {//单选
                //先找出之前可能选中的设置为NO
                if([firstNode isLargeClassSelected]){
                    LHTreeNode *node = [[firstNode nodesOfLargeClassSelected] lastObject];
                    if (node == secondNode) {//如果是同一个,取消并且收起来第三列
                        node.isSelected = NO;
                        firstNode.secondOpenStatus =  LHTreeNodeSecondClose;
                        [self.mainTableView reloadData];
                        return;
                    }
                    node.isSelected = NO;
                }
                secondNode.isSelected = YES;
                firstNode.secondOpenStatus =  LHTreeNodeSecondOpen;
            }
            
            break;}
        case 1:{
            LHTreeNode *selectedNode = [[firstNode nodesOfLargeClassSelected] lastObject];
            LHTreeNode *thirdNode = selectedNode.childrenNodes[index];
            thirdNode.isSelected = !thirdNode.isSelected;
            break;}
        default:
            break;
    }
    [self.mainTableView reloadData];

}
@end
