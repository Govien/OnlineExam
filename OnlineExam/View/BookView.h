//
//  BookView.h
//  Kaoyaya
//
//  Created by Goven on 13-10-2.
//  Copyright (c) 2013年 Goven. All rights reserved.
//
#import "OrderItem.h"
#import "PDColoredProgressView.h"

@protocol BookDelegate;

@interface BookView : UIView

@property OrderItem *orderItem;

// BookView的初始化工作
- (BookView *)initWithBook:(OrderItem *)item bookDelegate:(id<BookDelegate>)delegate imageName:(NSString *)imageName;

@end

// 习题的点击事件委托
@protocol BookDelegate <NSObject>

- (void)onBookClicked:(BookView *)bookView;

@end
