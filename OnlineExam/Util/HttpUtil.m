//
//  HttpUtil.m
//  OnlineExam
//
//  Created by Goven on 13-10-18.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "HttpUtil.h"
#import "DataTest.h"

@implementation HttpUtil

+ (void)doPostWithBaseUrl:(NSString *)baseUrl params:(NSDictionary *)params callback:(void (^)(BOOL isSuccessed, Result *result))callback {
    NSArray *actions = [NSArray arrayWithObjects:@"regist.php", @"login.php", @"getOrderItems.php", @"getBookInfo.php", @"getChapters.php", @"getLastQuestionOrder.php", @"getQuestions.php", @"commitAnswer.php", nil];
    // 本地模拟测试数据
    NSString *actionPath = [params objectForKey:@"action_path"];
    if (![actions containsObject:actionPath]) {
        NSString *responseStr = [DataTest getData:actionPath];
        NSDictionary *map = [responseStr objectFromJSONString];
        Result *result = [[Result alloc] init];
        result.stateCode = [[map objectForKey:@"stateCode"] intValue];
        result.content = [map objectForKey:@"content"];
        result.message = [map objectForKey:@"message"];
        callback(YES, result);
        return;
    }
    
    // 真实网络数据请求
    NSURL *url = [NSURL URLWithString:baseUrl];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient postPath:actionPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Result *result;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (responseStr) {
            NSDictionary *map = [responseStr objectFromJSONString];
            result = [[Result alloc] init];
            result.stateCode = [[map objectForKey:@"stateCode"] intValue];
            result.content = [map objectForKey:@"content"];
            result.message = [map objectForKey:@"message"];
            callback(YES, result);
        } else {
            callback(NO, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(NO, nil);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
}

@end
