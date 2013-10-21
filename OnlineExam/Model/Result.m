//
//  Result.m
//  OnlineExam
//
//  Created by Goven on 13-10-17.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "Result.h"

@implementation Result

- (id)initWithStateCode:(int)stateCode content:(id)content message:(NSString *)message {
    _stateCode = stateCode;
    _content = content;
    _message = message;
    return self;
}

@end
