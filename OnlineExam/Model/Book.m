#import "Book.h"

@implementation Book

- (id)init:(int)ID categoryId:(int)categoryId courseId:(int)courseId name:(NSString *)name price:(float)price degree:(float)degree {
    self = [super init];
    if (self) {
        _ID = ID;
        _categoryId = categoryId;
        _courseId = courseId;
        _name = name;
        _price = price;
        _degree = degree;
    }
    return self;
}

@end
