//
//  ZJloginTextField.m
//  BasicArchitecture
//
//  Created by ZJ on 2017/5/26.
//  Copyright © 2017年 周君. All rights reserved.
//

#import "ZJloginTextField.h"


@implementation ZJloginTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //图标
        self.iconImage = [[UIImageView alloc] init];
        [self addSubview:self.iconImage];
        [self.iconImage makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(@0);
            make.width.height.equalTo(@30);
            make.left.equalTo(@2.5);
        }];
        
        //输入框
        self.textField = [[UITextField alloc] init];
        [self addSubview:self.textField];
        [self.textField makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(@0);
            make.left.right.equalTo(@5);
        }];
        
    }
    return self;
}

@end
