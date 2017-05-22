//
//  ZJGetLocation.h
//  Location
//
//  Created by apple on 2017/5/5.
//  Copyright © 2017年 zj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^getCityBlock)(NSString *location);
@interface ZJGetLocation : NSObject

/** block*/
@property (nonatomic, copy)getCityBlock block;
- (void)startUpLocation;

@end
