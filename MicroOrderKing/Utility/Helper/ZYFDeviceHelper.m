//
//  ZYFDeviceHelper.m
//  ZYFCommon
//
//  Created by zyf on 15/9/15.
//  Copyright (c) 2015年 Sedion. All rights reserved.
//

#import "ZYFDeviceHelper.h"
#import "NSString+ZYFCategory.h"
@implementation ZYFDeviceHelper
/**
 *  获取 MD5转码的设备uuid
 *
 *  @return <#return value description#>
 */
+(NSString*) getuuid
{
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    if([userdefault objectForKey:@"uuid"])
    {
        return [userdefault objectForKey:@"uuid"];
    }
    else
    {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result =[(NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString)) md5String] ;
        CFRelease(puuid);
        CFRelease(uuidString);
        [userdefault setObject:result forKey:@"uuid"];
        return  result;
    }
}

@end
