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
- (void)getOrderItemsOfUser:(int)userId;
// 获取习题相关信息
- (void)getBookInfo:(int)bookId;
// 根据习题ID和用户ID获取章节列表
- (void)getChaptersOfBook:(int)bookId userId:(int)userId;
- (void)getLaterQuestionsOfChapter:(int)chapterId userId:(int)userId pageIndex:(int)pageIndex pageSize:(int)pageSize;

@end
