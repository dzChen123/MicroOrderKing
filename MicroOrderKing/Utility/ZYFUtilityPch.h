//
//  ZYFUtilityPch.h
//  Trucking
//
//  Created by 周逸帆 on 16/10/7.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#ifndef ZYFUtilityPch_h
#define ZYFUtilityPch_h

#define autoSizeScaleW SCREEN_WIDTH/375.00f
#define autoSizeScaleH SCREEN_HEIGHT/667.00f

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif

#define autoSizeScaleW SCREEN_WIDTH/375.00f
#define autoSizeScaleH SCREEN_HEIGHT/667.00f
#define leftPadding 15 * autoSizeScaleW
#define rightPadding - 15 * autoSizeScaleW
#define WidthSCALEValueNoautoChange(F) (F/2)//只取和像素比例 不按长宽度调整大小
#define HeightSCALEValueNoautoChange(F) (F/2)
#define FONTSizeScale (SCREEN_WIDTH/375.00f)
#define GetTitleDefaultFont [UIFont systemFontOfSize:TITLEFONT*FONTSizeScale]
#define GetBodyDefaultFont [UIFont systemFontOfSize:BODYFONT*FONTSizeScale]
#define GetTitleDefaultFontNoScale [UIFont systemFontOfSize:TITLEFONT]
#define GetBodyDefaultFontNoScale [UIFont systemFontOfSize:BODYFONT]
//标题字体 17
#define DefaultTitleFontSizt     13
//正文字体 15
#define DefaultTextFontSizt     12

//设置字体
#define FONT(I)     [UIFont systemFontOfSize:I*FONTSizeScale]
//设置字体
#define FONTBOLD(I)     [UIFont boldSystemFontOfSize:I*FONTSizeScale]

#define DefaultTitleFont    [UIFont systemFontOfSize:DefaultTitleFontSizt*FONTSizeScale]

#define DefaultTextFont    [UIFont systemFontOfSize:DefaultTextFontSizt*FONTSizeScale]

#define GetAppDelegate ((AppDelegate*)([UIApplication sharedApplication].delegate))

//设置字体
#define FONTNoScale(I)     [UIFont systemFontOfSize:I]
//设置字体
#define FONTBOLDNoScale(I)     [UIFont boldSystemFontOfSize:I]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define DefaultSCREEN_SCALE  2
#define SCREEN_SCALE  ([[UIScreen mainScreen] scale])

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define WeakObj(o) __weak typeof(o) o##Weak = o;

///通用配置
#define VIEWBACKGRAY [UIColor hexStringToColor:@"#F3F4F6"]//view背景灰色
#define TabBlue [UIColor hexStringToColor:@"#0B7BF8"]

#define topViewBackColor [UIColor hexStringToColor:@"#3B3C4D"]//
#define rectBorderColor [UIColor hexStringToColor:@"#EBEBEB"]
#define wordThreeColor [UIColor hexStringToColor:@"#333333"]
#define wordSixColor [UIColor hexStringToColor:@"#666666"]
#define wordFourDColor [UIColor hexStringToColor:@"#4d4d4d"]
#define lineViewColor [UIColor hexStringToColor:@"#f1f1f1"]
#define redDotColor [UIColor hexStringToColor:@"#D7263D"]
#define wordNineColor [UIColor hexStringToColor:@"#999999"]


//项目配置
#define themeGreen [UIColor hexStringToColor:@"#2AC26F"]
#define customWhite [UIColor whiteColor]

#define topBackImageName  @"navBack"

#define DEFINE_SINGLETON_INTERFACE(className) \
+ (className *)shared##className;


#define DEFINE_SINGLETON_IMPLEMENTATION(className) \
static className *shared##className = nil; \
static dispatch_once_t pred; \
\
+ (className *)shared##className { \
dispatch_once(&pred, ^{ \
shared##className = [[super allocWithZone:NULL] init]; \
if ([shared##className respondsToSelector:@selector(setUp)]) {\
[shared##className setUp];\
}\
}); \
return shared##className; \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
return [self shared##className];\
} \
\
- (id)copyWithZone:(NSZone *)zone { \
return self; \
}

#endif /* ZYFUtilityPch_h */
