//
//  ZJTabBarViewController.m
//  BasicArchitecture
//
//  Created by 周君 on 16/10/28.
//  Copyright © 2016年 周君. All rights reserved.
//

#import "ZJTabBarViewController.h"
#import "ZJNavigationViewController.h"
#import "ZJHomePageViewController.h"
#import "ZJAddressBookViewController.h"
#import "ZJSetViewController.h"

@interface ZJTabBarViewController ()

@end

@implementation ZJTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZJNavigationViewController *homePageNaVC = [[ZJNavigationViewController alloc] initWithRootViewController:[[ZJHomePageViewController alloc] init]];
    ZJNavigationViewController *addressBookNaVC = [[ZJNavigationViewController alloc] initWithRootViewController:[[ZJAddressBookViewController alloc] init]];
    ZJNavigationViewController *setNaVC = [[ZJNavigationViewController alloc] initWithRootViewController:[[ZJSetViewController alloc] init]];
    
    [self setVCWithNaviVC:homePageNaVC andTitle:nil andNormalImage:nil andselectImage:@"新闻icon2"];
    [self setVCWithNaviVC:addressBookNaVC andTitle:@"沟通" andNormalImage:@"沟通icon" andselectImage:@"沟通icon2"];
    [self setVCWithNaviVC:setNaVC andTitle:@"工作" andNormalImage:@"工作icon" andselectImage:@"工作icon2"];
    
    [self addChildViewController:homePageNaVC];
    [self addChildViewController:addressBookNaVC];
    [self addChildViewController:setNaVC];

    self.selectedViewController = homePageNaVC;
    
}

- (void)setVCWithNaviVC:(ZJNavigationViewController *)VC andTitle:(NSString *)title andNormalImage:(NSString *)normalImage andselectImage:(NSString *)selectImage
{
    VC.tabBarItem.title = title;
    [VC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromRGB(0X828282)} forState:UIControlStateNormal];
    [VC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromRGB(0X010101)} forState:UIControlStateSelected];
    VC.tabBarItem.image = [[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

@end
