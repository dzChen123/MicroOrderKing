//
//  AFNetworkingHelper.h
//  Trucking
//
//  Created by 周逸帆 on 16/10/7.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSErrorHelper.h"
#import <AFNetworking/AFNetworking.h>
typedef NS_ENUM(NSInteger, NetType) {
    NONet,
    WiFiNet,
    OtherNet,
};

@interface AFNetworkingHelper : NSObject

@property(nonatomic, assign) NSInteger netType;

@property(nonatomic, strong) NSString *netTypeString;

+ (NSString *)UrlOption:(NSString *)url;

+ (AFNetworkingHelper *)sharedAFNetworkingHelper;

- (void)startMonitoring;

- (void)startMonitoringNet;

+ (void)httpPost:(NSString *)postUrl params:(NSMutableDictionary *)params success:(void (^)(id json))success fail:(void (^)(NSError *error))fail other:(void (^)(id json))other;

+ (void)httpPost:(NSString *)postUrl params:(NSMutableDictionary *)params success:(void (^)(id json))success modelClass:(Class)class fail:(void (^)(NSError *error))fail other:(void (^)(id json))other;

+ (void)httpGet:(NSString *)getUrl params:(NSMutableDictionary *)params success:(void (^)(id json))success fail:(void (^)(NSError *error))fail other:(void (^)(id json))other;

+ (void)httpGet:(NSString *)getUrl params:(NSMutableDictionary *)params success:(void (^)(id))success modelClass:(Class)class fail:(void (^)(NSError *))fail other:(void (^)(id))other;

+ (void)handleErrorResultWithOperation:(NSURLSessionDataTask *)operation error:(NSError *)error fail:(void (^)(NSError *error))fail;

+ (void)httpDelete:(NSString *)deleteUrl params:(NSMutableDictionary *)params success:(void (^)(id json))success fail:(void (^)(NSError *error))fail other:(void (^)(id json))other;

+ (void)handleResultWithOperation:(NSURLSessionDataTask *)operation responseObject:(id)responseObject success:(void (^)(id json))success other:(void (^)(id json))other;

+ (void)handleResultWithOperation:(NSURLSessionDataTask *)operation responseObject:(id)responseObject success:(void (^)(id json))success class:(Class)class other:(void (^)(id json))other;

+ (void)httpPut:(NSString *)putUrl params:(NSMutableDictionary *)params success:(void (^)(id json))success fail:(void (^)(NSError *error))fail other:(void (^)(id json))other;

+(NSMutableDictionary *)paramsOption:(NSMutableDictionary *)params URL:(NSString *)url;

+(void)JsonSerializerOption:(AFJSONRequestSerializer *)requestSerializer;

@end
