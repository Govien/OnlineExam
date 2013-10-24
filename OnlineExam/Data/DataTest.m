//
//  DataTest.m
//  Kaoyaya
//
//  Created by Goven on 13-9-29.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "DataTest.h"
#import "OrderItem.h"
#import "Book.h"
#import "Result.h"
#import "Chapter.h"
#import "Question.h"
#import "Option.h"

@implementation DataTest

+ (NSString *)getData:(NSString *)url {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:[NSNumber numberWithInt:STATE_SUCCESS] forKey:@"stateCode"];
    if ([url isEqualToString:@"getOrderItems"]) {
        [dictionary setObject:[self getOrderItemsOfUser:nil password:nil] forKey:@"content"];
        
    } else if ([url isEqualToString:@"regist"]) {
        
    } else if ([url isEqualToString:@"login"]) {
        
    } else if ([url isEqualToString:@"getBookInfo"]) {
        [dictionary setObject:[self getBookInfo] forKey:@"content"];
    } else if ([url isEqualToString:@"getChapters"]) {
        [dictionary setObject:[self getChapters] forKey:@"content"];
    } else if ([url isEqualToString:@"getLaterQuestionsOfChapter"]) {
        [dictionary setObject:[self getLaterQuestionsOfChapter] forKey:@"content"];
    }
    NSString *str = [dictionary JSONString];
    return str;
}

+ (NSDictionary *)getOrderItemsOfUser:(NSString *)username password:(NSString *)password {
    OrderItem *item0 = [[OrderItem alloc] init:1 courseId:1 bookId:1 productName:@"会计基础理论知识习题" provinceName:@"山西" buyTime:@"2013-09-29 12:00:00" degree:0.1];
    OrderItem *item1 = [[OrderItem alloc] init:2 courseId:1 bookId:1 productName:@"会计电算化理论 习题" provinceName:@"辽宁" buyTime:@"2013-09-29 12:00:00" degree:0.2];
    OrderItem *item2 = [[OrderItem alloc] init:3 courseId:1 bookId:1 productName:@"会计基础理论知识习题" provinceName:@"吉林" buyTime:@"2013-09-29 12:00:00" degree:0.3];
    OrderItem *item3 = [[OrderItem alloc] init:4 courseId:1 bookId:1 productName:@"会计财经与法规 习题" provinceName:@"山西" buyTime:@"2013-09-29 12:00:00" degree:0.4];
    OrderItem *item4 = [[OrderItem alloc] init:5 courseId:1 bookId:1 productName:@"初级会计职称考试" provinceName:@"四川" buyTime:@"2013-09-29 12:00:00" degree:0.5];
    OrderItem *item5 = [[OrderItem alloc] init:5 courseId:1 bookId:1 productName:@"造价工程师考试" provinceName:@"福建" buyTime:@"2013-09-29 12:00:00" degree:0.6];
    OrderItem *item6 = [[OrderItem alloc] init:5 courseId:1 bookId:1 productName:@"会计从业资格考试" provinceName:@"上海" buyTime:@"2013-09-29 12:00:00" degree:0.7];
    OrderItem *item7 = [[OrderItem alloc] init:5 courseId:1 bookId:1 productName:@"初级经济师" provinceName:@"江苏" buyTime:@"2013-09-29 12:00:00" degree:0.8];
    OrderItem *item8 = [[OrderItem alloc] init:5 courseId:1 bookId:1 productName:@"事业单位招聘考试" provinceName:@"天津" buyTime:@"2013-09-29 12:00:00" degree:0.9];
    OrderItem *item9 = [[OrderItem alloc] init:1 courseId:1 bookId:1 productName:@"会计基础理论知识习题" provinceName:@"山西" buyTime:@"2013-09-29 12:00:00" degree:0.1];
    OrderItem *item10 = [[OrderItem alloc] init:2 courseId:1 bookId:1 productName:@"会计电算化理论 习题" provinceName:@"辽宁" buyTime:@"2013-09-29 12:00:00" degree:0.2];
    OrderItem *item11 = [[OrderItem alloc] init:3 courseId:1 bookId:1 productName:@"会计基础理论知识习题" provinceName:@"吉林" buyTime:@"2013-09-29 12:00:00" degree:0.3];
    OrderItem *item12 = [[OrderItem alloc] init:4 courseId:1 bookId:1 productName:@"会计财经与法规 习题" provinceName:@"山西" buyTime:@"2013-09-29 12:00:00" degree:0.4];
    NSArray *buys = [NSArray arrayWithObjects:[item0 convertToDictionary], [item1 convertToDictionary], [item2 convertToDictionary], [item3 convertToDictionary], [item4 convertToDictionary], [item5 convertToDictionary], [item6 convertToDictionary], [item7 convertToDictionary], [item8 convertToDictionary], [item9 convertToDictionary], [item10 convertToDictionary], [item11 convertToDictionary], [item12 convertToDictionary], nil];
    NSArray *tests = [NSArray arrayWithObjects:[item0 convertToDictionary], [item1 convertToDictionary], [item2 convertToDictionary], [item3 convertToDictionary], [item4 convertToDictionary], nil];
    NSDictionary *orderItems = [NSDictionary dictionaryWithObjectsAndKeys:buys, @"buys", tests, @"tests", nil];
    return orderItems;
}

