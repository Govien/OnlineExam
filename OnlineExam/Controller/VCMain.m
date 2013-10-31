//
//  GoViewController.m
//  Kaoyaya
//
//  Created by Goven on 13-9-24.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "VCMain.h"
#import "VCBook.h"
#import "RecipeSegmentControl.h"
#import "DataHelper.h"
#import "Book.h"
#import "MBProgressHUD.h"

@interface VCMain ()<Handler, BookDelegate>
{
    UIView *_segmentBg;
    UISegmentedControl *_segmentPurchase;// 已购买和试用的分段选择器
    UIScrollView *_scrollView, *_testScrolView;// 书架滚动视图
    DataHelper *_dataHelper;
}
@end

@implementation VCMain

@synthesize orderItems = _orderItems;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataHelper = [DataHelper init:self];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_book_shelf.png"]];
    
    // 书架滚动视图初始化
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 480 + 100);
    [self.view addSubview:_scrollView];
    
    // 分段选择器初始化
    _segmentBg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    _segmentBg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    _segmentPurchase = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"已购买", @"试用", nil]];
    _segmentPurchase.frame = CGRectMake(0, 5, 220.0, 30);
    _segmentPurchase.selectedSegmentIndex = 0;
    [_segmentPurchase addTarget:self action:@selector(onSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    [_segmentBg addSubview:_segmentPurchase];
    [_scrollView addSubview:_segmentBg];
    
    // 试用滚动视图
    _testScrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _testScrolView.contentSize = CGSizeMake(self.view.frame.size.width, 480 + 100);
    [self.view addSubview:_testScrolView];
    _testScrolView.hidden = YES;
    
    // 初始化书架
    for (int i = 1; i <= 4; i ++) {
        UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"book_shelf_cell.png"]];
        imageView.frame = CGRectMake(0, (i-1)*110 + 40, 320, 110);
        [_scrollView addSubview:imageView];
    }
    [self.view addSubview:[[RecipeSegmentControl alloc] init]];
    [self initBooks:_orderItems];
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.dimBackground = YES;
//    hud.labelText = @"progress标题";
}

// 初始化已购买的习题
- (void)initBooks:(NSDictionary *)books {
    NSArray *buyBooks = [books objectForKey:@"buys"];
    NSArray *testBooks = [books objectForKey:@"tests"];
    [_segmentPurchase setTitle:[NSString stringWithFormat:@"已购买(%d)", buyBooks.count] forSegmentAtIndex:0];
    [_segmentPurchase setTitle:[NSString stringWithFormat:@"试用(%d)", testBooks.count] forSegmentAtIndex:1];
    BookView *bookView;
    for (int i = 0; i < buyBooks.count; i++) {
        OrderItem *item = [OrderItem buildFromDictionary:[buyBooks objectAtIndex:i]];
        bookView = [[BookView alloc] initWithBook:item bookDelegate:self imageName:@"book_new"];
        if (i%2 == 0) {
            if (i/2 >3) {
                UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"book_shelf_cell.png"]];
                imageView.frame = CGRectMake(0, i/2*110+40, 320, 110);
                [_scrollView addSubview:imageView];
                _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, _scrollView.contentSize.height + 110);
            }
            bookView.frame = CGRectMake(20, i/2*110+55, 135, 100);
        } else {
            bookView.frame = CGRectMake(165, i/2*110+55, 135, 100);
        }
        [_scrollView addSubview:bookView];
    }
    [self initTestBooks:testBooks];
}

// 初始化试用习题
- (void)initTestBooks:(NSArray *)books {
    for (int i = 1; i <= 4; i ++) {
        UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"book_shelf_cell.png"]];
        imageView.frame = CGRectMake(0, (i-1)*110 + 40, 320, 110);
        [_testScrolView addSubview:imageView];
    }
    BookView *bookView;
    for (int i = 0; i < books.count; i++) {
        OrderItem *item = [OrderItem buildFromDictionary:[books objectAtIndex:i]];
        bookView = [[BookView alloc] initWithBook:item bookDelegate:self imageName:@"book_new"];
        if (i%2 == 0) {
            if (i/2 >3) {
                UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"book_shelf_cell.png"]];
                imageView.frame = CGRectMake(0, i/2*110+40, 320, 110);
                [_testScrolView addSubview:imageView];
                _testScrolView.contentSize = CGSizeMake(self.view.frame.size.width, _testScrolView.contentSize.height + 110);
            }
            bookView.frame = CGRectMake(20, i/2*110+55, 135, 100);
        } else {
            bookView.frame = CGRectMake(165, i/2*110+55, 135, 100);
        }
        [_testScrolView addSubview:bookView];
    }
}

- (void)handleMessage:(Message *)message {
    [self.view hideToastActivity];
    Result *result = message.obj;
    switch (message.what) {
        case DATA_GET_ORDERITEMS:
            [self initBooks:result.content];
            break;
        case DATA_GET_BOOKINFO:
            [self performSegueWithIdentifier:@"book" sender:[Book buildFromDictionary:result.content]];
            break;
        default:
            break;
    }
}

// 处理习题点击事件
- (void)onBookClicked:(BookView *)bookView {
    [self.view makeToastActivity];
    [_dataHelper getBookInfo:bookView.orderItem.bookId provinceId:bookView.orderItem.provinceId];
}

// 处理分段控件选择改变事件
- (void)onSegmentChanged:(UISegmentedControl*)control {
    switch (control.selectedSegmentIndex) {
        case 0:
            [_scrollView addSubview:_segmentBg];
            _scrollView.hidden = NO;
            _testScrolView.hidden = YES;
            break;
        case 1:
            [_testScrolView addSubview:_segmentBg];
            _scrollView.hidden = YES;
            _testScrolView.hidden = NO;
            break;
        default:
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"book"]) {
        VCBook *vcBook = [segue destinationViewController];
        vcBook.book = sender;
    }
}

@end
