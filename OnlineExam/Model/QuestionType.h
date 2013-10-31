//
//  QustionsType.h
//  OnlineExam
//
//  Created by Goven on 13-10-30.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

@interface QuestionType : NSObject

@property int ID;
@property int typeCode;
@property (strong,nonatomic)NSString *name;

+ (id)build:(NSDictionary *)dictionary;

@end
