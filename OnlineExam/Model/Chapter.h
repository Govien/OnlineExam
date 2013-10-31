//
//  Chapter.h
//  OnlineExam
//  章节实体类模型
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

@interface Chapter : NSObject

@property int ID;// 章节ID
@property int bookId;// 所属习题ID
@property (strong,nonatomic)NSString *name;// 题目名
@property int totalCount;// 题目总数
@property int doneCount;// 完成总数
@property int rightCount;// 对题总数
@property int errorCount;// 错题总数
@property int no;// 编号或需要，用来表示第几章
@property (strong,nonatomic)NSArray *questionTypes;

- (id)initWithID:(int)ID bookId:(int)bookId name:(NSString *)name totalCount:(int)totalCount doneCount:(int)doneCount rightCount:(int)rightCount errorCount:(int)errorCount no:(int)no;
+ (id)buildFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)convertToDictionary;

@end
