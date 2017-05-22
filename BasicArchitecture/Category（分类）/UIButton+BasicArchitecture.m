//
//  UIButton+BasicArchitecture.m
//  BasicArchitecture
//
//  Created by ZJ on 2017/5/22.
//  Copyright © 2017年 周君. All rights reserved.
//

#import "UIButton+BasicArchitecture.h"

@implementation UIButton(BasicArchitecture)
+ (UIButton *)BasicArchitecture_defaultButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = UIColorFromRGB(themColor);
    button.layer.cornerRadius = 10.f;
    return button;
}
    
@end
