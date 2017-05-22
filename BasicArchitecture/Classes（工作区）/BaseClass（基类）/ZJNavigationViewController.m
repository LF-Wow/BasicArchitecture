//
//  ZJNavigationViewController.m
//  BasicArchitecture
//
//  Created by 周君 on 16/10/28.
//  Copyright © 2016年 周君. All rights reserved.
//

#import "ZJNavigationViewController.h"

@interface ZJNavigationViewController ()

@end

@implementation ZJNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = UIColorFromRGB(0Xe3383b);
    self.navigationBar.titleTextAttributes = @{
                                               NSFontAttributeName : [UIFont systemFontOfSize:20], NSForegroundColorAttributeName : UIColorFromRGB(0Xffffff)
                                               };
    
}

//重写系统的方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    if (self.viewControllers.count > 1)
    {
        //隐藏底部选项卡，显示顶部导航栏
        viewController.navigationController.navigationBar.hidden = NO;
        viewController.tabBarController.tabBar.hidden = YES;
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
        //添加左边导航栏返回按钮
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        
        leftButton.frame = (CGRect){15, 0, 21, 21};
        
        [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    }
}

-(void)leftBtnClick
{
    [self popViewControllerAnimated:YES];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [super popViewControllerAnimated:YES];
    
    if (self.viewControllers.count == 1)
    {
        self.navigationBar.hidden = NO;
        self.tabBarController.tabBar.hidden = NO;
        self.navigationBar.barTintColor = UIColorFromRGB(0Xe3383b);
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    return self;
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    [super popToRootViewControllerAnimated:animated];
    
    if (self.viewControllers.count == 1)
    {
        self.navigationBar.hidden = NO;
        self.tabBarController.tabBar.hidden = NO;
        self.navigationBar.barTintColor = UIColorFromRGB(0Xe3383b);
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    return self.viewControllers;
}

@end
