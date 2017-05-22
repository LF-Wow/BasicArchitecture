//
//  AppDelegate.m
//  BasicArchitecture
//
//  Created by 周君 on 16/10/28.
//  Copyright © 2016年 周君. All rights reserved.
//

#import "AppDelegate.h"
#import "ZJTabBarViewController.h"
#import <VZInspector.h>
#import <UMMobClick/MobClick.h>
#import <UMSocialCore/UMSocialCore.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[ZJTabBarViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    //加载小眼睛
    [self loadVZInspector];
    //集成友盟
    [self integrationUM];
    
    return YES;
}

#pragma mark - 集成友盟
- (void)integrationUM
    {
        [MobClick setLogEnabled:YES];
        UMConfigInstance.appKey = um_appKey;
        UMConfigInstance.channelId = @"App Store";
        [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
        
        /* 设置友盟appkey */
        [[UMSocialManager defaultManager] setUmSocialAppkey:um_appKey];
        /* 打开调试日志 */
        [[UMSocialManager defaultManager] openLog:NO];
        
        [self configUSharePlatforms];
        
        [self confitUShareSettings];
        
    }
    
- (void)confitUShareSettings
    {
        /*
         * 打开图片水印
         */
        //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
        
        /*
         * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
         <key>NSAppTransportSecurity</key>
         <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
         </dict>
         */
        //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
        
    }
    
- (void)configUSharePlatforms
    {
        /* 设置微信的appKey和appSecret */
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:wx_appKey appSecret:wx_appSecret redirectURL:@"http://mobile.umeng.com/social"];
        /*
         * 移除相应平台的分享，如微信收藏
         */
        [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
        
        /* 设置分享到QQ互联的appID
         * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
         */
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:qq_appKey/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
        
        /* 设置新浪的appKey和appSecret */
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:wb_appKey appSecret:wb_appSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
        
        
    }
    
    // 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
    {
        //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
        BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
        if (!result) {
            // 其他如支付等SDK的回调
        }
        return result;
    }
    
    //加载小眼睛
- (void)loadVZInspector
    {
        [VZInspector showOnStatusBar];
        
    }
    
@end
