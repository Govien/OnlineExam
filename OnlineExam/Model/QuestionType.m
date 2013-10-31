//
//  QustionsType.m
//  OnlineExam
//
//  Created by Goven on 13-10-30.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "QuestionType.h"

@implementation QuestionType

+ (id)build:(NSDictionary *)dictionary {
    QuestionType *type = [[QuestionType alloc] init];
    type.ID = [[dictionary objectForKey:@"id"] intValue];
    type.typeCode = [[dictionary objectForKey:@"qtype_id"] intValue];
    type.name = [dictionary objectForKey:@"qtype_name"];
    return type;
}

@end
