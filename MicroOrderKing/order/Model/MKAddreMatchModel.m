//
//  MKAddreMatchModel.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/7.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAddreMatchModel.h"

@implementation MKAddreMatchModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"matchId" : @"id",
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"address" : @"MKAddreMatchItemModel"
             };
}

@end

@implementation MKAddreMatchItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"itemId" : @"id",
             @"memberId" : @"member_id",
             };
}

@end
