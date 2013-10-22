#import <Foundation/Foundation.h>
@interface Book : NSObject

@property int ID;// 习题ID
@property int courseId;// 课程ID
@property int categoryId;// 类目ID
@property(strong,nonatomic)NSString *name;// 习题名称
@property(strong,nonatomic)NSString *courseName;// 课程名
@property float price;// 习题价格

+ (Book *)buildFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)convertToDictionary;

@end
