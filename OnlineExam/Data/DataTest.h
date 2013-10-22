//
//  DataTest.h
//  Kaoyaya
//
//  Created by Goven on 13-9-29.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

@interface DataTest : NSObject

+ (NSString *)getData:(NSString *) url;
+ (NSDictionary *)getOrderItemsOfUser:(NSString *)username password:(NSString *)password;

@end
