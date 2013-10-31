//
//  Result.h
//  OnlineExam
//
//  Created by Goven on 13-10-17.
//  Copyright (c) 2013年 Goven. All rights reserved.
//
#define STATE_FAIL 0
#define STATE_SUCCESS 1
#define STATE_OFFLINE 2

@interface Result : NSObject

@property int stateCode;// 状态码
@property (nonatomic,strong)id content;// 数据内容
@property (nonatomic,strong)NSString *message;// 简短消息

- (id)initWithStateCode:(int)stateCode content:(id)content message:(NSString *)message;

@end
