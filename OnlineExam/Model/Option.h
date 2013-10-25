//
//  Option.h
//  OnlineExam
//
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//


@interface Option : NSObject

@property int ID;// 选项ID
@property int questionId;// 问题ID
@property (strong, nonatomic)NSString *text;// 选项文本
@property int no;// 选项编号
@property BOOL isKey;// 是否正确

- (id)initWithID:(int)ID questionId:(int)questionId text:(NSString *)text no:(int)no isKey:(BOOL)isKey;
+ (id)buildFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)convertToDictionary;

@end