+ (NSDictionary *)getBookInfo {
    Book *book = [[Book alloc] init];
    book.ID = 1;
    book.courseId = 1;
    book.categoryId = 1;
    book.courseName = @"四川省会计从业资格考试";
    book.name = @"财经法规与职业道德";
    book.price = 12.00;
    return [book convertToDictionary];
}

+ (NSArray *)getChapters {
    Chapter *chapter0 = [[Chapter alloc] initWithID:1 bookId:1 name:@"第一章 会计法律制度" totalCount:1012 doneCount:100 rightCount:84 errorCount:16 no:0];
    Chapter *chapter1 = [[Chapter alloc] initWithID:1 bookId:1 name:@"第二章 支付结算法律制度" totalCount:1012 doneCount:0 rightCount:0 errorCount:0 no:1];
    Chapter *chapter2 = [[Chapter alloc] initWithID:1 bookId:1 name:@"第三章 税收法律制度" totalCount:1012 doneCount:100 rightCount:80 errorCount:20 no:2];
    Chapter *chapter3 = [[Chapter alloc] initWithID:1 bookId:1 name:@"第四章 财政法规制度" totalCount:1012 doneCount:0 rightCount:0 errorCount:0 no:3];
    Chapter *chapter4 = [[Chapter alloc] initWithID:1 bookId:1 name:@"第五章 会计职业道德" totalCount:1012 doneCount:100 rightCount:100 errorCount:0 no:4];
    Chapter *chapter5 = [[Chapter alloc] initWithID:1 bookId:1 name:@"案例综合题专项练习" totalCount:1012 doneCount:100 rightCount:80 errorCount:20 no:5];
    return [NSArray arrayWithObjects:[chapter0 convertToDictionary], [chapter1 convertToDictionary], [chapter2 convertToDictionary], [chapter3 convertToDictionary], [chapter4 convertToDictionary], [chapter5 convertToDictionary], nil];
}

+ (NSArray *)getLaterQuestionsOfChapter {
    Option *option0 = [[Option alloc] initWithID:1 questionId:1 text:@"资金投入" no:1 isKey:NO];
    Option *option1 = [[Option alloc] initWithID:1 questionId:1 text:@"资源运用" no:2 isKey:YES];
    Option *option2 = [[Option alloc] initWithID:1 questionId:1 text:@"资金退出" no:3 isKey:NO];
    Option *option3 = [[Option alloc] initWithID:1 questionId:1 text:@"资金运用" no:4 isKey:YES];
    NSArray *options = [NSArray arrayWithObjects:option0, option1, option2, option3, nil];
    Question *question0 = [[Question alloc] initWithID:1 chapterId:1 bookId:1 no:167 title:@"会计对象就是能用货币表现的各种经济活动，具体包括的内容有（）" tip:@"会计的对象就是企业的资金运动，具体包括：资金投入、资金运用和资金退出" type:0 key:@"A,B,C" options:options];
    Question *question1 = [[Question alloc] initWithID:1 chapterId:1 bookId:1 no:168 title:@"会计对象就是能用货币表现的各种经济活动，具体包括的内容有（）" tip:@"会计的对象就是企业的资金运动，具体包括：资金投入、资金运用和资金退出" type:1 key:@"A,B,C" options:options];
    
    Question *question2 = [[Question alloc] initWithID:1 chapterId:1 bookId:1 no:169 title:@"会计对象就是能用货币表现的各种经济活动，具体包括的内容有（）" tip:@"会计的对象就是企业的资金运动，具体包括：资金投入、资金运用和资金退出" type:2 key:@"A,B,C" options:options];
    Question *question3 = [[Question alloc] initWithID:1 chapterId:1 bookId:1 no:170 title:@"会计对象就是能用货币表现的各种经济活动，具体包括的内容有（）" tip:@"会计的对象就是企业的资金运动，具体包括：资金投入、资金运用和资金退出" type:2 key:@"A,B,C" options:options];
    Question *question4 = [[Question alloc] initWithID:1 chapterId:1 bookId:1 no:171 title:@"会计对象就是能用货币表现的各种经济活动，具体包括的内容有（）" tip:@"会计的对象就是企业的资金运动，具体包括：资金投入、资金运用和资金退出" type:1 key:@"A,B,C" options:options];
    Question *question5 = [[Question alloc] initWithID:1 chapterId:1 bookId:1 no:172 title:@"会计对象就是能用货币表现的各种经济活动，具体包括的内容有（）" tip:@"会计的对象就是企业的资金运动，具体包括：资金投入、资金运用和资金退出" type:0 key:@"A,B,C" options:options];
    return [NSArray arrayWithObjects:[question0 convertToDictionary], [question1 convertToDictionary], [question2 convertToDictionary], [question3 convertToDictionary], [question4 convertToDictionary], [question5 convertToDictionary], nil];
}

@end
