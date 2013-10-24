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

@interface VCQuestion ()<Handler, OptionDelegate> {
    DataHelper *_dataHelper;
    int _pageIndex;
    NSArray *_questions;
    OptionView *_optionView;
}

@property (weak, nonatomic) IBOutlet UILabel *lblNo;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *vContent;


@end

@implementation VCQuestion

@synthesize chapter = _chapter;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = _chapter.name;
    _dataHelper = [DataHelper init:self];
    [_dataHelper getLaterQuestionsOfChapter:_chapter.ID userId:[[NSUserDefaults standardUserDefaults] integerForKey:INFO_USERID] pageIndex:_pageIndex pageSize:10];
}

- (void)initQuestionView:(NSArray *)questions {
    _questions = questions;
    _optionView = [[OptionView alloc] initWithQuestion:[Question buildFromDictionary:_questions[0]] chapter:_chapter optionDelegate:self];
    [_vContent addSubview:_optionView];
}

- (void)handleMessage:(Message *)message {
    [self.view hideToastActivity];
    Result *result = message.obj;
    switch (message.what) {
        case DATA_GET_LATER_QUESTIONS:
            [self initQuestionView:result.content];
            break;
        default:
            break;
    }
}

- (void)onOptionChecked:(Option *)option {
    
}

- (IBAction)onButtonClicked:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
    }
}

@end
