//
//  GoViewController.m
//  Kaoyaya
//
//  Created by Goven on 13-9-24.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "VCMain.h"
#import "VCBook.h"
#import "VCLogin.h"
#import "RecipeSegmentControl.h"
#import "DataHelper.h"
#import "Book.h"
#import "MBProgressHUD.h"
#import "BlockAlertView.h"

@interface VCMain ()<Handler, BookDelegate, UITableViewDelegate, UITableViewDataSource, SegmentButtonViewDelegate>
{
    UIView *_segmentBg, *_vHome;
    UISegmentedControl *_segmentPurchase;// 已购买和试用的分段选择器
    RecipeSegmentControl *_menuControl;
    UIScrollView *_scrollView, *_testScrolView;// 书架滚动视图
    DataHelper *_dataHelper;
    BOOL _isTestShow;
}
@property (weak, nonatomic) IBOutlet UIScrollView *svPerson;
@property (weak, nonatomic) IBOutlet UIScrollView *svSetting;
@property (weak, nonatomic) IBOutlet UIView *vUserInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblMobile;

@end

@implementation VCMain

@synthesize orderItems = _orderItems;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        //某个仅支持7.0以上版本的方法
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    _dataHelper = [DataHelper init:self];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_book_shelf.png"]];
    _vHome = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_vHome];
    
    // 分段选择器初始化
    _segmentBg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    _segmentBg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    _segmentPurchase = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"已购买", @"试用", nil]];
    _segmentPurchase.frame = CGRectMake(0, 5, 220.0, 30);
    _segmentPurchase.selectedSegmentIndex = 0;
    [_segmentPurchase addTarget:self action:@selector(onSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    [_segmentBg addSubview:_segmentPurchase];
    
    // 书架滚动视图初始化
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 480 + 100);
    [_scrollView addSubview:_segmentBg];
    [_vHome addSubview:_scrollView];
    
    // 试用滚动视图
    _testScrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _testScrolView.contentSize = CGSizeMake(self.view.frame.size.width, 480 + 100);
    [_vHome addSubview:_testScrolView];
    _testScrolView.hidden = YES;
    
    // 初始化书架
    for (int i = 1; i <= 4; i ++) {
        UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"book_shelf_cell.png"]];
        imageView.frame = CGRectMake(0, (i-1)*110 + 40, 320, 110);
        [_scrollView addSubview:imageView];
    }
    
    _menuControl = [[RecipeSegmentControl alloc] init:self];
    _menuControl.frame = CGRectMake(0, self.view.frame.size.height - [UIImage imageNamed:@"recipe_tab_1"].size.height, self.view.frame.size.width, [UIImage imageNamed:@"recipe_tab_1"].size.height);
    _menuControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    [self.view addSubview:_menuControl];
    [self initBooks:_orderItems];
    [self initPersonView];
    [self initSettingView];
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
            if (_isTestShow) {
                [self.view makeToast:@"暂未开通！"];
            } else {
                [self performSegueWithIdentifier:@"book" sender:[Book buildFromDictionary:result.content]];
            }
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
            _isTestShow = NO;
            [_scrollView addSubview:_segmentBg];
            _scrollView.hidden = NO;
            _testScrolView.hidden = YES;
            break;
        case 1:
            _isTestShow = YES;
            [_testScrolView addSubview:_segmentBg];
            _scrollView.hidden = YES;
            _testScrolView.hidden = NO;
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int tag = tableView.tag;
    int row = indexPath.row;
    if (tag == 0) {
        if (row == 0) {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"注销提示" message:@"您确定注销当前帐号？"];
            [alert setDestructiveButtonWithTitle:@"确定" block:^{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:INFO_AUTO_LOGIN];
                VCLogin *vcLogin = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"vcLogin"];
                vcLogin.offline = YES;
                [self presentViewController:vcLogin animated:YES completion:nil];
            }];
            [alert setCancelButtonWithTitle:@"取消" block:nil];
            [alert show];
        }
    } else {
        [self.view makeToast:@"暂未开通"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 0) {
        return 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int tag = tableView.tag;
    int section = indexPath.section;
    int row = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell_%d_%d_%d", tag, section, row]];
    return cell;
}

// 监听菜单选项选中事件
- (void)onSegmentSelected:(SegmentButtonView *)segmentButton {
    [_menuControl segmentButtonHighlighted:segmentButton];
    switch (segmentButton.tag) {
        case 1:
            _vHome.hidden = NO;
            _svPerson.hidden = YES;
            _svSetting.hidden = YES;
            break;
        case 2:
            _vHome.hidden = YES;
            _svPerson.hidden = NO;
            _svSetting.hidden = YES;
            break;
        case 3:
            _vHome.hidden = YES;
            _svPerson.hidden = YES;
            _svSetting.hidden = NO;
            break;
    }
}

- (void)initPersonView {
    _svPerson.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg5.jpg"]];
    // 设置圆角背景
    _vUserInfo.layer.masksToBounds = YES;
    _vUserInfo.layer.cornerRadius = 6.0;
    _vUserInfo.layer.borderWidth = 1.0;
    _vUserInfo.layer.borderColor = [[UIColor whiteColor] CGColor];
    _vUserInfo.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    
    NSUserDefaults *_userDefaults = [NSUserDefaults standardUserDefaults];
    _lblUsername.text = [NSString stringWithFormat:@"%@，欢迎您！", [_userDefaults objectForKey:INFO_USERNAME]];
    _lblEmail.text = [NSString stringWithFormat:@"上次登录时间：%@", [_userDefaults objectForKey:INFO_LOGIN_DATE]];
    _lblMobile.text = [NSString stringWithFormat:@"上次登录地点：%@", [_userDefaults objectForKey:INFO_LOGIN_CITY]];
}

- (void)initSettingView {
    _svSetting.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg5.jpg"]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"book"]) {
        VCBook *vcBook = [segue destinationViewController];
        vcBook.book = sender;
    }
}

@end
