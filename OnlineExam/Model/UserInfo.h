//
//  UserInfo.h
//  OnlineExam
//
//  Created by Goven on 13-10-18.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property int ID;
@property NSString *username;
@property NSString *password;
@property NSString *email;
@property NSString *mobile;
@property NSString *sex;

- (UserInfo *)initWithUsername:(NSString *)username password:(NSString *)password;

@end
