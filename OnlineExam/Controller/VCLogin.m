//
//  VCLogin.m
//  OnlineExam
//
//  Created by Goven on 13-10-16.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "VCLogin.h"
#import "DataHelper.h"
#import "VCMain.h"
#import "UserInfo.h"
#import "BlockAlertView.h"

@interface VCLogin ()<Handler> {
    UITextField *_tfEditing;
    DataHelper *_dataHelper;
    NSUserDefaults *_userDefaults;
    NSString *_username, *_password;
}

@property (weak, nonatomic) IBOutlet UIImageView *ivBg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *layoutInit;// 初始化布局视图
@property (weak, nonatomic) IBOutlet UIView *layoutRegist;// 注册布局视图
@property (weak, nonatomic) IBOutlet UITextField *tfUsername;// 用户名
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;// 密码
@property (weak, nonatomic) IBOutlet UITextField *tfPasswordConfirm;// 确认密码
@property (weak, nonatomic) IBOutlet UIView *layoutLogin;// 登录布局视图
@property (weak, nonatomic) IBOutlet UITextField *tfLoginName;// 登录用户名
@property (weak, nonatomic) IBOutlet UITextField *tfLoginPassword;// 登录密码
@property (weak, nonatomic) IBOutlet UISwitch *swAutoLogin;// 是否自动登录
@property (weak, nonatomic) IBOutlet UIView *layoutAuto;// 自动登录布局
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aivLoading;// 自动登录的进度圈

@end

@implementation VCLogin

@synthesize offline = _offline;

- (void)viewDidLoad
{
    [super viewDidLoad];
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        //某个仅支持7.0以上版本的方法
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if (self) {
        _dataHelper = [DataHelper init:self];
    }
    
    self.ivBg.image = [UIImage imageNamed:@"bg_login.jpg"];
    
    // 设置注册布局圆角
    self.layoutRegist.layer.masksToBounds = YES;
    self.layoutRegist.layer.cornerRadius = 6.0;
    self.layoutRegist.layer.borderWidth = 2.0;
    self.layoutRegist.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    // 设置登录布局圆角
    self.layoutLogin.layer.masksToBounds = YES;
    self.layoutLogin.layer.cornerRadius = 6.0;
    self.layoutLogin.layer.borderWidth = 2.0;
    self.layoutLogin.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    // 设置注册和登录布局处于屏幕以外
    CGRect frame = self.layoutRegist.frame;
    self.layoutRegist.frame = CGRectMake(frame.origin.x, self.view.frame.size.height, frame.size.width, frame.size.height);
    self.layoutLogin.frame = CGRectMake(frame.origin.x, self.view.frame.size.height, frame.size.width, frame.size.height);
    
    // 获取自动登录状态，登录服务器
    _userDefaults = [NSUserDefaults standardUserDefaults];
    _username = [_userDefaults objectForKey:INFO_USERNAME];
    self.tfLoginName.text = _username;
    if (_offline) {
        [self toggleLayout:self.layoutLogin turnOn:YES];
    } else {
        BOOL autoLogin = [_userDefaults boolForKey:INFO_AUTO_LOGIN];
        if (autoLogin) {
            self.layoutInit.hidden = YES;
            self.layoutAuto.hidden = NO;
            [self.aivLoading startAnimating];
            [self performSelectorInBackground:@selector(loading) withObject:nil];
        }
    }
}

- (void)loading {
    sleep(1);
    [self performSelectorOnMainThread:@selector(endLoading) withObject:nil waitUntilDone:YES];
}

- (void)endLoading {
    NSString *username = [_userDefaults stringForKey:INFO_USERNAME];
    _password = [_userDefaults stringForKey:INFO_PASSWORD];
    [_dataHelper login:username password:_password];
}

- (IBAction)onButtonClicked:(UIButton *)sender {
    int tag = sender.tag;
    switch (tag) {
        case 1:// 注册
            [self performRegist];
            break;
        case 2:// 注册取消
        case 3:// 注册关闭
            [self toggleLayout:self.layoutRegist turnOn:NO];
            break;
        case 4:// 登录
            [self performLogin];
            break;
        case 5:// 登录取消
        case 6:// 登录关闭
            [self toggleLayout:self.layoutLogin turnOn:NO];
            break;
        default:
            break;
    }
}

