//
//  VCQuestion.m
//  OnlineExam
//  
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "VCQuestion.h"
#import "OptionButton.h"

@interface VCQuestion ()

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
    Option *option = [[Option alloc] init];
    option.ID = 1;
    option.questionId = 1;
    option.text = @"资金投入";
    option.isKey = YES;
    option.questionId = QuestionTypeRadio;
    [_vContent addSubview:[[OptionButton alloc] initWithOption:option optionDelegate:nil]];
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
