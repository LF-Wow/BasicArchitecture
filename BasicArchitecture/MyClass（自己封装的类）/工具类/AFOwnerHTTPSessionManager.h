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

//get请求
+ (void)getParameters:(id)parameters
           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

//post请求
+ (void)postParameters:(id)parameters
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

//上传文件
+ (void)uploadFileParameters:(id)parameters
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
