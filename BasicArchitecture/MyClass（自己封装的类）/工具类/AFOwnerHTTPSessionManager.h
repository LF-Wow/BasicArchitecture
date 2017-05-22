// AFOwnerHTTPSessionManager.h
//
//  Created by 周君 on 15/8/30.
//  Copyright (c) 2015年 周君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface AFOwnerHTTPSessionManager : AFHTTPSessionManager

@property(nonatomic, strong) AFURLSessionManager *urlSessionManager;

+ (instancetype)shareManager;


/**
 GET请求

 @param baseURL 不填就默认为指定网址
 @param parameters 参数
 @param success 成功block task：任务 responseObject：得到的数据
 @param failure 失败block task：任务 error：错误信息
 */
+ (void)GET:(NSString *)baseURL Parameters:(id)parameters
           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;


/**
POST请求
 
 @param baseURL 不填就默认为指定网址
 @param parameters 参数
 @param success 成功block task：任务 responseObject：得到的数据
 @param failure 失败block task：任务 error：错误信息
 */
+ (void)POST:(NSString *)baseURL Parameters:(id)parameters
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;


/**
 上传文件

 @param baseURL 不填就默认为指定网址
 @param parameters 存放照片以外的对象
 @param block 拼接上传数据体 formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
 @param uploadProgress 进度
 @param success 成功block task：任务 responseObject：得到的数据
 @param failure 失败block task：任务 error：错误信息
 */
+ (void)upload:(NSString *)baseURL Parameters:(id)parameters
  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                   progress:(void (^)(NSProgress *))uploadProgress
                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//外面指定下载路径和文件名的下载方法
- (void)downloadFileURL:(NSString *)url
           filesavePath:(NSString *)path
               fileName:(NSString *)sourceName
               progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
      completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;


//默认指定下载路径和文件名的下载方法
- (void)downloadFileURL:(NSString *)url
               progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
      completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

//暂停当前正在下载的任务
- (void) suspendAllDownload;

//继续下载暂停过的任务
- (void) startAllDownload;

//取消掉所有的当前下载任务
- (void)cancelAllDownloads;


@end
