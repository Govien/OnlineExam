//
//  VCBook.h
//  Kaoyaya
//
//  Created by Goven on 13-10-14.
//  Copyright (c) 2013年 Goven. All rights reserved.
//
#import "Book.h"

@interface VCBook : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,retain)Book *book;

@end
