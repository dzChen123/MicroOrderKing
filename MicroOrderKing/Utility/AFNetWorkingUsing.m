//
//  AFNetWorkingUsing.m
//  Trucking
//
//  Created by 陈徳柱 on 16/11/16.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "AFNetWorkingUsing.h"

#import "MKLoginViewController.h"
#import "BaseNavigationController.h"

#import "ZYFDeviceHelper.h"
#import "NSString+ZYFCategory.h"
#import "ZYFUtilityPch.h"
#import "BaseTipHud.h"

NSString *const TRnetWorkUtilsDomain = @"http://AFNetWorkUtils";

NSString *const TRoperationInfoKey = @"operationInfoKey";

@implementation AFNetWorkingUsing

+ (NSString *)UrlOption:(NSString *)url{
    
    NSString *resultUrl = [url isEqualToString:@"user/verification_code/api_send"] ? messagePath : mainPath;
    return  [resultUrl stringByAppendingString:url];
}

//传參时候的设定

+ (NSMutableDictionary *)paramsOption:(NSMutableDictionary *)params URL:(NSString *)url{
    
//    [params setObject:tokenValue forKey:@"xx-token"];
//    [params setObject:@"iphone" forKey:@"xx-device-type"];
    
    NSLog(@"%@发起数据请求  请求数据:%@",url,params);
    
    return params;
}

+ (void)JsonSerializerOption:(AFJSONRequestSerializer *)requestSerializer {
    NSString *tokenValue;
    if ([ZYFUserDefaults boolForKey:@"loginFlag"]) {
        tokenValue = [ZYFUserDefaults objectForKey:@"token"];
    }else{
        tokenValue = @"";
    }
    [requestSerializer setValue:[NSString stringWithFormat:@"%@",tokenValue] forHTTPHeaderField:@"xx-token"];
    [requestSerializer setValue:@"iphone" forHTTPHeaderField:@"xx-device-type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
}

//回调时候的处理

+ (void)handleResultWithOperation:(NSURLSessionDataTask *)operation responseObject:(id)responseObject success:(void (^)(id json))success other:(void (^)(id json))other {

    NSDictionary *dict;
    NSError *error;
    
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
    }
    dict = (NSDictionary *)responseObject;
    NSLog(@"%@",dict);
    
    NSInteger type = [[dict objectForKey:@"code"] integerValue];
    
    if (type == 1) {
        success((NSDictionary *)dict);
    }
    else if(type == 10001) {
        [ZYFUserDefaults setBool:NO key:@"loginFlag"];
        NSString *key = @"transition";
        CATransition *transition=[CATransition animation];
        //动画时长
        transition.duration=0.6;
        //动画类型wodou
        transition.type=kCATransitionFade;
        transition.removedOnCompletion = YES;
        MKLoginViewController *vc =[[MKLoginViewController alloc] init];
        [UIApplication sharedApplication].delegate.window.rootViewController = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [[UIApplication sharedApplication].delegate.window.layer addAnimation:transition forKey:key];
    }
    else {
//        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//        userInfo[TRoperationInfoKey] = operation;
//        //BOOL isError = [status isEqualToString:@"error"];
//        NSString * errorInfo = [responseObject objectForKey:@"msg"];
//        userInfo[customErrorInfoKey] = errorInfo;
//        NSError * error = [NSErrorHelper createErrorWithUserInfo:userInfo domain:TRoperationInfoKey];
//        other(error);
        other((NSDictionary *)dict);

    }
    
}


@end
