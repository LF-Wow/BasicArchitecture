//
//  ToolsObject.h
//  test
//
//  Created by 周君 on 16/8/25.
//  Copyright © 2016年 周君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolsObject : NSObject

/**
 * 判断邮箱格式
 *
 * @param email 输入邮箱的字符串
 *
 * @return 返回YES是邮箱，NO不是邮箱
 */
+(BOOL)isValidateEmail:(NSString *)email;

/**
 * 判断是否为手机号
 *
 * @param phoneNumber 输入手机号
 *
 * @return 返回是否为手机号
 */
+(BOOL)isTelephoneNumber:(NSString *)phoneNumber;

/**
 * 时间类型转换为字符串
 *
 * @param date 时间（时间类型为yyyy-MM-dd）
 *
 * @return 返回字符串
 */
+ (NSString *)dateToString:(NSDate *)date;

/**
 * 字符串转换为时间
 *
 * @param str 字符串（时间类型为yyyy-MM-dd）
 *
 * @return 返回时间
 */
+ (NSDate *)strignToDate:(NSString *)str;
/**
 * 设置行间距
 *
 * @param labelStr 要改变行间距的文字
 * @param gamNum   行间距的大小
 *
 * @return 返回改变行间距后的文字
 */
+(NSMutableAttributedString *)setLabelGapWithStr:(id)labelStr andGap:(float)gamNum;
/**
 * 显示加载提示
 *
 * @param message 加载文字
 */
+ (void)showLoadingMessage:(NSString *)message;

/**
 * 隐藏提示
 */
+ (void)hiddenAlert;

/**
 * 显示成功提示
 *
 * @param message 加载文字
 */
+ (void)showSuccessMessage:(NSString *)message;

/**
 * 显示失败提示
 *
 * @param message 加载文字
 */
+ (void)showErrorMessage:(NSString *)message;

/**
 获取当前屏幕的控制器

 @return 返回当前控制器
 */
+ (UIViewController *)getCurrentVC;

@end
