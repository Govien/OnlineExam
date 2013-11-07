//
//  VCBook.m
//  Kaoyaya
//
//  Created by Goven on 13-10-14.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "VCBook.h"
#import "DataHelper.h"
#import "Chapter.h"
#import "VCQuestion.h"
#import "QuestionType.h"
#import "AppUtil.h"

@interface VCBook ()<Handler> {
    DataHelper *_dataHelper;
    NSMutableArray *_allChapters, *_errorChapters, *_questionTypes;
    BOOL _isErrorShow;
}

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;// 标题
@property (weak, nonatomic) IBOutlet UILabel *lblName;// 习题名
@property (weak, nonatomic) IBOutlet UILabel *lblPurchase;// 是否购买
@property (weak, nonatomic) IBOutlet UIView *vBookInfo;// 习题信息视图
@property (weak, nonatomic) IBOutlet UISegmentedControl *scContentChoose;// 内容切换
@property (weak, nonatomic) IBOutlet UITableView *tvChapter;// 章节列表视图

@end

@implementation VCBook

@synthesize book = _book;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataHelper = [DataHelper init:self];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg5.jpg"]];
    _lblTitle.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"item2"]];
    _vBookInfo.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];

    // 设置圆角背景
    _vBookInfo.layer.masksToBounds = YES;
    _vBookInfo.layer.cornerRadius = 6.0;
    _vBookInfo.layer.borderWidth = 1.0;
    _vBookInfo.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    _lblPurchase.layer.cornerRadius = 10.0;
    
    _lblTitle.text = _book.courseName;
    _lblName.text = _book.name;
    [self.view makeToastActivity];
    [_dataHelper getChaptersOfBook:_book.ID userId:[[NSUserDefaults standardUserDefaults] integerForKey:INFO_USERID]];
}

- (void)handleMessage:(Message *)message {
    [self.view hideToastActivity];
    Result *result = message.obj;
    switch (message.what) {
        case DATA_GET_CHAPTERS:
            [self handleChapterResult:result];
            break;
    }
}

- (void)handleChapterResult:(Result *)result {
    if (result.stateCode == STATE_OFFLINE) {
        [AppUtil offline:self];
    } else if (result.stateCode == STATE_SUCCESS) {
        int errorNum = 0;
        if (!_allChapters) {
            _allChapters = [[NSMutableArray alloc] init];
        }
        if (!_errorChapters) {
            _errorChapters = [[NSMutableArray alloc] init];
        }
        if (!_questionTypes) {
            _questionTypes = [[NSMutableArray alloc] init];
        }
        for (NSDictionary *dictionary in [result.content objectForKey:@"tixing_arr"]) {
            [_questionTypes addObject:[QuestionType build:dictionary]];
        }
        for (NSDictionary *dictionary in [result.content objectForKey:@"Chapter"]) {
            Chapter *chapter = [Chapter buildFromDictionary:dictionary];
            [_allChapters addObject:chapter];
            if (chapter.errorCount > 0) {
                errorNum += chapter.errorCount;
                [_errorChapters addObject:chapter];
            }
        }
        [_scContentChoose setTitle:[NSString stringWithFormat:@"错题重做(%d)", errorNum] forSegmentAtIndex:1];
        [_tvChapter reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isErrorShow) {
        return _errorChapters.count;
    }
    return _allChapters.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    Chapter *chapter = nil;
    if (_isErrorShow) {
        chapter = _errorChapters[row];
    } else {
        chapter = _allChapters[row];
    }
    chapter.questionTypes = _questionTypes;
    [self performSegueWithIdentifier:@"question" sender:chapter];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"bookCell"];
    UILabel *title = (UILabel *)[cell viewWithTag:1];
    UILabel *detail = (UILabel *)[cell viewWithTag:2];
    if (!_isErrorShow) {
        Chapter *chapter = _allChapters[row];
        title.text = chapter.name;
        if (chapter.doneCount > 0) {
            float rightRate = (chapter.rightCount / (float)chapter.doneCount) * 100;
            detail.text = [NSString stringWithFormat:@"%d题  正确率 %0.2f%%", chapter.totalCount, rightRate];
        } else {
            detail.text = [NSString stringWithFormat:@"共%d道题", chapter.totalCount];
        }
    } else {
        Chapter *chapter = _errorChapters[row];
        title.text = chapter.name;
        detail.text = [NSString stringWithFormat:@"共%d道题  错题%d道", chapter.totalCount, chapter.errorCount];
    }
    return cell;
}
- (IBAction)onValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            _isErrorShow = NO;
            break;
        case 1:
            _isErrorShow = YES;
            break;
    }
    [_tvChapter reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"question"]) {
        VCQuestion *vcQuestion = [segue destinationViewController];
        vcQuestion.chapter = sender;
        vcQuestion.isErrorShow = _isErrorShow;
    }
}

@end
