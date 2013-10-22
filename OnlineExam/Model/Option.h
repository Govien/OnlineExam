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
@property BOOL isKey;// 是否正确
@property int questionType;// 问题类型

@end
