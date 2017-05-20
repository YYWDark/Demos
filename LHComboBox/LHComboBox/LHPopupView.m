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
@interface LHPopupView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *bottomView;

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
    
    self.mainTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.mainTableView.rowHeight = PopupViewRowHeight;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tree.rootNode.childrenNodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHFiltersCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCellID forIndexPath:indexPath];
    LHTreeNode *node = self.tree.rootNode.childrenNodes[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",[node.idNumber integerValue]];;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   LHTreeNode *node = self.tree.rootNode.childrenNodes[indexPath.row];
    return [node getCellHeight];
}


@end
