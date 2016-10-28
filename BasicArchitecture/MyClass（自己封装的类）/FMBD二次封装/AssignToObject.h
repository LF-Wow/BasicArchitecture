//
//  AssignToObject.h
//  GainProperty
//
//  Created by wangze on 13-7-18.
//  Copyright (c) 2013年 wangze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface AssignToObject : NSObject

+ (id)propertyKeysWithString:(NSString *)classStr;
+ (id)reflectDataFromOtherObject:(id)dataSource andObjectStr:(NSString *)classStr;

@end
