//
//  Chapter.m
//  OnlineExam
//
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "Chapter.h"

@implementation Chapter

- (id)initWithID:(int)ID bookId:(int)bookId name:(NSString *)name totalCount:(int)totalCount doneCount:(int)doneCount rightCount:(int)rightCount errorCount:(int)errorCount no:(int)no {
    self = [super init];
    if (self) {
        _ID = ID;
        _bookId = bookId;
        _name = name;
        _totalCount = totalCount;
        _doneCount = doneCount;
        _rightCount = rightCount;
        _errorCount = errorCount;
        _no = no;
    }
    return self;
}

+ (Chapter *)buildFromDictionary:(NSDictionary *)dictionary {
    Chapter *chapter = [[Chapter alloc] init];
    chapter.ID = [[dictionary objectForKey:@"ID"] intValue];
    chapter.bookId = [[dictionary objectForKey:@"bookId"] intValue];
    chapter.name = [dictionary objectForKey:@"name"];
    chapter.totalCount = [[dictionary objectForKey:@"totalCount"] intValue];
    chapter.doneCount = [[dictionary objectForKey:@"doneCount"] intValue];
    chapter.rightCount = [[dictionary objectForKey:@"rightCount"] intValue];
    chapter.errorCount = [[dictionary objectForKey:@"errorCount"] intValue];
    chapter.no = [[dictionary objectForKey:@"no"] intValue];
    return chapter;
}

- (NSDictionary *)convertToDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:self.ID], @"ID", [NSNumber numberWithInt:self.bookId], @"bookId", self.name, @"name", [NSNumber numberWithInt:self.totalCount], @"totalCount", [NSNumber numberWithInt:self.doneCount], @"doneCount", [NSNumber numberWithInt:self.rightCount], @"rightCount", [NSNumber numberWithInt:self.errorCount], @"errorCount",[NSNumber numberWithInt:self.no], @"no", nil];
}

@end
