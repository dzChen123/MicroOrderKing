//
//  MKPersonModel.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/1.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKPersonModel.h"

@implementation MKPersonModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"phoneNum" : @"mobile",
             @"name" : @"user_nickname",
             @"timeStr" : @"expire_time",
             @"isTry" : @"is_try",
             @"isHide" : @"is_hide"
             };
}

@end

@implementation MKPersonHttpModel

@end
