//
//  ZJGlobal.h
//
//
//  Created by 周君 on 16/8/12.
//  Copyright © 2016年 周君. All rights reserved.
//

#ifndef ZJGlobal_h
#define ZJGlobal_h


/** 屏幕的宽**/
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
/** 屏幕的高**/
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

/** 取十六进制颜色**/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/** 添加观察者的自动提示宏定义**/
#define KeyPath(_object,keyPath) @(((_object.keyPath), #keyPath))

/** 轻文件获取*/
#define getUserData(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]

/** 设置轻文件*/
#define setUserData(value, key) [[NSUserDefaults standardUserDefaults] setValue:value forKey:key]

/** masonry的必要头文件**/
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS





#define SaveData(value, key) [[NSUserDefaults standardUserDefaults] setValue:value forKey:key]
#define GetData(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]

// 宏里面可变参数：...
// 函数中可变参数: __VA_ARGS__

#ifdef DEBUG // 调试阶段
#define ZJLog(...)  NSLog(__VA_ARGS__)

#else // 发布阶段

#define ZJLog(...)

#endif

#endif /* Global_h */
