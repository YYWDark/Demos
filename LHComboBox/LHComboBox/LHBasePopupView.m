//
//  LHBasePopupView.m
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "LHBasePopupView.h"
#import "LHPopupView.h"
#import "LHSinglePopupView.h"
@interface LHBasePopupView ()

@end

@implementation LHBasePopupView
- (id)initWithTree:(LHTree *)tree {
    self = [self init];
    if (self) {
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

+ (LHBasePopupView *)getSubPopupViewWithTree:(LHTree *)tree {
    LHBasePopupView *view;
    switch (tree.displayType) {
        case LHPopupViewDisplayTypeNormal:
            view =  [[LHSinglePopupView alloc] initWithTree:tree];
            break;
        case LHPopupViewDisplayTypeFilters:
            view =  [[LHPopupView alloc] initWithTree:tree];
            break;
       
        default:
            break;
    }
    return view;
}

- (void)dismiss {
   
}

- (void)dismissWithOutAnimation {
  
}

- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void (^)(void))completion {
    //写这些方法是为了消除警告；
}
@end
