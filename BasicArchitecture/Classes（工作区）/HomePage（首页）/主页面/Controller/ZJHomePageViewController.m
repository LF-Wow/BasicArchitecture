//
//  ZJHomePageViewController.m
//  BasicArchitecture
//
//  Created by 周君 on 16/10/28.
//  Copyright © 2016年 周君. All rights reserved.
//

#import "ZJHomePageViewController.h"
#import "ZJNavigationViewController.h"
#import "ZJLoginViewController.h"

@interface ZJHomePageViewController ()

@end

@implementation ZJHomePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    
    [self isAutoLogin];
}

#pragma mark -- 判断是否登录
- (void)isAutoLogin
{
    if (!(ISAUTOLOGIN))
    {
        ZJNavigationViewController *loginNVC = [[ZJNavigationViewController alloc] initWithRootViewController:[[ZJLoginViewController alloc] init]];
        loginNVC.navigationBar.hidden = YES;
        [self presentViewController:loginNVC animated:YES completion:nil];
    }
}

@end
