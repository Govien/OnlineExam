//
//  VCBook.h
//  Kaoyaya
//
//  Created by Goven on 13-10-14.
//  Copyright (c) 2013年 Goven. All rights reserved.
//
@class OrderItem;

@interface VCBook : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,retain)OrderItem *orderItem;
@property (strong, nonatomic) IBOutlet UIProgressView *abc;

@end
