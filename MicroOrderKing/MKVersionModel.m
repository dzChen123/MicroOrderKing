//
//  MKVersionModel.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 2017/9/19.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKVersionModel.h"

@implementation MKVersionModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"updateUrl" : @"download_url",
             @"version" : @"update_id",
             @"updateSign" : @"update_log"
             };
}

@end
