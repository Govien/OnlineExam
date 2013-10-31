//
//  OrderItem.h
//  Kaoyaya
//  订单项数据模型
//  Created by Goven on 13-9-29.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

@interface OrderItem : NSObject

@property int ID;// ID
@property int courseId;// 科目ID
@property int bookId;// 习题ID
@property(strong, nonatomic)NSString* productName;// 产品名
@property int provinceId;// 省份名
@property(strong, nonatomic)NSString* buyTime;// 购买时间
@property float degree;// 完成进度

- (id)init:(int)ID courseId:(int)courseId bookId:(int)bookId productName:(NSString *)productName provinceId:(int)provinceId buyTime:(NSString *)buyTime degree:(float)degree;
+ (OrderItem *)buildFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)convertToDictionary;

@end
