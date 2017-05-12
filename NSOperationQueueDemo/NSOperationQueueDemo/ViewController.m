//
//  ViewController.m
//  NSOperationQueueDemo
//
//  Created by wyy on 2017/5/10.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "ViewController.h"
#import "MMOperation.h"
//#define Debug
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
#ifdef Debug
    [self gcd_serialQueueTask];
    [self gcd_currentQueueTask];
    
    [self operation_serialQueueTask];
#endif
    [self keepThreadAlive];
    
}

- (void)keepThreadAlive {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadProc) object:nil];
    [thread start];
}

- (void)threadProc
{
    //线程保活 一般用于NSURLConnection,没有后台下载的情况，保证回调线程不退出
    //你可以看看AFNWorking 版本2**
    @autoreleasepool {
        [[NSThread currentThread] setName:@"wyy."];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        NSLog(@"threadProc");
        [runLoop run];
    }

}

- (void)gcd_serialQueueTask {
    //串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("com.wyy.testQueue", NULL);
    dispatch_async(serialQueue, ^{
        NSLog(@"1");
        NSLog(@"当前的线程 == %@",[NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
        NSLog(@"当前的线程 == %@",[NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"3");
        NSLog(@"当前的线程 == %@",[NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"4");
        NSLog(@"当前的线程 == %@",[NSThread currentThread]);
    });
}

- (void)gcd_currentQueueTask {
    //并行队列
    dispatch_queue_t currentQueue = dispatch_queue_create("com.wyy.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(currentQueue, ^{
        NSLog(@"1");
        NSLog(@"当前的线程 == %@",[NSThread currentThread]);
    });
    
    dispatch_async(currentQueue, ^{
        NSLog(@"2");
        NSLog(@"当前的线程 == %@",[NSThread currentThread]);
    });
    
    dispatch_async(currentQueue, ^{
        NSLog(@"3");
        NSLog(@"当前的线程 == %@",[NSThread currentThread]);
    });
    
    dispatch_async(currentQueue, ^{
        NSLog(@"4");
        NSLog(@"当前的线程 == %@",[NSThread currentThread]);
    });
}

- (void)operation_serialQueueTask {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //当maxConcurrentOperationCount设置为1的时候为串行队列
    queue.maxConcurrentOperationCount = 2;
    
    __block int i = 1000;
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^(){
        while (i > 0) {
            NSLog(@"i == %d",i);
            i -- ;
        }
        NSLog(@"执行第1次操作，线程：%@", [NSThread currentThread]);
        
    }];
    
    __block int j = 1000;
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^(){
        while (j > 0) {
            NSLog(@"j == %d",j);
            j -- ;
        }
        NSLog(@"执行第2次操作，线程：%@", [NSThread currentThread]);
    }];
    
    MMOperation *mm_operation = [MMOperation new];
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:mm_operation];

    //阻塞当前的线程
//    [queue waitUntilAllOperationsAreFinished];
    
    
}


@end
