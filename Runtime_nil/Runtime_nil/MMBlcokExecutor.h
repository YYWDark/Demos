//
//  MMBlcokExecutor.h
//  Runtime_nil
//
//  Created by wyy on 2017/5/15.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Block)(void);

@interface MMBlcokExecutor : NSObject
@property (nonatomic, readwrite, copy) Block block;

- (id)initWithBlock:(Block)aBlock;
@end
