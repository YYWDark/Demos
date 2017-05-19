//
//  ViewController.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "ViewController.h"
#import "LHComBoBoxView.h"

@interface ViewController () <LHComBoBoxViewDataSource>
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
    
    //===============================================Init===============================================
    self.comBoBoxView = [[LHComBoBoxView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    self.comBoBoxView.dataSource = self;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];
}

- (NSUInteger)numberOfColumnsIncomBoBoxView:(LHComBoBoxView *)comBoBoxView {
    return self.dataArray.count;
}

- (LHTree *)comBoBoxView:(LHComBoBoxView *)comBoBoxView infomationForColumn:(NSUInteger)column {
    return self.dataArray[column];
}


@end
