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
- (void)getBookInfo:(int)bookId provinceId:(int)provinceId;
// 根据习题ID和用户ID获取章节列表
- (void)getChaptersOfBook:(int)bookId userId:(int)userId;
// 获取上次做的题目编号
- (void)getLastQuestionOrderOfChapter:(int)chapterId userId:(int)userId questionType:(int)questionType;
// 获取上次做的之后的题目
- (void)getLastQuestionsOfChapter:(int)chapterId userId:(int)userId pageIndex:(int)pageIndex pageSize:(int)pageSize;
// 获取两个题号之间的题目
- (void)getQuestionsBetweenOrder:(int)chapterId userId:(int)userId minOrder:(int)minOrder maxOrder:(int)maxOrder;
// 获取某个题号之后的题目
- (void)getQuestionsAfterOrder:(int)order chapterId:(int)chapterId userId:(int)userId questionType:(int)questionType pageSize:(int)pageSize;
// 获取某个题号之前的题目
- (void)getQuestionsBeforOrder:(int)order chapterId:(int)chapterId userId:(int)userId questionType:(int)questionType pageSize:(int)pageSize;
// 提交答案
- (void)commitAnswerOfQuestion:(int)questionId chapterId:(int)chapterId userId:(int)userId questionType:(int)questionType typeId:(int)typeId order:(int)order answer:(NSString *)answer userAnswer:(NSString *)userAnswer;

@end
