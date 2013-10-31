//
//  DataHelper.m
//  Kaoyaya
//
//  Created by Goven on 13-9-29.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "DataHelper.h"
#import "DataTest.h"
#import "HttpUtil.h"
#define URL_SERVER (@"http://www.kaoyaya.com/ios")

@implementation DataHelper

@synthesize callbackHandler;

+ (DataHelper *) init:(id<Handler>)callbakHandler {
    DataHelper *helper = [[DataHelper alloc] init];
    helper.callbackHandler = callbakHandler;
    return helper;
}

- (void)regist:(NSString *)username password:(NSString *)password {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"regist.php", @"action_path", username, @"username", password, @"password", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_REGIST result:result];
    }];
}

- (void)login:(NSString *)username password:(NSString *)password {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"login.php", @"action_path", username, @"username", password, @"password", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_LOGIN result:result];
    }];
}

- (void)getOrderItemsOfUser:(int)userId {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getOrderItems.php", @"action_path", [NSNumber numberWithInt:userId], @"userId", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_ORDERITEMS result:result];
    }];
}

- (void)getBookInfo:(int)bookId provinceId:(int)provinceId {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getBookInfo.php", @"action_path", [NSNumber numberWithInt:bookId], @"bookId", [NSNumber numberWithInt:provinceId], @"provinceid", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_BOOKINFO result:result];
    }];
}

- (void)getChaptersOfBook:(int)bookId userId:(int)userId {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getChapters.php", @"action_path", [NSNumber numberWithInt:bookId], @"bookId", [NSNumber numberWithInt:userId], @"userId", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_CHAPTERS result:result];
    }];
}

- (void)getLastQuestionOrderOfChapter:(int)chapterId userId:(int)userId questionType:(int)questionType {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getLastQuestionOrder.php", @"action_path", [NSNumber numberWithInt:chapterId], @"chapterId", [NSNumber numberWithInt:userId], @"userId", [NSNumber numberWithInt:questionType], @"questionType", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_LAST_QUESTION_ORDER result:result];
    }];
}

- (void)getLastQuestionsOfChapter:(int)chapterId userId:(int)userId pageIndex:(int)pageIndex pageSize:(int)pageSize {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getLastQuestions.php", @"action_path", [NSNumber numberWithInt:chapterId], @"chapterId", [NSNumber numberWithInt:userId], @"userId", [NSNumber numberWithInt:pageIndex], @"pageIndex", [NSNumber numberWithInt:pageSize], @"pageSize", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_LAST_QUESTIONS result:result];
    }];
}

- (void)getQuestionsBetweenOrder:(int)chapterId userId:(int)userId minOrder:(int)minOrder maxOrder:(int)maxOrder {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getQuestionsBetweenOrder.php", @"action_path", [NSNumber numberWithInt:chapterId], @"chapterId", [NSNumber numberWithInt:userId], @"userId", [NSNumber numberWithInt:minOrder], @"minOrder", [NSNumber numberWithInt:maxOrder], @"maxOrder", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_QUESTIONS_BETWEEN_ORDER result:result];
    }];
}

- (void)getQuestionsAfterOrder:(int)order chapterId:(int)chapterId userId:(int)userId questionType:(int)questionType pageSize:(int)pageSize {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getQuestions.php", @"action_path", [NSNumber numberWithInt:order], @"order", [NSNumber numberWithInt:chapterId], @"chapterId", [NSNumber numberWithInt:userId], @"userId", [NSNumber numberWithInt:questionType], @"questionType", [NSNumber numberWithInt:pageSize], @"pageSize", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_QUESTIONS_AFTER_ORDER result:result];
    }];
}

- (void)getQuestionsBeforOrder:(int)order chapterId:(int)chapterId userId:(int)userId questionType:(int)questionType pageSize:(int)pageSize {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getQuestionsBeforOrde.php", @"action_path", [NSNumber numberWithInt:order], @"order", [NSNumber numberWithInt:chapterId], @"chapterId", [NSNumber numberWithInt:userId], @"userId", [NSNumber numberWithInt:questionType], @"questionType", [NSNumber numberWithInt:pageSize], @"pageSize", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_QUESTIONS_BEFORE_ORDER result:result];
    }];
}

- (void)commitAnswerOfQuestion:(int)questionId chapterId:(int)chapterId userId:(int)userId questionType:(int)questionType typeId:(int)typeId order:(int)order answer:(NSString *)answer userAnswer:(NSString *)userAnswer {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"commitAnswer.php", @"action_path", [NSNumber numberWithInt:questionId], @"questionId", [NSNumber numberWithInt:chapterId], @"chapterId", [NSNumber numberWithInt:userId], @"userId", [NSNumber numberWithInt:questionType], @"questionType", [NSNumber numberWithInt:typeId], @"TixingId", [NSNumber numberWithInt:order], @"order", answer, @"answer", userAnswer, @"userAnswer", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_QUESTIONS_BEFORE_ORDER result:result];
    }];
}

- (void)callback:(int)tag result:(id)result {
    if (callbackHandler) {
        Message *msg = [Message obtain];
        msg.what = tag;
        msg.obj = result;
        [callbackHandler handleMessage:msg];
    }
}

@end
