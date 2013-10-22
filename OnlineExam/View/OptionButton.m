//
//  RadioButton.m
//  OnlineExam
//
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "OptionButton.h"

@interface OptionButton () {
    UIImageView *_ivBg, *_ivHead;
    id<OptionDelegate> _delegate;
    Option *_option;
}

@end

@implementation OptionButton

- (OptionButton *)initWithOption:(Option *)option optionDelegate:(id<OptionDelegate>)delegate {
    self = [super init];
    self.frame = CGRectMake(0, 0, 280, 40);
    _delegate = delegate;
    _option = option;
    
    UIImage *bg = [UIImage imageNamed:@"btn_gray"];
    UIImage *bgHighLight = [UIImage imageNamed:@"btn_blue"];
    CGFloat top = 10; // 顶端盖高度
    CGFloat bottom = 10 ; // 底端盖高度
    CGFloat left = 20; // 左端盖宽度
    CGFloat right = 20; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 伸缩后重新赋值
    bg = [bg resizableImageWithCapInsets:insets];
    bgHighLight = [bgHighLight resizableImageWithCapInsets:insets];
    // 背景图片
    _ivBg = [[UIImageView alloc] initWithImage:bg highlightedImage:bgHighLight];
    _ivBg.frame = self.frame;
    [self addSubview:_ivBg];
    
    UIImage *nomarlImage = nil, *highlightedImage = nil;
    // 根据问题类型加载不同的图片
    if (option.questionType == QuestionTypeRadio || option.questionType == QuestionTypeJudge) {
        nomarlImage = [UIImage imageNamed:@"ic_radio"];
        highlightedImage= [UIImage imageNamed:@"ic_radio_check"];
    } else if (option.questionType == QuestionTypeMulti) {
        nomarlImage = [UIImage imageNamed:@"ic_multi"];
        highlightedImage= [UIImage imageNamed:@"ic_multi_check"];
    }
    _ivHead = [[UIImageView alloc] initWithImage:nomarlImage highlightedImage:highlightedImage];
    _ivHead.frame = CGRectMake(0, 5, nomarlImage.size.width, nomarlImage.size.height);
    [self addSubview:_ivHead];
    
    // 选项的文本
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 225, 28)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.text = option.text;
    [self addSubview:label];
    
    // 添加手势监听点击事件
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onChecked)];
    [self addGestureRecognizer:tapGestureRecognizer];
    return self;
}

- (void)onChecked {
    _ivBg.highlighted = YES;
    _ivHead.highlighted = YES;
    [_delegate onChecked:_option];
}

@end
