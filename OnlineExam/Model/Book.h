#import <Foundation/Foundation.h>
@interface Book : NSObject

@property int ID;// 习题ID
@property int courseId;// 课程ID
@property int categoryId;// 类目ID
@property(strong, nonatomic)NSString* name;// 习题名称
@property float price;// 习题价格
@property float degree;// 完成进度

- (id)init:(int)ID categoryId:(int)categoryId courseId:(int)courseId name:(NSString *)name price:(float)price degree:(float)degree;

@end
