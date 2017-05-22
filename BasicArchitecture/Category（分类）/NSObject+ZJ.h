//
//  NSObject+ZJ.h
//  TYZJ
//
//  Created by apple on 2017/5/6.
//  Copyright © 2017年 周君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZJ)
/**
 *  自动生成属性列表
 *
 *  @param dict JSON字典/模型字典
 */
+(void)printPropertyWithDict:(NSDictionary *)dict;

@end
