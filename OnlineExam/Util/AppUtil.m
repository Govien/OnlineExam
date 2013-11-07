//
//  AppUtil.m
//  OnlineExam
//
//  Created by Goven on 13-10-30.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "AppUtil.h"
#import "BlockAlertView.h"
#import "VCLogin.h"

@implementation AppUtil

+ (void)offline:(UIViewController *)vc {
    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"警告" message:@"您的帐号在异地登录！"];
    [alert setCancelButtonWithTitle:@"重新登录" block:^{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:INFO_AUTO_LOGIN];
        VCLogin *vcLogin = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"vcLogin"];
        vcLogin.offline = YES;
        [vc presentViewController:vcLogin animated:YES completion:nil];
    }];
    [alert setDestructiveButtonWithTitle:@"退出应用" block:^{
        [self exitApplication];
    }];
    [alert show];
}

+ (void)exitApplication {
    [UIView beginAnimations:@"exitApplication" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[UIApplication sharedApplication].keyWindow cache:NO];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    [UIApplication sharedApplication].keyWindow.bounds = CGRectMake(0, 0, 0, 0);
    [UIView commitAnimations];
}

+ (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([animationID compare:@"exitApplication"] == 0) {
        exit(0);
    }
}

@end
