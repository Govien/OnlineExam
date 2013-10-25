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
#define URL_SERVER (@"")

@implementation DataHelper

@synthesize callbackHandler;

+ (DataHelper *) init:(id<Handler>)callbakHandler {
    DataHelper *helper = [[DataHelper alloc] init];
    helper.callbackHandler = callbakHandler;
    return helper;
}

- (void)regist:(NSString *)username password:(NSString *)password {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"regist", @"action_path", username, @"username", password, @"password", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_REGIST result:result];
    }];
}

- (void)login:(NSString *)username password:(NSString *)password {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"login", @"action_path", username, @"username", password, @"password", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_LOGIN result:result];
    }];
}

- (void)getOrderItemsOfUser:(int)userId {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getOrderItems", @"action_path", userId, @"userId", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_ORDERITEMS result:result];
    }];
}

- (void)getBookInfo:(int)bookId {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getBookInfo", @"action_path", [NSNumber numberWithInt:bookId], @"bookId", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_BOOKINFO result:result];
    }];
}

- (void)getChaptersOfBook:(int)bookId userId:(int)userId {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getChapters", @"action_path", [NSNumber numberWithInt:bookId], @"bookId", [NSNumber numberWithInt:userId], @"userId", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_CHAPTERS result:result];
    }];
}

- (void)getLastQuestionOrderOfChapter:(int)chapterId userId:(int)userId {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getLastQuestionOrder", @"action_path", [NSNumber numberWithInt:chapterId], @"chapterId", [NSNumber numberWithInt:userId], @"userId", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_LAST_QUESTION_ORDER result:result];
    }];
}

- (void)getLastQuestionsOfChapter:(int)chapterId userId:(int)userId pageIndex:(int)pageIndex pageSize:(int)pageSize {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getLastQuestions", @"action_path", [NSNumber numberWithInt:chapterId], @"chapterId", [NSNumber numberWithInt:userId], @"userId", [NSNumber numberWithInt:pageIndex], @"pageIndex", [NSNumber numberWithInt:pageSize], @"pageSize", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_LAST_QUESTIONS result:result];
    }];
}

- (void)getQuestionsBetweenOrder:(int)chapterId userId:(int)userId minOrder:(int)minOrder maxOrder:(int)maxOrder {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getQuestionsBetweenOrder", @"action_path", [NSNumber numberWithInt:chapterId], @"chapterId", [NSNumber numberWithInt:userId], @"userId", [NSNumber numberWithInt:minOrder], @"minOrder", [NSNumber numberWithInt:maxOrder], @"maxOrder", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_QUESTIONS_BETWEEN_ORDER result:result];
    }];
}

- (void)getQuestionsAfterOrder:(int)order chapterId:(int)chapterId userId:(int)userId pageSize:(int)pageSize {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getQuestionsAfterOrder", @"action_path", [NSNumber numberWithInt:order], @"order", [NSNumber numberWithInt:chapterId], @"chapterId", [NSNumber numberWithInt:userId], @"userId", [NSNumber numberWithInt:pageSize], @"pageSize", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_QUESTIONS_AFTER_ORDER result:result];
    }];
}

- (void)getQuestionsBeforOrder:(int)order chapterId:(int)chapterId userId:(int)userId pageSize:(int)pageSize {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"getQuestionsBeforOrder", @"action_path", [NSNumber numberWithInt:order], @"order", [NSNumber numberWithInt:chapterId], @"chapterId", [NSNumber numberWithInt:userId], @"userId", [NSNumber numberWithInt:pageSize], @"pageSize", nil];
    [HttpUtil doPostWithBaseUrl:URL_SERVER params:params callback:^(BOOL isSuccessed, Result *result) {
        [self callback:DATA_GET_QUESTIONS_BEFORE_ORDER result:result];
    }];
}

- (void)commitAnswerOfQuestion:(int)questionId chapterId:(int)chapterId userId:(int)userId answer:(NSString *)answer {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"commitAnswer", @"action_path", [NSNumber numberWithInt:questionId], @"questionId", [NSNumber numberWithInt:chapterId], @"chapterId", [NSNumber numberWithInt:userId], @"userId", answer, @"answer", nil];
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
