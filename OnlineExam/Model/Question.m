//
//  Question.m
//  OnlineExam
//
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "Question.h"
#import "Option.h"

@implementation Question

- (id)initWithID:(int)ID chapterId:(int)chapterId bookId:(int)bookId no:(int)no order:(int)order title:(NSString *)title tip:(NSString *)tip type:(int)type key:(NSString *)key options:(NSArray *)options {
    self = [super init];
    if (self) {
        _ID = ID;
        _chapterId = chapterId;
        _bookId = bookId;
        _no = no;
        _order = order;
        _title = title;
        _tip = tip;
        _type = type;
        _key = key;
        _options = options;
    }
    return self;
}

+ (id)buildFromDictionary:(NSDictionary *)dictionary {
    Question *question = [[Question alloc] init];
    question.ID = [[dictionary objectForKey:@"ID"] intValue];
    question.chapterId = [[dictionary objectForKey:@"chapterId"] intValue];
    question.bookId = [[dictionary objectForKey:@"bookId"] intValue];
    question.no = [[dictionary objectForKey:@"no"] intValue];
    question.order = [[dictionary objectForKey:@"order"] intValue];
    question.title = [dictionary objectForKey:@"title"];
    question.tip = [dictionary objectForKey:@"tip"];
    question.key = [dictionary objectForKey:@"key"];
    question.type = [[dictionary objectForKey:@"type"] intValue];
    NSMutableArray *mutableOptions = [[NSMutableArray alloc] init];
    for (NSDictionary *item in [dictionary objectForKey:@"options"]) {
        [mutableOptions addObject:[Option buildFromDictionary:item]];
    }
    question.options = mutableOptions;
    return question;
}

- (NSDictionary *)convertToDictionary {
    NSMutableArray *optionDic = [[NSMutableArray alloc] init];
    for (Option *option in _options) {
        [optionDic addObject:[option convertToDictionary]];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:self.ID], @"ID", [NSNumber numberWithInt:self.chapterId], @"chapterId", [NSNumber numberWithInt:self.bookId], @"bookId", [NSNumber numberWithInt:self.no], @"no", [NSNumber numberWithInt:self.order], @"order", self.title, @"title", self.tip, @"tip", [NSNumber numberWithInt:self.type], @"type", self.key, @"key", optionDic, @"options", nil];
}

@end
