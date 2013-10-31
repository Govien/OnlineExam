//
//  BookView.m
//  Kaoyaya
//
//  Created by Goven on 13-10-2.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "BookView.h"

@interface BookView() {
    UIImageView *_ivBook;// 封面图片
    UILabel *_lblName;// 书名
    PDColoredProgressView *_progress;// 自定义的进度条，用于显示习题完成情况
    id<BookDelegate> _delegate;// 习题事件委托
    UITapGestureRecognizer *_tapGestureRecognizer;
}

@end

@implementation BookView

@synthesize orderItem = _orderItem;

- (BookView *)initWithBook:(OrderItem *)item bookDelegate:(id<BookDelegate>)delegate imageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        _orderItem = item;
        _delegate = delegate;
        UIImage *img = [UIImage imageNamed:imageName];
        _ivBook = [[UIImageView alloc] initWithImage:img];
        _ivBook.frame = CGRectMake(0, 0, 65, 100);
        [self addSubview:_ivBook];
        
        _lblName = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 65, 70)];
        _lblName.text = item.productName;
        _lblName.font = [UIFont systemFontOfSize:14];
        _lblName.textColor = [UIColor lightTextColor];
        _lblName.backgroundColor = [UIColor clearColor];
        _lblName.numberOfLines = 4;
        [self addSubview:_lblName];
        
        _progress = [[PDColoredProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
        _progress.frame = CGRectMake(65, 80, 70, 8);
        [_progress setTintColor: [UIColor brownColor]];
        _progress.progress = item.degree;
        [self addSubview: _progress];
        
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBookClicked)];
        [self addGestureRecognizer:_tapGestureRecognizer];

    }
    return self;
}

// 传递习题的点击事件委托给具体实现者
- (void)onBookClicked {
    if (_delegate && [_delegate respondsToSelector:@selector(onBookClicked:)]) {
        [_delegate onBookClicked:self];
    }
}

@end
