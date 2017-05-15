//
//  ViewController.m
//  Runtime_nil
//
//  Created by wyy on 2017/5/15.
//  Copyright © 2017年 wyy. All rights reserved.
//http://blog.slaunchaman.com/2011/04/11/fun-with-the-objective-c-runtime-run-code-at-deallocation-of-any-object/
//https://www.zybuluo.com/qidiandasheng/note/486829

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSObject *foo = [[NSObject alloc] init];
    
    __block id objectRef = foo;
    
    [foo runAtDealloc:^{
        NSLog(@"Deallocating foo at address %p!", objectRef);
    }];
    
    [foo release];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
