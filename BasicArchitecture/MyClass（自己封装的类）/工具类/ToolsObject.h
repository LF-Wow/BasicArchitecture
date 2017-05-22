//
//  ToolsObject.h
//  test
//
//  Created by 周君 on 16/8/25.
//  Copyright © 2016年 周君. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    YearAndHours,
    YearAndMonth,
    MonthAndHours,
    Month,
    Year,
    Hours
} DateStyle;
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
+ (NSString *)dateToString:(NSDate *)date AndDateStyle:(DateStyle)style;

/**
 * 字符串转换为时间
 *
 * @param str 字符串（时间类型为yyyy-MM-dd）
 *
 * @return 返回时间
 */
+ (NSDate *)strignToDate:(NSString *)str AndDateStyle:(DateStyle)style;
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
 获取文字高度

 @param string 需要计算的文字
 @param fontSize 计算的文字大小
 @param width 计算的label宽度
 @return 返回文字高度
 */
+(CGFloat)getTheHeightFromText:(NSString *)string WithFontSize:(CGFloat)fontSize LabelWidth:(CGFloat)width;
/**
 * 显示正在加载提示
 *
 * @param message 加载文字
 */

/**
 显示正在加载提示

 @param message 加载文字，可以为nil
 @param title 详细文字，可以为nil
 */
+ (void)showLoadingMessage:(NSString *)message WithTitle:(NSString *)title;

/**
 * 隐藏提示
 */
+ (void)hiddenAlert;

/**
 * 显示提示
 *
 * @param message 加载文字
 */
+ (void)showMessage:(NSString *)message;


/**
 显示自定义提示

 @param message 加载文字
 @param view 自定义视图
 */
+ (void)showMessage:(NSString *)message WithCustomView:(UIView *)view;

/**
 获取当前屏幕的控制器

 @return 返回当前控制器
 */
+ (UIViewController *)getCurrentVC;

/**
 获取当前版本号

 @return 返回字典key值：app_name ,app_version, app_build
 */
+ (NSDictionary *)getAppVurVersionNum;


/**
 为视图加上边框

 @param view 视图
 @param borderWidth 边框宽度
 @param color 边框颜色
 @param radius 边框圆角
 */
+ (void)setBorderForView:(UIView *)view borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color cornerRadius:(CGFloat)radius;

/**
 利用uiview做一条线

 @param color 线的颜色
 @return 返回这条线
 */
+ (UIView *)drawLineWithColor:(UIColor *)color;

@end
