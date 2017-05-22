//
//  BZTDateView.h
//  TYZJ
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 周君. All rights reserved.
//

#import "MMPopupView.h"

typedef void(^buttonDidClick)();

@interface BZTDateView : MMPopupView

@property (nonatomic, strong) UIDatePicker *datePicker;
/** 确定被点击*/
@property (nonatomic, copy)buttonDidClick block;

@end
