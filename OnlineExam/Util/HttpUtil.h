//
//  HttpUtil.h
//  OnlineExam
//  HTTP远程访问的工具类
//  Created by Goven on 13-10-18.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Result.h"

@interface HttpUtil : NSObject

// Post方法请求书数据，baseUrl：基础URL，params：参数集合，包含action的path路径，callback：回调块
+ (void)doPostWithBaseUrl:(NSString *)baseUrl params:(NSDictionary *)params callback:(void (^)(BOOL isSuccessed, Result *result))callback;

@end
