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
#import "QuestionType.h"
#import "AppUtil.h"

@interface VCQuestion ()<Handler, OptionDelegate> {
    DataHelper *_dataHelper;
    int _userId, _lastOrder, _questionCount, _questionType, _questionTypeId;
    NSMutableDictionary *_questionDics, *_qustionTypes;
    OptionView *_optionView;
    NSString *_answer;
    Question *_currentQuestion;
    CMPopTipView *_popTipView;
    MBProgressHUD *_hudProgress;
    BOOL _isNextQuestion;
}

@property (weak, nonatomic) IBOutlet UILabel *lblNo;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *vContent;
@property (weak, nonatomic) IBOutlet UIScrollView *svContent;
@property (weak, nonatomic) IBOutlet UIImageView *ivLine;

@end

@implementation VCQuestion

@synthesize chapter = _chapter;
@synthesize isErrorShow = _isErrorShow;
static const int _pageSize = 10;

- (void)viewDidLoad
{
    [super viewDidLoad];
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        //某个仅支持7.0以上版本的方法
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
	self.title = _chapter.name;
    _dataHelper = [DataHelper init:self];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg5.jpg"]];
    _vContent.backgroundColor = [UIColor clearColor];
    _userId = [[NSUserDefaults standardUserDefaults] integerForKey:INFO_USERID];
    _hudProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hudProgress.labelText = @"正在加载题目...";
    if (_isErrorShow) {
        _questionCount = _chapter.errorCount;
        _lastOrder = 1;
        [_dataHelper getQuestionsAfterOrder:_lastOrder chapterId:_chapter.ID userId:_userId questionType:_questionTypeId pageSize:_pageSize isError:_isErrorShow];
    } else {
        _questionCount = _chapter.totalCount;
        [_dataHelper getLastQuestionOrderOfChapter:_chapter.ID userId:_userId questionType:_questionTypeId];
    }
    if (!_qustionTypes) {
        for (QuestionType *type in _chapter.questionTypes) {
            [_qustionTypes setObject:type forKey:[NSNumber numberWithInt:type.typeCode]];
        }
    }
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
    [mutableNo appendFormat:@" 第%d / %d题：", _lastOrder, _questionCount];
    _lblNo.text = mutableNo;
    _lblTitle.text = question.title;
    _lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
    int titleWidth = _lblTitle.frame.size.width;
    CGSize sizeFrame =[question.title sizeWithFont:_lblTitle.font constrainedToSize:CGSizeMake(titleWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    _lblTitle.frame = CGRectMake(_lblTitle.frame.origin.x,5,titleWidth,sizeFrame.height);
    _ivLine.frame = CGRectMake(_ivLine.frame.origin.x, _lblTitle.frame.size.height + 10, _ivLine.frame.size.width, _ivLine.frame.size.height);
    _optionView = [[OptionView alloc] initWithQuestion:question optionDelegate:self];
    _optionView.frame = CGRectOffset(_optionView.frame, 20, _ivLine.frame.origin.y + 8);
    [_svContent addSubview:_optionView];
}

// 显示上一问题
- (void)preQuestion {
    [self commitAnswer];
    if (_lastOrder < 1) {
        [self.view makeToast:@"前面没题目啦~~~"];
        _lastOrder = 1;
    } else {
        Question *question = [_questionDics objectForKey:[NSNumber numberWithInt:(_lastOrder)]];
        if (question) {
            [self displayQuestionView:question];
        } else {
            _isNextQuestion = NO;
            [_hudProgress show:YES];
            [_dataHelper getQuestionsAfterOrder:_lastOrder chapterId:_chapter.ID userId:_userId questionType:_questionTypeId pageSize:_pageSize isError:_isErrorShow];
        }
    }
}

// 显示下一问题
- (void)nextQuestion {
    [self commitAnswer];
    if (_lastOrder > _questionCount) {
        [self.view makeToast:@"这已经是最后一题啦！"];
        _lastOrder = _questionCount;
    } else {
        Question *question = [_questionDics objectForKey:[NSNumber numberWithInt:(_lastOrder)]];
        if (question) {
            [self displayQuestionView:question];
        } else {
            _isNextQuestion = YES;
            [_hudProgress show:YES];
            [_dataHelper getQuestionsAfterOrder:_lastOrder chapterId:_chapter.ID userId:_userId questionType:_questionTypeId pageSize:_pageSize isError:_isErrorShow];
        }
    }
}

// 提交答案
- (void)commitAnswer {
    [self closeTip];
    if ([StringUtil isNotTrimBlank:_answer]) {
        int typeId = 0;
        if (_questionType != QuestionTypeAll) {
            typeId = _currentQuestion.typeId;
        }
        [_dataHelper commitAnswerOfQuestion:_currentQuestion.ID chapterId:_chapter.ID userId:_userId questionType:_currentQuestion.type typeId:typeId order:_currentQuestion.order answer:_currentQuestion.key userAnswer:_answer isError:_isErrorShow];
        _answer = nil;
    }
}

// 答案解析，弹出气泡提示
- (void)showTip:(UIView *)view {
    if (_popTipView) {
        [_popTipView presentPointingAtView:view inView:self.view animated:YES];
        return;
    }
    UIView *vTip = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 55)];
    UIImageView *ivClose = [[UIImageView alloc] initWithFrame:CGRectMake(262, 0, 18, 18)];
    UILabel *lblAnswer = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, 260, 20)];
    UIImageView *ivLine = [[UIImageView alloc] initWithFrame:CGRectMake(5, 48, 270, 1)];
    UITextView *tvTip = [[UITextView alloc] initWithFrame:CGRectMake(5, 55, 270, 0)];
    vTip.backgroundColor = [UIColor clearColor];
    lblAnswer.backgroundColor = [UIColor clearColor];
    tvTip.backgroundColor = [UIColor clearColor];
    ivClose.image = [UIImage imageNamed:@"ic_close"];
    ivLine.image = [UIImage imageNamed:@"line1"];
    tvTip.editable = NO;
    
    [vTip addSubview:ivClose];
    [vTip addSubview:lblAnswer];
    [vTip addSubview:ivLine];
    [vTip addSubview:tvTip];
    
    lblAnswer.text = [NSString stringWithFormat:@"正确答案：%@", _currentQuestion.tipKey];
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
                [_dataHelper getQuestionsAfterOrder:_lastOrder chapterId:_chapter.ID userId:_userId questionType:_questionTypeId pageSize:_pageSize isError:_isErrorShow];
            } else if (result.stateCode == STATE_OFFLINE) {
                [_hudProgress hide:YES];
                [AppUtil offline:self];
            } else {
                [_hudProgress hide:YES];
            }
            break;
        case DATA_GET_QUESTIONS_AFTER_ORDER:
            [_hudProgress hide:YES];
            _questionCount = [result.message intValue];
            if (result.stateCode == STATE_SUCCESS) {
                [self fillDictionaryWithQuestions:result.content];
            } else if (result.stateCode == STATE_OFFLINE) {
                [AppUtil offline:self];
            } else {
                [_hudProgress hide:YES];
            }
            break;
        case DATA_GET_QUESTIONS_BEFORE_ORDER:
            [_hudProgress hide:YES];
            if (result.stateCode == STATE_SUCCESS) {
                [self fillDictionaryWithQuestions:result.content];
                [self preQuestion];
            }
            break;
        case DATA_COMMIT_ANSWER:
            break;
    }
}

- (void)fillDictionaryWithQuestions:(id)questions {
    if (!_questionDics) {
        _questionDics = [[NSMutableDictionary alloc] init];
    }
    if (questions == [NSNull null]) {
        return;
    }
    BOOL _hasLastOrder = NO;
    for (NSDictionary *questionDic in questions) {
        Question *question = [Question build:questionDic];
        [_questionDics setObject:question forKey:[NSNumber numberWithInt:question.order]];
        if (question.order == _lastOrder) {
            _hasLastOrder = YES;
        }
    }
    if (_hasLastOrder) {
        if (_isNextQuestion) {
            [self nextQuestion];
        } else {
            [self preQuestion];
        }
    }
}

- (void)onOptionChecked:(Option *)option answer:(NSString *)answer {
    _answer = answer;
}

- (IBAction)onButtonClicked:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            _lastOrder--;
            [self preQuestion];
            break;
        case 2:
            [self showTip:sender];
            break;
        case 3:
            _lastOrder++;
            [self nextQuestion];
            break;
    }
}

@end
