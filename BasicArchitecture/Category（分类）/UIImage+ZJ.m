//
//  UIImage+ZJ.m
//  TYZJ
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 周君. All rights reserved.
//

#import "UIImage+ZJ.h"

@implementation UIImage (ZJ)

#pragma mark -  画一张纯颜色的图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha
{
    @autoreleasepool {
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetAlpha(context, alpha);
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        
        return img;
        
    }
}
@end
