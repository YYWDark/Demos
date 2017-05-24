//
//  ViewController.h
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHComBoBoxView.h"
#import "LHSelectedPath.h"
@interface ViewController : UIViewController
@property (nonatomic, strong) LHTree *tree;
@property (nonatomic, assign) BOOL isForSecondPage;
@end

