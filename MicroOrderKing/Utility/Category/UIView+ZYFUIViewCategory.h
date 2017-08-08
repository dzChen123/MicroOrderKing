//
//  UIView+ZYFUIViewCategory.h
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/13.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYFUIViewCategory)
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;

- (UIViewController *)parentController;
-(void)addTapEventWith:(id)Target action:(SEL)action;
-(UIImage *)convertViewToImage;
/**
 *  绘制直角梯形
 *
 *  @param view  <#view description#>
 *  @param color <#color description#>
 */
-(void)drawTrapezoidBackViewWithViewBackColor:(UIColor *) color;
-(void)drawDownTrapezoidBackViewWithViewBackColor:(UIColor *) color;

+ (void)drawTrapezoidBackViewWithView:(UIView *)view BackColor:(UIColor *) color;
/**
 *  绘制倒转的直角梯形
 *
 *  @param view  <#view description#>
 *  @param color <#color description#>
 */

+(UIView *)getRadiusView:(NSInteger)radius;
+ (void)drawDownTrapezoidBackViewWithView:(UIView *)view BackColor:(UIColor *)color;



@end
