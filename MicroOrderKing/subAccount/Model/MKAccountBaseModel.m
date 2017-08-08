//
//  MKAccountBaseModel.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAccountBaseModel.h"

@implementation MKAccountBaseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"accountId" : @"id",
             @"name" : @"user_nickname",
             @"phoneNum" : @"mobile",
             @"conditionType" : @"user_status",
             };
}

@end

@implementation MKAccountHttpBaseModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
                @"data" : @"MKAccountBaseModel"
             };
}

@end

@implementation MKAccountDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[super mj_replacedKeyFromPropertyName]];
    [dic addEntriesFromDictionary:@{
                                    @"timeStr" : @"create_time",
                                    @"memberNum" : @"member_count",
                                    @"orderNum" : @"order_count"
                                    }];

    return (NSDictionary *)dic;
}

@end

@implementation MKAccountHttpDetailModel

@end
