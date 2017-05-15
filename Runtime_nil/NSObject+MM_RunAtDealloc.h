//
//  NSObject+MM_RunAtDealloc.h
//  Runtime_nil
//
//  Created by wyy on 2017/5/15.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMBlcokExecutor.h"

@interface NSObject (MM_RunAtDealloc)
- (void)runAtDealloc:(Block)block;
@end
