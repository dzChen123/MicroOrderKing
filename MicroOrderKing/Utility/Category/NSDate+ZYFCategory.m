//
//  NSDate+ZYFCategory.m
//  ZYFFramework
//
//  Created by 周逸帆 on 16/9/13.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "NSDate+ZYFCategory.h"
static NSDateFormatter *dataFormatter;
@implementation NSDate (ZYFCategory)

/**
 *  获取当前时间的NSDateComponents,可详细获取之后的年月日
 *
 *  @return <#return value description#>
 */
+(NSDateComponents *)getNowDateComponents
{
    NSDate *dateNow;
    
    dateNow=[NSDate date];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    comps = [calendar components:unitFlags fromDate:dateNow];
    return comps;
}

-(NSDateComponents *)getDateComponents
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:self];
    return comps;
}



/**
 *  NSDateFormatter重新生成使用,开销巨大,单例使用可以加快时间转换速度
 *
 *  @param dateFormatterString <#dateFormatterString description#>
 *
 *  @return <#return value description#>
 */
+(NSDateFormatter *)getDataFormatter:(NSString *)dateFormatterString
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataFormatter = [[NSDateFormatter alloc] init];
        [dataFormatter setLocale:[NSLocale currentLocale] ];
    });
    if(dateFormatterString!=NULL&&dateFormatterString!=nil&&![dateFormatterString isEqualToString:@""])
    {
        [dataFormatter setDateFormat: dateFormatterString];
    }
    return dataFormatter;
}

/**
 *  NSDateFormatter重新生成使用,开销巨大,单例使用可以加快时间转换速度
 *
 *  @param dateFormatterString <#dateFormatterString description#>
 *
 *  @return <#return value description#>
 */
-(NSDateFormatter *)getDataFormatter:(NSString *)dateFormatterString
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataFormatter = [[NSDateFormatter alloc] init];
        [dataFormatter setLocale:[NSLocale currentLocale] ];
    });
    if(dateFormatterString!=NULL&&dateFormatterString!=nil&&![dateFormatterString isEqualToString:@""])
    {
        [dataFormatter setDateFormat: dateFormatterString];
    }
    return dataFormatter;
}


/**
 *  获取指定时间格式的时间
 *
 *  @param date                需要转换的时间
 *  @param dateFormatterString 时间格式（yyyy-MM-dd HH:mm:ss）
 *
 *  @return 返回转换好的时间字符串
 */
-(NSString *)stringFromDate:(NSString*)dateFormatterString
{
    NSDateFormatter *dateFormatter = [self getDataFormatter:dateFormatterString];
    NSString *destDateString = [dateFormatter stringFromDate:self];
    return destDateString;
}




@end
