//
//  ViewController.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "ViewController.h"
#import "LHComBoBoxView.h"
#import "LHSelectedPath.h"
@interface ViewController () <LHComBoBoxViewDataSource, LHComBoBoxViewDelegate>
@property (nonatomic, strong) LHTree *tree;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) LHComBoBoxView *comBoBoxView;
@end

@implementation ViewController
- (IBAction)action:(id)sender {
  [self.navigationController pushViewController:[ViewController new] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    LHTree *tree = [[LHTree alloc] initWithDataArray:(NSArray *)result];
    tree.rootNode.title = @"综合排序";
    
    NSString *jsonPath1 = [[NSBundle mainBundle] pathForResource:@"data1" ofType:@"json"];
    NSData *data1 = [NSData dataWithContentsOfFile:jsonPath1];
    NSArray *result1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
   
    LHTree *tree1 = [[LHTree alloc] initWithDataArray:(NSArray *)result1];
    self.dataArray = @[tree, tree1];
    
    /*
     说明：因为给的mobile_name的数据给过来是utf8样式，所以这里的显示我使用的事idNumber
     */
    //===============================================Init===============================================
    self.comBoBoxView = [[LHComBoBoxView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    self.comBoBoxView.dataSource = self;
    self.comBoBoxView.delegate = self;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.comBoBoxView dimissPopView];
}


#pragma mark - LHComBoBoxViewDataSource
- (NSUInteger)numberOfColumnsIncomBoBoxView:(LHComBoBoxView *)comBoBoxView {
    return self.dataArray.count;
}

- (LHTree *)comBoBoxView:(LHComBoBoxView *)comBoBoxView infomationForColumn:(NSUInteger)column {
    return self.dataArray[column];
}

#pragma mark - LHComBoBoxViewDelegate
- (void)comBoBoxView:(LHComBoBoxView *)comBoBoxViewd didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index {
    LHTree *tree = self.dataArray[index];
    switch (tree.displayType) {
        case LHPopupViewDisplayTypeNormal:{
            LHSelectedPath *path = [array lastObject];
            LHTreeNode *node = tree.rootNode.childrenNodes[path.firstPath];
             NSLog(@"当前选择的node = %@",[NSString stringWithFormat:@" %ld",[node.idNumber integerValue]]);
            break;}
        case LHPopupViewDisplayTypeFilters:
            for (int i = 0; i < array.count; i ++) {
                NSMutableArray *subArray = array[i];
                NSString *parentTitle;
                NSMutableString *subTitle = [NSMutableString string];
                for (int j = 0; j < subArray.count; j ++) {
                    LHSelectedPath *path = subArray[j];
                    LHTreeNode *node = [tree findNodeWithPath:path];
                    LHTreeNode *parentNode = [tree findParentNodeWithPath:path];
                    parentTitle = [NSString stringWithFormat:@"%ld",[parentNode.idNumber integerValue]];
                    [subTitle appendString:j?[NSString stringWithFormat:@" ;%ld",[node.idNumber integerValue]]:[NSString stringWithFormat:@" %ld",[node.idNumber integerValue]]];
                }
                
                if (subArray.count == 0) {//说明没有选中
                    LHTreeNode *firstNode = tree.rootNode.childrenNodes[i];
                    switch (firstNode.numbersOfLayers) {
                        case 1:
                            NSLog(@"当前的parent ==%@  children 没有选中项",[NSString stringWithFormat:@" %ld",[firstNode.idNumber integerValue]]);
                            break;
                        case 2:{
                            BOOL isSelected = NO;
                            for (LHTreeNode *secondNode in firstNode.childrenNodes) {
                                if (secondNode.isSelected == YES) {
                                NSLog(@"当前的parent == %@ 二级选中项 == %@",[NSString stringWithFormat:@" %ld",[firstNode.idNumber integerValue]],[NSString stringWithFormat:@" %ld",[secondNode.idNumber integerValue]]);
                                    isSelected = YES;
                                }
                            }
                            if (isSelected == NO) {
                                NSLog(@"当前的parent ==%@  children 没有选中项",[NSString stringWithFormat:@" %ld",[firstNode.idNumber integerValue]]);

                            }
                            break;}
                    }
                }else{
                    NSLog(@"当前的parent == %@ children == %@",parentTitle,subTitle);
                }
            }
            break;
        default:
            break;
    }
  
}

@end
