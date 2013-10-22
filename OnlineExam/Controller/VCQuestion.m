//
//  VCQuestion.m
//  OnlineExam
//  
//  Created by Goven on 13-10-22.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "VCQuestion.h"

@interface VCQuestion ()

@end

@implementation VCQuestion

@synthesize chapter = _chapter;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = _chapter.name;
}

@end
