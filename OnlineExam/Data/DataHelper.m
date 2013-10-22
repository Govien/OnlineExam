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

- (void)callback:(int)tag result:(id)result {
    if (callbackHandler) {
        Message *msg = [Message obtain];
        msg.what = tag;
        msg.obj = result;
        [callbackHandler handleMessage:msg];
    }
}

@end
