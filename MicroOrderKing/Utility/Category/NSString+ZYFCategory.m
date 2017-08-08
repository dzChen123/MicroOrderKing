//
//  NSString+ZYFCategory.m
//  ZYFFramework
//
//  Created by 周逸帆 on 16/9/13.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "NSString+ZYFCategory.h"
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/NSDecimalNumber.h>
#import "NSDate+ZYFCategory.h"
@implementation NSString (ZYFCategory)

/**
 *  MD5 加密
 *
 *  @return 加密后字符串
 */
- (NSString *)md5String
{
    if(self == nil || [self length] == 0) return nil;
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

/**
 *  金额格式化,此方法为string扩展方法，可直接 [字符串参数 strmethodComma]调用
 *
 *  @return <#return value description#>
 */
-(NSString *)strmethodComma
{
    NSString *string=self;
    NSString *sign = nil;
    if ([string hasPrefix:@"-"]||[string hasPrefix:@"+"]) {
        sign = [string substringToIndex:1];
        string = [string substringFromIndex:1];
    }
    
    NSString *pointLast = [string substringFromIndex:[string length]-3];
    NSString *pointFront = [string substringToIndex:[string length]-3];
    
    int commaNum = ([pointFront length]-1)/3;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < commaNum+1; i++) {
        int index = [pointFront length] - (i+1)*3;
        int leng = 3;
        if(index < 0)
        {
            leng = 3+index;
            index = 0;
            
        }
        NSRange range = {index,leng};
        NSString *stq = [pointFront substringWithRange:range];
        [arr addObject:stq];
    }
    NSMutableArray *arr2 = [NSMutableArray array];
    for (int i = [arr count]-1; i>=0; i--) {
        
        [arr2 addObject:arr[i]];
    }
    NSString *commaString = [[arr2 componentsJoinedByString:@","] stringByAppendingString:pointLast];
    if (sign) {
        commaString = [sign stringByAppendingString:commaString];
    }
    return commaString;
}


-(NSDate *)changeToDate:(NSString *)dateFormatterString
{
    NSDateFormatter *dateFormatter = [NSDate getDataFormatter:dateFormatterString];
    //    [dateFormatter setLocalizedDateFormatFromTemplate:dateFormatterString];
    //    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDate *destDate= [dateFormatter dateFromString:self];
    return destDate;
}


-(NSString *)changeToDateString:(NSString *)dateFormatterString     oldDateFormatterString:(NSString *)oldDateFormatterString
{
    NSDateFormatter *oldDateFormatter = [NSDate getDataFormatter:oldDateFormatterString];
    NSDate *destDate= [oldDateFormatter dateFromString:self];
    NSDateFormatter *dateFormatter = [NSDate getDataFormatter:dateFormatterString];
    NSString *destDateString = [dateFormatter stringFromDate:destDate];
    return destDateString;
}



@end
