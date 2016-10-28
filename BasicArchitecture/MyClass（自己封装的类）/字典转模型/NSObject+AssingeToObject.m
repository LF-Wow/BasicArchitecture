//
//  DictionaryToObject.m
//  JSON解析
//
//  Created by 周君 on 16/9/3.
//  Copyright © 2016年 周君. All rights reserved.
//

#import "NSObject+AssingeToObject.h"
#import <objc/runtime.h>

@implementation NSObject(AssingeToObject)

+ (NSMutableArray *)objectForArr:(NSArray *)classArr
{
    NSMutableArray *objectArr = [NSMutableArray array];
    
    unsigned int propertyCount = 0;
    
    NSString *className = [NSString stringWithFormat:@"%s", object_getClassName(self)];
    
    Class class = NSClassFromString(className);
    
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
    
    for (int i = 0 ; i < classArr.count; ++i)
    {
        
        id dict = classArr[i];
        
        if ([dict isKindOfClass:[NSDictionary class]] )
        {
            
            id model = [[class alloc] init];
            
            for (int j =0; j < propertyCount; ++j)
            {
                NSString *propertyName = [NSString stringWithCString:property_getName(properties[j]) encoding:NSUTF8StringEncoding] ;
                
                id value = dict[propertyName];
                
                if (!value || [value isKindOfClass:[NSNull class]])
                {
                    
                    continue;
                }
                
                [model setValue:value forKey:propertyName];
            }
            
            [objectArr addObject:model];
        }
    }
    
    return objectArr;
}

@end
