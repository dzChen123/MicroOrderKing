//
//  ZYFUserDefaults.h
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/19.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYFUserDefaults : NSObject
+(void)setObject:(id )object  key:(NSString *)key;
+(void)setValue:(id)Value  key:(NSString *)key;
+(void)setBool:(BOOL )boolValue  key:(NSString *)key;
+(void)setInteger:(NSInteger)Integer  key:(NSString *)key;
+(void)setURL:(NSURL * )URL  key:(NSString *)key;
+(void)setFloat:(float )Float  key:(NSString *)key;
+(void)setDouble:(double )Double  key:(NSString *)key;
+(id)objectForKey:(NSString *)key;
+(NSInteger)integerForKey:(NSString *)key;
+(BOOL)boolForKey:(NSString *)key;
+(float)floatForKey:(NSString *)key;
+(NSURL *)URLForKey:(NSString *)key;
+(id)valueForKey:(NSString *)key;
+(void)removeObjectForKey:(NSString*)key;
@end
