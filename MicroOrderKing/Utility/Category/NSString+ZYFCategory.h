//
//  NSString+ZYFCategory.h
//  ZYFFramework
//
//  Created by 周逸帆 on 16/9/13.
//  Copyright © 2016年 周逸帆. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (ZYFCategory)
- (NSString *)md5String;
-(NSString *)strmethodComma;

-(NSDate *)changeToDate:(NSString *)dateFormatterString;

-(NSString *)changeToDateString:(NSString *)dateFormatterString     oldDateFormatterString:(NSString *)oldDateFormatterString;
@end
