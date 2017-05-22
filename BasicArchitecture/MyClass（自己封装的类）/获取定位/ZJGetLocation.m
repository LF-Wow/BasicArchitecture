//
//  ZJGetLocation.m
//  Location
//
//  Created by apple on 2017/5/5.
//  Copyright © 2017年 zj. All rights reserved.
//
/*
 *  使用定位需要在plist文件中加入以下字段
 *  <key>NSLocationWhenInUseUsageDescription</key>
 *  <string>when</string>
 *  <key>NSLocationAlwaysUsageDescription</key>
 *  <string>always</string>
 */


#import "ZJGetLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface ZJGetLocation ()<CLLocationManagerDelegate>

/** 定位管理*/
@property (nonatomic, strong)CLLocationManager *manager;
/** 初始化地理编码*/
@property (nonatomic, strong)CLGeocoder *geocoder;

@end
@implementation ZJGetLocation

- (CLLocationManager *)manager
{
    if(!_manager)
    {
        _manager = [[CLLocationManager alloc] init];
        //设置提醒用户使用定位，ios8以后要执行一个
        [_manager requestWhenInUseAuthorization];
//        [_manager requestAlwaysAuthorization];
        
        _manager.delegate = self;
        //设置定位精确度
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置过滤器为无
        _manager.distanceFilter = kCLDistanceFilterNone;
    }
    return _manager;
}

- (CLGeocoder *)geocoder
{
    if(!_geocoder)
    {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

#pragma mark - 代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    CLLocation *location = locations.lastObject;
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        if (placemarks.count > 0)
        {
            CLPlacemark *placemark = placemarks[0];
            
            
            
            NSString *city = placemark.locality;
            if (!city)
            {
                city = placemark.administrativeArea;
            }
            self.block(city);
            [manager stopUpdatingLocation];
        }
        else if (error == nil && [placemarks count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
        
        
    }];
    
}

- (void)startUpLocation
{
    [self.manager startUpdatingLocation];
}


@end
