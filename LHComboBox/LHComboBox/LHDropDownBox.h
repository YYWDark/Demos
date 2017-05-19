//
//  LHDropDownBox.h
//  LHComboBox
//
//  Created by wyy on 2017/5/19.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LHDropDownBoxDelegate;
@interface LHDropDownBox : UIView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, weak) id<LHDropDownBoxDelegate> delegate;

- (id)initWithFrame:(CGRect)frame titleName:(NSString *)title;
- (void)updateTitleState:(BOOL)isSelected;
- (void)updateTitleContent:(NSString *)title;
@end


@protocol LHDropDownBoxDelegate <NSObject>
/*点击了dropDownBox**/
- (void)didTapDropDownBox:(LHDropDownBox *)dropDownBox atIndex:(NSUInteger)index;
@end
