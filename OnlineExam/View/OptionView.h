//
//  RadioButton.h
//  OnlineExam
//  自定义选项视图，单选、多选、判断
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//
#import "Option.h"
#import "Question.h"
#import "Chapter.h"

@protocol OptionDelegate;
@interface OptionView: UIView

- (OptionView *)initWithQuestion:(Question *)question optionDelegate:(id<OptionDelegate>)delegate;

@end

// 单选按钮的选择事件委托
@protocol OptionDelegate <NSObject>

- (void)onOptionChecked:(Option *)option answer:(NSString *)answer;

@end