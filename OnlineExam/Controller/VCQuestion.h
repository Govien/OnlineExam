//
//  VCQuestion.h
//  OnlineExam
//  问题
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//
#import "Chapter.h"

@interface VCQuestion : UIViewController

@property (nonatomic,retain)Chapter *chapter;
@property BOOL isErrorShow;

@end
