//
//  ViewController.m
//  KeepViewTopLocationDemo
//
//  Created by wyy on 2017/5/12.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isRight) {
       self.view.backgroundColor = [UIColor whiteColor];
    }else {
       self.view.backgroundColor = [UIColor yellowColor];
    }
//    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewController *vc = [ViewController new];
    vc.isRight = YES;
//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
//    UIView * viewAlert = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
//    viewAlert.backgroundColor = [UIColor purpleColor];
////    viewAlert.layer.zPosition = MAXFLOAT;
//    [[UIApplication sharedApplication].keyWindow addSubview:viewAlert];
    
    
}


@end
