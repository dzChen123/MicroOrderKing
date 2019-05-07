//
//  AFNetworkingHelper.m
//  Trucking
//
//  Created by 周逸帆 on 16/10/7.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "AFNetworkingHelper.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <MJExtension/MJExtension.h>
#import "ZYFUtilityPch.h"
NSString *const netWorkUtilsDomain = @"http://AFNetWorkUtils";

NSString *const operationInfoKey = @"operationInfoKey";


@implementation AFNetworkingHelper

DEFINE_SINGLETON_IMPLEMENTATION(AFNetworkingHelper)

- (void)setUp {
    self.netType = WiFiNet;
    self.netTypeString = @"WIFI";
}

+ (NSString *)UrlOption:(NSString *)url{
    
    return url;
}

/**
 * 创建网络请求管理类单例对象
 */
+ (AFHTTPSessionManager *)sharedHTTPOperationManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer new];
        manager.requestSerializer.timeoutInterval = 20.f;//超时时间为20s
        NSMutableSet *acceptableContentTypes = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
        [acceptableContentTypes addObject:@"text/plain"];
        [acceptableContentTypes addObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    });
    return manager;
}

- (void)startMonitoring {
    [self startMonitoringNet];
    
}

- (void)startMonitoringNet {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    WS(ws)
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                ws.netType = WiFiNet;
                self.netType = WiFiNet;
                self.netTypeString = @"WIFI";
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                ws.netType = OtherNet;
                ws.netTypeString = @"2G/3G/4G";
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                ws.netType = NONet;
                ws.netTypeString = @"网络已断开";
                [[SDWebImageManager sharedManager] cancelAll];
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                ws.netType = NONet;
                ws.netTypeString = @"其他情况";
                break;
            default:
                break;
        }
    }];
}


+ (void)httpPost:(NSString *)postUrl params:(NSMutableDictionary *)params success:(void (^)(id json))success fail:(void (^)(NSError *error))fail other:(void (^)(id json))other {
    postUrl = [self UrlOption:postUrl];
    params = [self paramsOption:params URL:postUrl];
    AFHTTPSessionManager *manager = [self sharedHTTPOperationManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self JsonSerializerOption:(AFJSONRequestSerializer *)manager.requestSerializer];
    NSURLSessionDataTask *operation = [manager POST:postUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResultWithOperation:operation responseObject:responseObject success:success other:other];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleErrorResultWithOperation:operation error:error fail:fail];
    }];

}

+ (void)httpPost:(NSString *)postUrl params:(NSMutableDictionary *)params success:(void (^)(id json))success modelClass:(Class)class fail:(void (^)(NSError *error))fail other:(void (^)(id json))other {
    postUrl = [self UrlOption:postUrl];
    params = [self paramsOption:params URL:postUrl];
    AFHTTPSessionManager *manager = [self sharedHTTPOperationManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self JsonSerializerOption:(AFJSONRequestSerializer *)manager.requestSerializer];
    NSURLSessionDataTask *operation = [manager POST:postUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResultWithOperation:operation responseObject:responseObject success:success class:class other:other];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleErrorResultWithOperation:operation error:error fail:fail];
    }];
}

+ (void)httpGet:(NSString *)getUrl params:(NSMutableDictionary *)params success:(void (^)(id json))success fail:(void (^)(NSError *error))fail other:(void (^)(id json))other {
    getUrl = [self UrlOption:getUrl];
    params = [self paramsOption:params URL:getUrl];
    AFHTTPSessionManager *manager = [self sharedHTTPOperationManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self JsonSerializerOption:(AFJSONRequestSerializer *)manager.requestSerializer];
    NSURLSessionDataTask *operation = [manager GET:getUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResultWithOperation:operation responseObject:responseObject success:success other:other];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleErrorResultWithOperation:operation error:error fail:fail];
    }];
}

+ (void)httpGet:(NSString *)getUrl params:(NSMutableDictionary *)params success:(void (^)(id json))success modelClass:(Class)class fail:(void (^)(NSError *))fail other:(void (^)(id))other{
    getUrl = [self UrlOption:getUrl];
    params = [self paramsOption:params URL:getUrl];
    AFHTTPSessionManager *manager = [self sharedHTTPOperationManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self JsonSerializerOption:(AFJSONRequestSerializer *)manager.requestSerializer];
    NSURLSessionDataTask *operation = [manager GET:getUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResultWithOperation:operation responseObject:responseObject success:success class:class other:other];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleErrorResultWithOperation:operation error:error fail:fail];
    }];
}

