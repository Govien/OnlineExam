//
//  RadioButton.h
//  OnlineExam
//
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//
#import "Option.h"

@protocol OptionDelegate;
@interface OptionButton : UIView

- (OptionButton *)initWithOption:(Option *)option optionDelegate:(id<OptionDelegate>)delegate;

@end

// 单选按钮的选择事件委托
@protocol OptionDelegate <NSObject>

- (void)onChecked:(Option *)option;

@end