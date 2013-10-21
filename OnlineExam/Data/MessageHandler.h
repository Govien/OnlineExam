//
//  MessageHandler.h
//  Kaoyaya
//
//  Created by Goven on 13-9-29.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

@interface Message : NSObject

@property(retain,nonatomic) id obj;
@property int what;

+ (Message *)obtain;

@end

@protocol Handler <NSObject>

- (void)handleMessage:(Message *)message;

@end
