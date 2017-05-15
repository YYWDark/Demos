//
//  NSObject+MM_RunAtDealloc.m
//  Runtime_nil
//
//  Created by wyy on 2017/5/15.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "NSObject+MM_RunAtDealloc.h"
#import <objc/runtime.h>

const void *runAtDeallocBlockKey = &runAtDeallocBlockKey;

@interface NSObject (JK_RunAtDealloc)
- (void)runAtDealloc:(Block)block;

@end
@implementation NSObject (MM_RunAtDealloc)
- (void)runAtDealloc:(Block)block {
    if (block) {
        MMBlcokExecutor *executor = [[MMBlcokExecutor alloc] initWithBlock:block];
        objc_setAssociatedObject(self,
                                 runAtDeallocBlockKey,
                                 executor,
                                 OBJC_ASSOCIATION_RETAIN);
        
        [executor release];
    }
}
@end
