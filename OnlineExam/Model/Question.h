//
//  Question.h
//  OnlineExam
//
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

@interface Question : NSObject

@property int ID;// 问题ID
@property int chapterId;// 所属章节ID
@property int bookId;// 所属习题ID
@property int no;// 问题编号
@property int order;// 问题序号
@property (strong,nonatomic)NSString *title;// 问题标题
@property (strong,nonatomic)NSString *tip;// 答案提示
@property int type;// 问题类型
@property int typeId;// 问题类型ID
@property (strong,nonatomic)NSString *key;// 答案
@property (strong,nonatomic)NSString *tipKey;// 提示答案
@property (strong,nonatomic)NSArray *options;// 选项集合

- (id)initWithID:(int)ID chapterId:(int)chapterId bookId:(int)bookId no:(int)no order:(int)order title:(NSString *)title tip:(NSString *)tip type:(int)type key:(NSString *)key options:(NSArray *)options;
+ (id)buildFromDictionary:(NSDictionary *)dictionary;
+ (id)build:(NSDictionary *)dictionary;
- (NSDictionary *)convertToDictionary;

@end
