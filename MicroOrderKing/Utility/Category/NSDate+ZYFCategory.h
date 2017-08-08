//
//  NSDate+ZYFCategory.h
//  ZYFFramework
//
//  Created by 周逸帆 on 16/9/13.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZYFCategory)
+(NSDateFormatter *)getDataFormatter:(NSString *)dateFormatterString;
/**
 *  获取当前时间的NSDateComponents,可详细获取之后的年月日
 *
 *  @return <#return value description#>
 */
+(NSDateComponents *)getNowDateComponents;
/**
 *  获取当前nsdate的DateComponents
 *
 *  @return <#return value description#>
 */
-(NSDateComponents *)getDateComponents;



/**
 *  NSDateFormatter重新生成使用,开销巨大,单例使用可以加快时间转换速度
 *
 *  @param dateFormatterString <#dateFormatterString description#>
 *
 *  @return <#return value description#>
 */
-(NSDateFormatter *)getDataFormatter:(NSString *)dateFormatterString;


/**
 *  获取指定时间格式的时间
 *
 *  @param dateFormatterString 时间格式（yyyy-MM-dd HH:mm:ss）
 *
 *  @return 返回转换好的时间字符串
 */
-(NSString *)stringFromDate:(NSString*)dateFormatterString;
@end
