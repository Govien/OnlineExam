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
@property int no;// 问题编号或序号
@property (strong,nonatomic)NSString *title;// 问题标题
@property (strong,nonatomic)NSString *tip;// 答案提示
@property int type;// 问题类型：0单选、1多选、2判断
@property (strong,nonatomic)NSString *key;// 答案

- (id)initWithID:(int)ID chapterId:(int)chapterId bookId:(int)bookId no:(int)no title:(NSString *)title tip:(NSString *)tip type:(int)type key:(NSString *)key;
+ (id)buildFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)convertToDictionary;

@end
