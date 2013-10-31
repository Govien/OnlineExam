//
//  Option.m
//  OnlineExam
//
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "Option.h"

@implementation Option

- (id)initWithID:(int)ID questionId:(int)questionId text:(NSString *)text no:(int)no isKey:(BOOL)isKey {
    self = [self init];
    if (self) {
        _ID = ID;
        _questionId = questionId;
        _text = text;
        _no = no;
        _isKey = isKey;
    }
    return self;
}

+ (id)buildFromDictionary:(NSDictionary *)dictionary {
    Option *option = [[Option alloc] init];
    option.ID = [[dictionary objectForKey:@"ID"] intValue];
    option.questionId = [[dictionary objectForKey:@"questionId"] intValue];
    option.text = [dictionary objectForKey:@"text"];
    option.no = [[dictionary objectForKey:@"no"] intValue];
    option.isKey = [[dictionary objectForKey:@"isKey"] boolValue];
    return option;
}

+ (id)build:(NSDictionary *)dictionary {
    Option *option = [[Option alloc] init];
    option.text = [dictionary objectForKey:@"answer_text"];
    option.no = [[dictionary objectForKey:@"orderid"] intValue];
//    option.isKey = [[dictionary objectForKey:@"is_true_answer"] boolValue];
    id val = [dictionary objectForKey:@"is_true_answer"];
    if (val != [NSNull null]) {
        option.isKey = [val boolValue];
    }
    return option;
}

- (NSDictionary *)convertToDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:self.ID], @"ID", [NSNumber numberWithInt:self.questionId], @"questionId", self.text, @"text", [NSNumber numberWithInt:self.no], @"no",[NSNumber numberWithBool:self.isKey], @"isKey", nil];
}

@end
