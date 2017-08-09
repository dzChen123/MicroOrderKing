//
//  MKMemberBaseModel.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/4.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKMemberBaseModel.h"

@implementation MKMemberBaseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"memberId" : @"id",
             @"phoneNum" : @"mobile"
             };
}

@end

@implementation MKMemAddreModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ownerId" : @"user_id",
             @"addreId" : @"id",
             @"memberId" : @"member_id"
             };
}

@end

@implementation MKMemOwnerModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ownerId" : @"id",
             @"ownerName" : @"user_nickname"
             };
}

@end

@implementation MKMemberDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[super mj_replacedKeyFromPropertyName]];
    [dic addEntriesFromDictionary:@{
                                    @"userId" : @"user_id",
                                    @"orderCount" : @"order_count",
                                    @"lastTime" : @"last_time",
                                    @"owner" : @"user"
                                    }];
    
    return (NSDictionary *)dic;
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"address" : @"MKMemAddreModel"
             };
}

@end

@implementation MKTradesModel

@end

@implementation MKMemberTradesInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"sumCount" : @"sum_count"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"data" : @"MKOrderCellModel"
             };
}

@end
