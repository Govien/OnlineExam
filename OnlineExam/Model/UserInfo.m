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

@end
