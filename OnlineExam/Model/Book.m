#import "Book.h"

@implementation Book

+ (Book *)buildFromDictionary:(NSDictionary *)dictionary {
    Book *book = [[Book alloc] init];
    book.ID = [[dictionary objectForKey:@"ID"] intValue];
    book.courseId = [[dictionary objectForKey:@"courseId"] intValue];
    book.categoryId = [[dictionary objectForKey:@"categoryId"] intValue];
    book.name = [dictionary objectForKey:@"name"];
    book.courseName = [dictionary objectForKey:@"courseName"];
    book.price = [[dictionary objectForKey:@"price"] floatValue];
    return book;
}

- (NSDictionary *)convertToDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:self.ID], @"ID", [NSNumber numberWithInt:self.courseId], @"courseId", [NSNumber numberWithInt:self.categoryId], @"categoryId", self.name, @"name", self.courseName, @"courseName", [NSNumber numberWithFloat:self.price], @"price", nil];
}

@end
