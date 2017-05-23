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

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error = nil;
    NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"\n%@", [error localizedDescription]);
   
    self.tree = [[LHTree alloc] initWithDataArray:(NSArray *)result];
    self.dataArray = @[self.tree, self.tree];
    
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
            LHTreeNode *firstNode = tree.rootNode.childrenNodes[index];
            NSLog(@"当前的parent ==%@  children 没有选中项",[NSString stringWithFormat:@" %ld",[firstNode.idNumber integerValue]]);
        }else {
          NSLog(@"当前的parent == %@ children == %@",parentTitle,subTitle);
        }
        
    }
}

@end
