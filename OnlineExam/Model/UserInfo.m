//
//  UserInfo.m
//  OnlineExam
//
//  Created by Goven on 13-10-18.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (UserInfo *)initWithUsername:(NSString *)username password:(NSString *)password {
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
    }
    return self;
}

+ (id)buildFromDictionary:(NSDictionary *)dictionary {
    UserInfo *userInfo = [[UserInfo alloc] init];
    userInfo.ID = [[dictionary objectForKey:@"ID"] intValue];
    userInfo.username = [dictionary objectForKey:@"username"];
    userInfo.password = [dictionary objectForKey:@"password"];
    userInfo.email = [dictionary objectForKey:@"email"];
    userInfo.mobile = [dictionary objectForKey:@"mobile"];
    userInfo.realName = [dictionary objectForKey:@"realName"];
    userInfo.loginDate = [dictionary objectForKey:@"loginDate"];
    userInfo.loginCity = [dictionary objectForKey:@"loginCity"];
    return userInfo;
}

@end
