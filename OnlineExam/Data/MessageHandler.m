//
//  MessageHandler.m
//  Kaoyaya
//
//  Created by Goven on 13-9-29.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "MessageHandler.h"

@implementation Message

static Message *instance;
@synthesize obj;
@synthesize what;

+ (Message *)obtain {
    if (!instance) {
      instance = [[Message alloc] init];
    }
    return instance;
}

@end
