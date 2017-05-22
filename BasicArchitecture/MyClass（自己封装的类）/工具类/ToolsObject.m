//
//  ToolsObject.m
//  test
//
//  Created by 周君 on 16/8/25.
//  Copyright © 2016年 周君. All rights reserved.
//

#import "ToolsObject.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

@implementation ToolsObject

#pragma mark - 判断邮件
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - 判断手机号
+(BOOL)isTelephoneNumber:(NSString *)phoneNumber
{
    NSString *phoneNumberRegex = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSPredicate *phoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumberRegex];
    return [phoneNumberTest evaluateWithObject:phoneNumber];
}

#pragma mark - 时间转字符串
+ (NSString *)dateToString:(NSDate *)date AndDateStyle:(DateStyle)style
{
    NSString *dateFormat;
    switch (style)
    {
        case YearAndHours:
            dateFormat = @"yyyy-MM-dd hh:mm";
            break;
        case YearAndMonth:
            dateFormat = @"yyyy-MM-dd";
            break;
        case MonthAndHours:
            dateFormat = @"MM-dd hh:mm";
            break;
        case Year:
            dateFormat = @"yyyy";
            break;
        case Month:
            dateFormat = @"MM-dd";
            break;
        case Hours:
            dateFormat = @"hh:mm";
            break;
            
        default:
            break;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    
    return [formatter stringFromDate:date];
}
#pragma mark - 字符串转时间
+ (NSDate *)strignToDate:(NSString *)str AndDateStyle:(DateStyle)style
{
    NSString *dateFormat;
    switch (style)
    {
        case YearAndHours:
            dateFormat = @"yyyy-MM-dd hh:mm";
            break;
        case YearAndMonth:
            dateFormat = @"yyyy-MM-dd";
            break;
        case MonthAndHours:
            dateFormat = @"MM-dd hh:mm";
            break;
        case Year:
            dateFormat = @"yyyy";
            break;
        case Month:
            dateFormat = @"MM-dd";
            break;
        case Hours:
            dateFormat = @"hh:mm";
            break;
            
        default:
            break;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    
    return [formatter dateFromString:str];
}

#pragma mark - 设置行间距
+(NSMutableAttributedString *)setLabelGapWithStr:(id)labelStr andGap:(float)gamNum
{
    //设置行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:gamNum];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelStr length])];
    return attributedString;
}
#pragma mark - 计算文字高度
+(CGFloat)getTheHeightFromText:(NSString *)string WithFontSize:(CGFloat)fontSize LabelWidth:(CGFloat)width
{
    CGSize titleSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return titleSize.height;
}

/**************加载提示*********************/

#pragma mark - 显示加载框
+ (void)showLoadingMessage:(NSString *)message WithTitle:(NSString *)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[ToolsObject getCurrentVC].view animated:YES];
    
    // Set the label text.
    hud.label.text = NSLocalizedString(message, @"HUD loading title");
    // Set the details label text. Let's make it multiline this time.
    hud.detailsLabel.text = NSLocalizedString(title, @"HUD title");
}

#pragma mark - 隐藏提示
+ (void)hiddenAlert
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[ToolsObject getCurrentVC].view animated:YES];
    [hud hideAnimated:YES];
}

#pragma mark - 显示文字提示
+ (void)showMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[ToolsObject getCurrentVC].view animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(message, @"HUD message title");
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, SCREENHEIGHT / 2 - 100);
    [hud hideAnimated:YES afterDelay:1.5f];
}

#pragma mark - 显示自定义提示
+ (void)showMessage:(NSString *)message WithCustomView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[ToolsObject getCurrentVC].view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    hud.customView = view;
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.label.text = NSLocalizedString(message, @"HUD done title");
    [hud hideAnimated:YES afterDelay:3.f];
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];  
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
    
    return result;
}
#pragma mark - 获取版本号
+ (NSDictionary *)getAppVurVersionNum
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    return @{@"app_name":app_Name, @"app_Version":app_Version,@"app_build":app_build};
}
#pragma mark - 给视图加边框
+ (void)setBorderForView:(UIView *)view borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color cornerRadius:(CGFloat)radius
{
    view.layer.masksToBounds = YES;
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = borderWidth;
    view.layer.cornerRadius = radius;
}

#pragma mark - 给视图添加一根线
+ (UIView *)drawLineWithColor:(UIColor *)color
{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = color;
    
    return line;
}
@end
