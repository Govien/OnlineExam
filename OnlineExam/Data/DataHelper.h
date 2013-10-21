//
//  DataHelper.h
//  Kaoyaya
//
//  Created by Goven on 13-9-29.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "MessageHandler.h"
#import "Result.h"

@interface DataHelper : NSObject

@property(retain,nonatomic)id<Handler> callbackHandler;

+ (DataHelper *) init:(id<Handler>)callbakHandler;
// 注册
- (void)regist:(NSString *)username password:(NSString *)password;
// 登录
- (void)login:(NSString *)username password:(NSString *)password;
// 获取用户订单集合
- (void)getOrderItemsOfUser:(NSString *)username password:(NSString *)password;

@end
