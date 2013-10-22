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
@property (strong,nonatomic)NSString *username;
@property (strong,nonatomic)NSString *password;
@property (strong,nonatomic)NSString *email;
@property (strong,nonatomic)NSString *mobile;
@property (strong,nonatomic)NSString *sex;

- (UserInfo *)initWithUsername:(NSString *)username password:(NSString *)password;
+ (id)buildFromDictionary:(NSDictionary *)dictionary;

@end
