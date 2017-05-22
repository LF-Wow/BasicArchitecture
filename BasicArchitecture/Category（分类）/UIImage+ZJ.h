//
//  UIImage+ZJ.h
//  TYZJ
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 周君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZJ)
/**
 画一张纯颜色的图片
 
 @param color 需要的颜色
 @param size 大小
 @param alpha 透明度
 @return 返回的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha;

@end
