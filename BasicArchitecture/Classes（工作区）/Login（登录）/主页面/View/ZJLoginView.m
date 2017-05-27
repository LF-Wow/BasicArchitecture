//
//  ZJLoginView.m
//  BasicArchitecture
//
//  Created by ZJ on 2017/5/26.
//  Copyright © 2017年 周君. All rights reserved.
//

#import "ZJLoginView.h"
#import "ZJloginTextField.h"

@interface ZJLoginView()

/**log图片*/
@property (nonatomic, strong) UIImageView *logImage;
/**用户名输入框*/
@property (nonatomic, strong) ZJloginTextField *userNameField;
/**密码输入框*/
@property (nonatomic, strong) ZJloginTextField *passWordField;
/**记住密码按钮*/
@property (nonatomic, strong) UIButton *remPasswordBtn;
/**注册按钮*/
@property (nonatomic, strong) UIButton *registBtn;
/**登录按钮*/
@property (nonatomic, strong) UIButton *loginBtn;
/**关闭按钮*/
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation ZJLoginView

- (UIImageView*)logImage
{
    if (!_logImage)
    {
        _logImage = [[UIImageView alloc] init];
        _logImage.image = [UIImage imageNamed:@""];
    }
    return _logImage;
}

- (ZJloginTextField*)userNameField
{
    if (!_userNameField)
    {
        _userNameField = [[ZJloginTextField alloc] init];
        _userNameField.iconImage.image = [UIImage imageNamed:@""];
        _userNameField.textField.placeholder = @"请输入用户名";
        _userNameField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return _userNameField;
}

- (ZJloginTextField *)passWordField
{
    if (!_passWordField)
    {
        _passWordField = [[ZJloginTextField alloc] init];
        _passWordField.iconImage.image = [UIImage imageNamed:@""];
        _passWordField.textField.placeholder = @"请输入密码";
        _passWordField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWordField.textField.secureTextEntry = YES;
        
    }
    return _passWordField;
}

- (UIButton *)remPasswordBtn
{
    if (!_remPasswordBtn)
    {
        _remPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_remPasswordBtn setImage:[UIImage imageNamed:@"单选框_未选中"] forState:UIControlStateNormal];
        [_remPasswordBtn setImage:[UIImage imageNamed:@"单选框_选中"] forState:UIControlStateSelected];
        [_remPasswordBtn setTitleColor:UIColorFromRGB(textColor) forState:UIControlStateNormal];
        [_remPasswordBtn setTitle:@"记住密码" forState:UIControlStateNormal];
    }
    
    [ToolsObject setBorderForView:self borderWidth:1.f borderColor:UIColorFromRGB(textColor) cornerRadius:0];
    
    return _remPasswordBtn;
}

- (UIButton*)registBtn
{
    if (!_registBtn)
    {
        _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        [_registBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _registBtn;
}

- (UIButton*)loginBtn
{
    if (!_loginBtn)
    {
        _loginBtn = [UIButton BasicArchitecture_defaultButton];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
    return _loginBtn;
}

- (UIButton*)closeBtn
{
    if (!_closeBtn)
    {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"login_gb"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(cannelLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.logImage];
        [self.logImage makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@100);
            make.centerX.equalTo(@0);
            make.height.with.equalTo(@50);
        }];
        
        [self addSubview:self.userNameField];
        [self.userNameField makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.logImage.bottom).offset(@10);
            make.left.equalTo(@30);
            make.right.equalTo(@-30);
            make.height.equalTo(@35);
        }];
        
        [self addSubview:self.passWordField];
        [self.passWordField makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userNameField.bottom).offset(@10);
            make.left.equalTo(@30);
            make.right.equalTo(@-30);
            make.height.equalTo(@35);
        }];
        
        [self addSubview:self.remPasswordBtn];
        [self.remPasswordBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.passWordField.left);
            make.top.equalTo(self.passWordField.bottom).offset(@10);
            make.height.equalTo(@20);
            make.width.equalTo(@90);
        }];
        
        [self addSubview:self.registBtn];
        [self.registBtn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.passWordField.right);
            make.top.equalTo(self.passWordField.bottom).offset(@10);
            make.height.equalTo(@20);
            make.width.equalTo(@74);
        }];
        
        [self addSubview:self.loginBtn];
        [self.loginBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.remPasswordBtn.bottom).offset(@10);
            make.left.equalTo(@30);
            make.right.equalTo(@-30);
            make.height.equalTo(@30);
        }];
        
        [self addSubview:self.closeBtn];
        [self.closeBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@30);
            make.right.equalTo(@-30);
            make.width.height.equalTo(@35);
        }];
    }
    return self;
}


- (void)cannelLogin
{
    [[ToolsObject getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
}
@end
