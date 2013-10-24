//
//  Constants.h
//  OnlineExam
//
//  Created by Goven on 13-10-17.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#define DATA_REGIST 0
#define DATA_LOGIN 1
#define DATA_GET_ORDERITEMS 2
#define DATA_GET_BOOKINFO 3
#define DATA_GET_CHAPTERS 4
#define DATA_GET_LATER_QUESTIONS 5

#define INFO_USERID @"INFO_USERID"
#define INFO_USERNAME @"INFO_USERNAME"
#define INFO_PASSWORD @"INFO_PASSWORD"
#define INFO_AUTO_LOGIN @"INFO_AUTO_LOGIN"

// 定义问题类型枚举，有单选／多选／判断
typedef NS_ENUM(NSInteger, QuestionType) {
    QuestionTypeJudge = 0,
    QuestionTypeRadio = 1,
    QuestionTypeMulti = 2
};

