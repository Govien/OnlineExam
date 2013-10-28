//
//  VCQuestion.m
//  OnlineExam
//  
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "VCQuestion.h"
#import "OptionView.h"
#import "DataHelper.h"
#import "CMPopTipView.h"

@interface VCQuestion ()<Handler, OptionDelegate> {
    DataHelper *_dataHelper;
    int _userId, _lastOrder, _questionCount;
    NSMutableDictionary *_questionDics;
    OptionView *_optionView;
    NSString *_answer;
    Question *_currentQuestion;
    CMPopTipView *_popTipView;
}

@property (weak, nonatomic) IBOutlet UILabel *lblNo;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *vContent;

@end

@implementation VCQuestion

@synthesize chapter = _chapter;
static const int _pageSize = 10;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = _chapter.name;
    _dataHelper = [DataHelper init:self];
    _questionCount = _chapter.totalCount;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg5.jpg"]];
    _vContent.backgroundColor = [UIColor clearColor];
    _userId = [[NSUserDefaults standardUserDefaults] integerForKey:INFO_USERID];
    [self.view makeToastActivity];
    [_dataHelper getLastQuestionOrderOfChapter:_chapter.ID userId:_userId];
}

// 显示问题视图
- (void)displayQuestionView:(Question *)question {
    _currentQuestion = question;
    if (_optionView) {
        [_optionView removeFromSuperview];
    }
    NSMutableString *mutableNo= [[NSMutableString alloc] init];
    if (question.type == QuestionTypeJudge) {
        [mutableNo appendString:@"[判断题]"];
    } else if (question.type == QuestionTypeRadio) {
        [mutableNo appendString:@"[单项选择题]"];
    } else if (question.type == QuestionTypeMulti) {
        [mutableNo appendString:@"[多项选择题]"];
    }
    [mutableNo appendFormat:@" 第%d / %d题：", _lastOrder, _chapter.totalCount];
    _lblNo.text = mutableNo;
    _lblTitle.text = question.title;
    _optionView = [[OptionView alloc] initWithQuestion:question optionDelegate:self];
    [_vContent addSubview:_optionView];
}

// 显示上一问题
- (void)preQuestion {
    [self commitAnswer];
    if (_lastOrder < 2) {
        [self.view makeToast:@"前面没题目啦~~~"];
    } else {
        Question *question = [_questionDics objectForKey:[NSNumber numberWithInt:(_lastOrder - 1)]];
        if (question) {
            _lastOrder--;
            [self displayQuestionView:question];
        } else {
            [self.view makeToastActivity];
            [_dataHelper getQuestionsBeforOrder:_lastOrder chapterId:_chapter.ID userId:_userId pageSize:_pageSize];
        }
    }
}

// 显示下一问题
- (void)nextQuestion {
    [self commitAnswer];
    if (_lastOrder + 1 > _questionCount) {
        [self.view makeToast:@"这已经是最后一题啦！"];
    } else {
        Question *question = [_questionDics objectForKey:[NSNumber numberWithInt:(_lastOrder + 1)]];
        if (question) {
            _lastOrder++;
            [self displayQuestionView:question];
        } else {
            [self.view makeToastActivity];
            [_dataHelper getQuestionsAfterOrder:_lastOrder chapterId:_chapter.ID userId:_userId pageSize:_pageSize];
        }
    }
}

// 提交答案
- (void)commitAnswer {
    [self closeTip];
    if ([StringUtil isNotTrimBlank:_answer]) {
        [_dataHelper commitAnswerOfQuestion:_currentQuestion.ID chapterId:_chapter.ID userId:_userId answer:_answer];
        _answer = nil;
    }
}

// 答案解析，弹出气泡提示
- (void)showTip:(UIView *)view {
    if (_popTipView) {
        return;
    }
    UIView *vTip = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 55)];
    UIImageView *ivClose = [[UIImageView alloc] initWithFrame:CGRectMake(262, 0, 18, 18)];
    UILabel *lblAnswer = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, 260, 20)];
    UIImageView *ivLine = [[UIImageView alloc] initWithFrame:CGRectMake(5, 48, 270, 1)];
    UITextView *tvTip = [[UITextView alloc] initWithFrame:CGRectMake(5, 55, 270, 0)];
    vTip.backgroundColor = [UIColor clearColor];
    tvTip.backgroundColor = [UIColor clearColor];
    ivClose.image = [UIImage imageNamed:@"ic_close"];
    ivLine.image = [UIImage imageNamed:@"line1"];
    tvTip.editable = NO;
    
    [vTip addSubview:ivClose];
    [vTip addSubview:lblAnswer];
    [vTip addSubview:ivLine];
    [vTip addSubview:tvTip];
    
    lblAnswer.text = [NSString stringWithFormat:@"正确答案：%@", _currentQuestion.key];
    tvTip.text = _currentQuestion.tip;
    CGSize tipContent = tvTip.contentSize;
    tvTip.frame = CGRectMake(tvTip.frame.origin.x, tvTip.frame.origin.y, tvTip.frame.size.width, tipContent.height);
    vTip.frame = CGRectMake(vTip.frame.origin.x, vTip.frame.origin.y, vTip.frame.size.width, vTip.frame.size.height + tipContent.height);
    _popTipView = [[CMPopTipView alloc] initWithCustomView:vTip];
    _popTipView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [_popTipView presentPointingAtView:view inView:self.view animated:YES];
}

// 关闭答案解析
- (void)closeTip {
    if (!_popTipView.hidden) {
        [_popTipView dismissAnimated:YES];
        _popTipView = nil;
    }
}

- (void)handleMessage:(Message *)message {
    [self.view hideToastActivity];
    Result *result = message.obj;
    switch (message.what) {
        case DATA_GET_LAST_QUESTION_ORDER:
            if (result.stateCode == STATE_SUCCESS) {
                _lastOrder = [(NSNumber *)result.content intValue];
                [_dataHelper getQuestionsAfterOrder:_lastOrder chapterId:_chapter.ID userId:_userId pageSize:10];
            } else {
                [self.view hideToastActivity];
            }
            break;
        case DATA_GET_QUESTIONS_AFTER_ORDER:
            [self.view hideToastActivity];
            if (result.stateCode == STATE_SUCCESS) {
                [self fillDictionaryWithQuestions:result.content];
                [self nextQuestion];
            }
            break;
        case DATA_GET_QUESTIONS_BEFORE_ORDER:
            [self.view hideToastActivity];
            if (result.stateCode == STATE_SUCCESS) {
                [self fillDictionaryWithQuestions:result.content];
                [self preQuestion];
            }
            break;
    }
}

- (void)fillDictionaryWithQuestions:(NSArray *)questions {
    if (!_questionDics) {
        _questionDics = [[NSMutableDictionary alloc] init];
    }
    for (NSDictionary *questionDic in questions) {
        Question *question = [Question buildFromDictionary:questionDic];
        [_questionDics setObject:question forKey:[NSNumber numberWithInt:question.order]];
    }
}

- (void)onOptionChecked:(Option *)option answer:(NSString *)answer {
    _answer = answer;
}

- (IBAction)onButtonClicked:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            [self preQuestion];
            break;
        case 2:
            [self showTip:sender];
            break;
        case 3:
            [self nextQuestion];
            break;
    }
}

@end
