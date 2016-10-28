//
//  AssignToObject.m
//  GainProperty
//
//  Created by wangze on 13-7-18.
//  Copyright (c) 2013年 wangze. All rights reserved.
//

#import "AssignToObject.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@implementation AssignToObject

//获取类的各个属性，存到数组中
+ (id)propertyKeysWithString:(NSString *)classStr

{
    unsigned int outCount, i;
    
    //获取一个类的各个成员变量存放在properties[]数组中
    objc_property_t *properties = class_copyPropertyList([NSClassFromString(classStr) class], &outCount);
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    
    free(properties);
    
    return keys;
}

//用字典为类的各个属性赋值
+ (id)reflectDataFromOtherObject:(FMResultSet *)dataSource andObjectStr:(NSString *)classStr

{
    id model = [[NSClassFromString(classStr) alloc] init];
    
    for (NSString *key in [self propertyKeysWithString:classStr])
    {
        id propertyValue = [dataSource stringForColumn:key];
        
        //该值不为NSNULL，并且也不为nil
        if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue != nil)
        {
            //为对象的各个属性赋值
            [model setValue:propertyValue forKey:key];
        }
    }
    
    return model;
}

@end
