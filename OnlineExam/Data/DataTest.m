//
//  DataTest.m
//  Kaoyaya
//
//  Created by Goven on 13-9-29.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "DataTest.h"
#import "OrderItem.h"
#import "Result.h"

@implementation DataTest

+ (NSString *)getData:(NSString *)url {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:[NSNumber numberWithInt:STATE_SUCCESS] forKey:@"stateCode"];
    if ([url isEqualToString:@"getOrderItems"]) {
        [dictionary setObject:[self getOrderItemsOfUser:nil password:nil] forKey:@"content"];
        
    } else if ([url isEqualToString:@"regist"]) {
        
    } else if ([url isEqualToString:@"login"]) {
        
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

@end
