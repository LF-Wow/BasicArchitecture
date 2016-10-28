//
//  ToolsObject.m
//  test
//
//  Created by 周君 on 16/8/25.
//  Copyright © 2016年 周君. All rights reserved.
//

#import "ToolsObject.h"
#import "SVProgressHUD.h"
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
+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm";
    
    return [formatter stringFromDate:date];
}
#pragma mark - 字符串转时间
+ (NSDate *)strignToDate:(NSString *)str
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm";
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

#pragma mark - 显示加载框
+ (void)showLoadingMessage:(NSString *)message
{
    [SVProgressHUD showWithStatus:message maskType:SVProgressHUDMaskTypeGradient];
}

#pragma mark - 隐藏提示
+ (void)hiddenAlert
{
    [SVProgressHUD dismiss];
}

#pragma mark - 显示成功提示
+ (void)showSuccessMessage:(NSString *)message
{
    [SVProgressHUD showSuccessWithStatus:message maskType:SVProgressHUDMaskTypeGradient];
}

#pragma mark - 显示失败提示
+ (void)showErrorMessage:(NSString *)message
{
    [SVProgressHUD showErrorWithStatus:message maskType:SVProgressHUDMaskTypeGradient];
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
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
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
