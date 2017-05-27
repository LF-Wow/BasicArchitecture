//
//  ZJLoginViewController.m
//  BasicArchitecture
//
//  Created by ZJ on 2017/5/26.
//  Copyright © 2017年 周君. All rights reserved.
//

#import "ZJLoginViewController.h"
#import "ZJLoginView.h"

@interface ZJLoginViewController ()

/**登录视图*/
@property (nonatomic, strong) ZJLoginView *loginView;
@end

@implementation ZJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loginView = [[ZJLoginView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.loginView];
}


@end
