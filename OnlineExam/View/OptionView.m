//
//  RadioButton.m
//  OnlineExam
//
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "OptionView.h"

@interface OptionView () {
    id<OptionDelegate> _delegate;
    Chapter *_chapter;
}

@end

@implementation OptionView

- (OptionView *)initWithQuestion:(Question *)question chapter:(Chapter *)chapter optionDelegate:(id<OptionDelegate>)delegate {
    self = [super init];
    _delegate = delegate;
    _chapter = chapter;
    
    NSArray *options = question.options;
    
    float y = 0;
    for (int i = 0; i < options.count; i ++) {
        Option *option = options[i];
        [self addViewWithOption:option question:question yOffset:y];
        y += 45;
    }
//    self.frame = CGRectMake(0, 0, 280, y);
    return self;
}

- (void)addViewWithOption:(Option *)option question:(Question *)question yOffset:(float)yOffset {
    UIImage *bg = [UIImage imageNamed:@"btn_gray"];
    UIImage *bgHighLight = [UIImage imageNamed:@"btn_blue"];
    CGFloat top = 10; // 顶端盖高度
    CGFloat bottom = 10 ; // 底端盖高度
    CGFloat left = 30; // 左端盖宽度
    CGFloat right = 30; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 伸缩后重新赋值
    bg = [bg resizableImageWithCapInsets:insets];
    bgHighLight = [bgHighLight resizableImageWithCapInsets:insets];
    // 选项背景图片
    UIImageView *ivBg = [[UIImageView alloc] initWithImage:bg highlightedImage:bgHighLight];
    ivBg.frame = CGRectMake(0, yOffset, 280, 40);
    [self addSubview:ivBg];
    
    UIImage *nomarlImage = nil, *highlightedImage = nil;
    // 根据问题类型加载不同的图片
    if (question.type == QuestionTypeRadio || question.type == QuestionTypeJudge) {
        nomarlImage = [UIImage imageNamed:@"ic_radio"];
        highlightedImage= [UIImage imageNamed:@"ic_radio_check"];
    } else if (question.type == QuestionTypeMulti) {
        nomarlImage = [UIImage imageNamed:@"ic_multi"];
        highlightedImage= [UIImage imageNamed:@"ic_multi_check"];
    }
    
    // 选项左边图片
    UIImageView *ivHead = [[UIImageView alloc] initWithImage:nomarlImage highlightedImage:highlightedImage];
    ivHead.frame = CGRectMake(0, yOffset + 5, nomarlImage.size.width, nomarlImage.size.height);
    [self addSubview:ivHead];
    
    // 选项的文本
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, yOffset + 5, 225, 28)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.text = option.text;
    [self addSubview:label];
    
    // 添加手势监听点击事件
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onChecked)];
//    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)onChecked {
//    _ivBg.highlighted = YES;
//    _ivHead.highlighted = YES;
//    [_delegate onChecked:_option];
}

@end
