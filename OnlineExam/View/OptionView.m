//
//  RadioButton.m
//  OnlineExam
//
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "OptionView.h"
#import <objc/runtime.h> 

@interface OptionView () {
    id<OptionDelegate> _delegate;// 选项点击事件委托
    NSMutableArray *_optionControls;// 选项控件集合
    Question *_question;
}
@end

@implementation OptionView

- (OptionView *)initWithQuestion:(Question *)question optionDelegate:(id<OptionDelegate>)delegate {
    self = [super init];
    _delegate = delegate;
    _optionControls = [[NSMutableArray alloc] init];
    _question = question;
    
    // 选项背景图片，正常状态和高亮状态
    UIImage *bgNormal = [UIImage imageNamed:@"btn_gray"];
    UIImage *bgHighlight = [UIImage imageNamed:@"btn_blue"];
    CGFloat top = 20; // 顶端盖高度
    CGFloat bottom = 20 ; // 底端盖高度
    CGFloat left = 30; // 左端盖宽度
    CGFloat right = 30; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 伸缩后重新赋值
    bgNormal = [bgNormal resizableImageWithCapInsets:insets];
    bgHighlight = [bgHighlight resizableImageWithCapInsets:insets];
    
    // 选项左边ICON，正常状态和高亮状态
    UIImage *icNormal, *icHighlight;
    // 根据问题类型加载不同的图片
    if (_question.type == QuestionTypeRadio || _question.type == QuestionTypeJudge) {
        icNormal = [UIImage imageNamed:@"ic_radio"];
        icHighlight= [UIImage imageNamed:@"ic_radio_check"];
    } else if (_question.type == QuestionTypeMulti) {
        icNormal = [UIImage imageNamed:@"ic_multi"];
        icHighlight= [UIImage imageNamed:@"ic_multi_check"];
    }
    NSArray *imgArray = [NSArray arrayWithObjects:bgNormal, bgHighlight, icNormal, icHighlight, nil];
    
    NSArray *options = question.options;
    float yOffset = 0;// 选项控件Y方向偏移
    for (int i = 0; i < options.count; i ++) {
        Option *option = options[i];
        yOffset += [self addViewWithOption:option imgArray:imgArray yOffset:yOffset];
        yOffset += 5;
    }
    self.frame = CGRectMake(0, 0, 280, yOffset);
    return self;
}

- (int)addViewWithOption:(Option *)option imgArray:(NSArray *)imgArray yOffset:(float)yOffset {
    UIControl *cOption = [[UIControl alloc] initWithFrame:CGRectMake(0, yOffset, 280, 40)];
    
    // 选项的文本
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(45, 6, 230, 0)];
    text.backgroundColor = [UIColor clearColor];
    text.textColor = [UIColor whiteColor];
    text.font = [UIFont systemFontOfSize:14];
    text.text = option.text;
    text.lineBreakMode = NSLineBreakByWordWrapping;
    text.numberOfLines = 0;
    CGSize sizeFrame =[option.text sizeWithFont:text.font constrainedToSize:CGSizeMake(text.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    text.frame = CGRectMake(45,6,sizeFrame.width,sizeFrame.height);
    
    // 选项背景图片控件
    UIImageView *ivBg = [[UIImageView alloc] initWithImage:imgArray[0] highlightedImage:imgArray[1]];
    ivBg.frame = CGRectMake(0, 0, 280, text.frame.size.height + 14);
    ivBg.tag = 1;
    
    // 选项左边ICON图片控件
    UIImageView *ivHead = [[UIImageView alloc] initWithImage:imgArray[2] highlightedImage:imgArray[3]];
    int imageW = ivHead.image.size.width;
    int imageH = ivHead.image.size.height;
    ivHead.frame = CGRectMake(0, (ivBg.frame.size.height - imageH)/2, imageW, imageH);
    ivHead.tag = 2;
    
    [cOption addSubview:ivBg];
    [cOption addSubview:ivHead];
    [cOption addSubview:text];
    cOption.frame = CGRectMake(0, yOffset, 280, ivBg.frame.size.height);
    
    // 添加选项点击事件监听
    if (_question.type == QuestionTypeRadio || _question.type == QuestionTypeJudge) {
        [cOption addTarget:self action:@selector(onRadioChecked:) forControlEvents:UIControlEventTouchUpInside];
    } else if (_question.type == QuestionTypeMulti) {
        [cOption addTarget:self action:@selector(onMultiChecked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:cOption];
    objc_setAssociatedObject(cOption, &"option", option, OBJC_ASSOCIATION_RETAIN);
    [_optionControls addObject:cOption];
    return cOption.frame.size.height;
}

// 单选事件监听
- (void)onRadioChecked:(UIControl *)cOption {
    for (UIControl *control in _optionControls) {
        UIImageView *ivBg = (UIImageView *)[control viewWithTag:1];
        UIImageView *ivHead = (UIImageView *)[control viewWithTag:2];
        if (control == cOption && !ivBg.highlighted) {
            ivBg.highlighted = YES;
            ivHead.highlighted = YES;
            Option *option = objc_getAssociatedObject(control, &"option");
            [_delegate onOptionChecked:option answer:option.value];
        } else if (ivBg.highlighted){
            ivBg.highlighted = NO;
            ivHead.highlighted = NO;
        }
    }
}

// 多选事件监听
- (void)onMultiChecked:(UIControl *)cOption {
    NSMutableString *answer = [[NSMutableString alloc] init];
    Option *option = objc_getAssociatedObject(cOption, &"option");
    for (UIControl *control in _optionControls) {
        UIImageView *ivBg = (UIImageView *)[control viewWithTag:1];
        UIImageView *ivHead = (UIImageView *)[control viewWithTag:2];
        if (control == cOption) {
            ivBg.highlighted = ivBg.highlighted ? NO : YES;
            ivHead.highlighted = ivHead.highlighted ? NO : YES;
        }
        if (ivBg.highlighted) {
            Option *temp = objc_getAssociatedObject(control, &"option");
            [answer appendFormat:@"%@,",temp.value];
        }
    }
    if ([StringUtil isNotTrimBlank:answer]) {
        [_delegate onOptionChecked:option answer:[answer substringToIndex:answer.length - 1]];
    }
}

@end
