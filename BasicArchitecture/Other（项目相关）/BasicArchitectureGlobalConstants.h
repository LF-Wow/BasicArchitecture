//
//  BasicArchitectureGlobalConstants.h
//  BasicArchitecture
//
//  Created by ZJ on 2017/5/22.
//  Copyright © 2017年 周君. All rights reserved.
//

#import <Foundation/Foundation.h>

// ZJKIT
#ifdef __cplusplus
#define ZJKIT_EXTERN		extern "C" __attribute__((visibility ("default")))
#else
#define ZJKIT_EXTERN	        extern __attribute__((visibility ("default")))
#endif

/********颜色**********/
ZJKIT_EXTERN NSInteger const themColor;
ZJKIT_EXTERN NSInteger const backGroundColor;
ZJKIT_EXTERN NSInteger const textColor;

/********字体**********/
ZJKIT_EXTERN CGFloat const textFontSize;


/********appkey**********/
ZJKIT_EXTERN NSString * const wx_appKey;
ZJKIT_EXTERN NSString * const wx_appSecret;
ZJKIT_EXTERN NSString * const qq_appKey;
ZJKIT_EXTERN NSString * const qq_appSecret;
ZJKIT_EXTERN NSString * const wb_appKey;
ZJKIT_EXTERN NSString * const wb_appSecret;
ZJKIT_EXTERN NSString * const um_appKey;
ZJKIT_EXTERN NSString * const bd_appKey;

/********网页基址**********/
ZJKIT_EXTERN NSString * const TYKJBaseUrl;
ZJKIT_EXTERN NSString * const weatherBaseUrl;

/********userDefaultKey**********/
ZJKIT_EXTERN NSString * const udk_userName;
ZJKIT_EXTERN NSString * const udk_passWord;
ZJKIT_EXTERN NSString * const udk_isAutoLogin;
ZJKIT_EXTERN NSString * const udk_userIcon;

#ifndef TYZJGlobalConstants_h
#define TYZJGlobalConstants_h



/********宏定义**********/
#define ISAUTOLOGIN [getUserData(udk_isAutoLogin) integerValue] == 1

#endif /* TYZJGlobalConstants_h */