+ (void)httpDelete:(NSString *)deleteUrl params:(NSMutableDictionary *)params success:(void (^)(id json))success fail:(void (^)(NSError *error))fail other:(void (^)(id json))other {
    deleteUrl = [self UrlOption:deleteUrl];
    params = [self paramsOption:params URL:deleteUrl];
    AFHTTPSessionManager *manager = [self sharedHTTPOperationManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self JsonSerializerOption:(AFJSONRequestSerializer *)manager.requestSerializer];
    NSURLSessionDataTask *operation = [manager DELETE:deleteUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResultWithOperation:operation responseObject:responseObject success:success other:other];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleErrorResultWithOperation:operation error:error fail:fail];
    }];
}

+ (void)httpPut:(NSString *)putUrl params:(NSMutableDictionary *)params success:(void (^)(id json))success fail:(void (^)(NSError *error))fail other:(void (^)(id json))other {
    putUrl = [self UrlOption:putUrl];
    params = [self paramsOption:params URL:putUrl];
    AFHTTPSessionManager *manager = [self sharedHTTPOperationManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self JsonSerializerOption:(AFJSONRequestSerializer *)manager.requestSerializer];
    NSURLSessionDataTask *operation = [manager PUT:putUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResultWithOperation:operation responseObject:responseObject success:success other:other];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleErrorResultWithOperation:operation error:error fail:fail];
    }];
}


+ (void)handleErrorResultWithOperation:(NSURLSessionDataTask *)operation error:(NSError *)error fail:(void (^)(NSError *error))fail{
    NSMutableDictionary *userInfo = [error.userInfo mutableCopy] ? : [NSMutableDictionary dictionary];
    userInfo[operationInfoKey] = operation;
    userInfo[customErrorInfoKey] = [NSErrorHelper handleErrorMessage:error];
    fail(error);
}

+ (void)handleResultWithOperation:(NSURLSessionDataTask *)operation responseObject:(id)responseObject success:(void (^)(id json))success other:(void (^)(id json))other{
    
    //示例（测试接口）
    NSInteger count = [[responseObject objectForKey:@"count"] integerValue];
    if(!count) {
        success(responseObject);
    }
    
    //统一格式接口
    NSString *status = [responseObject objectForKey:@"status"];
    
    //正确返回
    if([status isEqualToString:@"ok"]){
        success(responseObject);
    }
    else{       //正确返回带有错误信息
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[operationInfoKey] = operation;
        BOOL isError = [status isEqualToString:@"error"];
        NSString *errorInfo = isError ? [responseObject objectForKey:@"error"] : @"请求没有得到处理";
        userInfo[customErrorInfoKey] = errorInfo;
        NSError *error = [NSErrorHelper createErrorWithUserInfo:userInfo domain:netWorkUtilsDomain];
        other(error);
    }
}

+ (void)handleResultWithOperation:(NSURLSessionDataTask *)operation responseObject:(id)responseObject success:(void (^)(id json))success class:(Class)class other:(void (^)(id json))other{
    
    //示例（测试接口）
    NSInteger count = [[responseObject objectForKey:@"count"] integerValue];
    if(!count) {
        success(responseObject);
    }
    
    //统一格式接口
    NSString *status = [responseObject objectForKey:@"status"];
    
    //正确返回
    if([status isEqualToString:@"ok"]){
        success([class mj_objectWithKeyValues:responseObject]);
    }
    else{       //正确返回带有错误信息
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[operationInfoKey] = operation;
        BOOL isError = [status isEqualToString:@"error"];
        NSString *errorInfo = isError ? [responseObject objectForKey:@"error"] : @"请求没有得到处理";
        userInfo[customErrorInfoKey] = errorInfo;
        NSError *error = [NSErrorHelper createErrorWithUserInfo:userInfo domain:netWorkUtilsDomain];
        other(error);
    }
}


+(void)JsonSerializerOption:(AFJSONRequestSerializer *)requestSerializer {

}


+(NSMutableDictionary *)paramsOption:(NSMutableDictionary *)params URL:(NSString *)url
{
    return params;
}


@end