// 检查输入并执行注册
- (void)performRegist {
    NSString *username = self.tfUsername.text;
    NSString *password = self.tfPassword.text;
    NSString *rePassword = self.tfPasswordConfirm.text;
    NSString *message;
    if (![StringUtil isLengthIn:username min:5 max:16]) {
        message = @"用户名不能为空，长度5~16！";
    } else if (![StringUtil isLengthIn:password min:6 max:16]) {
        message = @"密码不能为空，长度6~16！";
    } else if ([StringUtil isTrimBlank:rePassword]) {
        message = @"请重复输入密码！";
    }
    else if (![StringUtil isEqualStr1:password str2:rePassword]) {
        message = @"两次密码输入不一致！";
    }
    if (message) {
        [[[UIAlertView alloc] initWithTitle:@"警告" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    } else {
        [self.view makeToastActivity];
        [_dataHelper regist:username password:password];
    }
}

// 检查输入并执行登录
- (void)performLogin {
    NSString *username = self.tfLoginName.text;
    _password = self.tfLoginPassword.text;
    NSString *message;
    if (![StringUtil isLengthIn:username min:5 max:16]) {
        message = @"用户名不能为空，长度5~16！";
    } else if(![StringUtil isLengthIn:_password min:6 max:16]) {
        message = @"密码不能为空，长度6~16！";
    }
    if (message) {
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"警告" message:message];
        [alert setDestructiveButtonWithTitle:@"         确    定         " block:nil];
        [alert show];
    } else {
        [self.view makeToastActivity];
        [_dataHelper login:username password:_password];
    }
}

- (void)handleMessage:(Message *)message {
    [self.view hideToastActivity];
    Result *result = message.obj;
    switch (message.what) {
        case DATA_REGIST:
            if (result.stateCode == STATE_FAIL) {
                [self.view makeToast:[NSString stringWithFormat:@"注册失败，%@！", result.message]];
            } else if (result.stateCode == STATE_SUCCESS) {
                [self.view makeToast:@"注册成功，请登录！"];
                [self toggleLayout:_layoutRegist turnOn:NO];
                [self toggleLayout:_layoutLogin turnOn:YES];
            }
            break;
        case DATA_LOGIN:
            [self handleLoginResult:result];
            break;
        case DATA_GET_ORDERITEMS:
            [self performSegueWithIdentifier:@"main" sender:result.content];
            break;
        default:
            break;
    }
}

// 处理登录的结果
- (void)handleLoginResult:(Result *)result {
    if (result.stateCode == STATE_FAIL) {
        [self.view makeToast:[NSString stringWithFormat:@"登录失败，%@！", result.message]];
        [_userDefaults setBool:NO forKey:INFO_AUTO_LOGIN];
        if ([self.aivLoading isAnimating]) {
            [self.aivLoading stopAnimating];
            self.layoutAuto.hidden = YES;
            [self toggleLayout:self.layoutLogin turnOn:YES];
        }
    } else if (result.stateCode == STATE_SUCCESS) {
        [self.view makeToast:@"登录成功！"];
        [self toggleLayout:_layoutLogin turnOn:NO];
        UserInfo *userInfo = [UserInfo buildFromDictionary:result.content];
        [_userDefaults setInteger:userInfo.ID forKey:INFO_USERID];
        [_userDefaults setObject:userInfo.username forKey:INFO_USERNAME];
        [_userDefaults setObject:_password forKey:INFO_PASSWORD];
        [_userDefaults setObject:userInfo.realName forKey:INFO_REALNAME];
        [_userDefaults setObject:userInfo.loginDate forKey:INFO_LOGIN_DATE];
        [_userDefaults setObject:userInfo.loginCity forKey:INFO_LOGIN_CITY];
        if (_swAutoLogin.on) {
            [_userDefaults setBool:YES forKey:INFO_AUTO_LOGIN];
        } else {
            [_userDefaults setBool:NO forKey:INFO_AUTO_LOGIN];
        }
        // 登录成功以后就开始获取用户订单
        [_dataHelper getOrderItemsOfUser:userInfo.ID];
    } else {
        [_userDefaults setBool:NO forKey:INFO_AUTO_LOGIN];
    }
    [_userDefaults synchronize];
}

- (IBAction)onValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self toggleLayout:self.layoutLogin turnOn:YES];
            break;
        case 1:
            [self toggleLayout:self.layoutRegist turnOn:YES];
            break;
        default:
            break;
    }

}

 // 布局开启和关闭,layoutView:要开启或关闭的布局视图,turnOn:是否开启
- (void)toggleLayout:(UIView *)layoutView turnOn:(BOOL)turnOn {
    [UIView animateWithDuration:0.3f animations:^{
        if (turnOn) {
            layoutView.frame = CGRectOffset(layoutView.frame, 0, - layoutView.frame.size.height);
        } else {
            layoutView.frame = CGRectOffset(layoutView.frame, 0, layoutView.frame.size.height);
        }
    }];
    if (_tfEditing) {
        [self textFieldShouldReturn:_tfEditing];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (!_tfEditing) {
        CGRect curFrame=textField.superview.frame;
        [UIView animateWithDuration:0.3f animations:^{
            textField.superview.frame = CGRectOffset(curFrame, 0, -216);
        }];
    }
    _tfEditing = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    CGRect curFrame=textField.superview.frame;
    [UIView animateWithDuration:0.3f animations:^{
        textField.superview.frame = CGRectOffset(curFrame, 0, 216);
    }];
    [textField resignFirstResponder];
    _tfEditing = nil;
    return YES;
}

// 监听UIContorl的点击事件
- (IBAction)onControlClick:(UIControl *)sender {
    if (_tfEditing) {
        [self textFieldShouldReturn:_tfEditing];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"main"]) {
        UINavigationController *vcNavigation = [segue destinationViewController];
        VCMain *vcMain = (VCMain *)vcNavigation.topViewController;
        vcMain.orderItems = sender;
    }
}

@end
