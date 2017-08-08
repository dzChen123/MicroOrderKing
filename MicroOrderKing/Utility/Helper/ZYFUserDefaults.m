//
//  ZYFUserDefaults.m
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/19.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "ZYFUserDefaults.h"
static NSUserDefaults *userDefaults;
@implementation ZYFUserDefaults


+(void)setObject:(id )object  key:(NSString *)key
{
    [[self UserDefaults] setObject:object forKey:key];
}

+(void)setValue:(id)Value  key:(NSString *)key
{
    [userDefaults setValue:Value forKey:key];
}

+(void)setBool:(BOOL )boolValue  key:(NSString *)key
{

    [[self UserDefaults] setBool:boolValue forKey:key];
}
+(void)setInteger:(NSInteger)Integer  key:(NSString *)key
{
    [[self UserDefaults] setInteger:Integer forKey:key];
}
+(void)setURL:(NSURL * )URL  key:(NSString *)key
{
    [[self UserDefaults] setURL:URL forKey:key];
}
+(void)setFloat:(float )Float  key:(NSString *)key
{
    [[self UserDefaults] setFloat:Float forKey:key];
}
+(void)setDouble:(double )Double  key:(NSString *)key
{
    [[self UserDefaults] setDouble:Double forKey:key];
}

+(id)objectForKey:(NSString *)key
{

    return [[self UserDefaults] objectForKey:key];
}

+(NSInteger)integerForKey:(NSString *)key
{
    return [[self UserDefaults] integerForKey:key];
}

+(BOOL)boolForKey:(NSString *)key
{
    return [[self UserDefaults] boolForKey:key];
}

+(float)floatForKey:(NSString *)key
{
    return [[self UserDefaults] floatForKey:key];
}

+(NSURL *)URLForKey:(NSString *)key
{
    return [[self UserDefaults] URLForKey:key];
}

+(id)valueForKey:(NSString *)key
{
    return [[self UserDefaults] valueForKey:key];
}

+(void)removeObjectForKey:(NSString*)key
{

    [[self UserDefaults] removeObjectForKey:key];
}







+(NSUserDefaults *)UserDefaults
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userDefaults = [NSUserDefaults standardUserDefaults];
       
    });
    return userDefaults;
}


@end

