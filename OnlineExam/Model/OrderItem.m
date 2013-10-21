//
//  OrderItem.m
//  Kaoyaya
//
//  Created by Goven on 13-9-29.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem

- (id)init:(int)ID courseId:(int)courseId bookId:(int)bookId productName:(NSString *)productName provinceName:(NSString *)provinceName buyTime:(NSString *)buyTime degree:(float)degree {
    self = [super init];
    if (self) {
        _ID = ID;
        _courseId = courseId;
        _bookId = bookId;
        _productName = productName;
        _provinceName = provinceName;
        _buyTime = buyTime;
        _degree = degree;
    }
    return self;
}

+ (OrderItem *)buildFromDictionary:(NSDictionary *)dictionary {
    OrderItem *item = [[OrderItem alloc] init];
    item.ID = [[dictionary objectForKey:@"ID"] intValue];
    item.bookId = [[dictionary objectForKey:@"bookId"] intValue];
    item.courseId = [[dictionary objectForKey:@"courseId"] intValue];
    item.productName = [dictionary objectForKey:@"productName"];
    item.provinceName = [dictionary objectForKey:@"provinceName"];
    item.buyTime = [dictionary objectForKey:@"buyTime"];
    item.degree = [[dictionary objectForKey:@"degree"] floatValue];
    return item;
}

- (NSDictionary *)convertToDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:self.ID], @"ID", [NSNumber numberWithInt:self.courseId], @"courseId", [NSNumber numberWithInt:self.bookId], @"bookId", self.productName, @"productName", self.provinceName, @"provinceName", self.buyTime, @"buyTime", [NSNumber numberWithFloat:self.degree], @"degree", nil];
}

@end
