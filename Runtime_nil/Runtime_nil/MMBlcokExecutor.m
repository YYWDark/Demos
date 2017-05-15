//
//  MMBlcokExecutor.m
//  Runtime_nil
//
//  Created by wyy on 2017/5/15.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "MMBlcokExecutor.h"

@implementation MMBlcokExecutor
- (id)initWithBlock:(Block)aBlock {
    self = [super init];
    if (self) {
        _block = [aBlock copy];
        
    }
    return self;
}


- (void)dealloc {
    if (_block != nil) {
        _block();
        [_block release];
    }
    
    [super dealloc];
}
@end
