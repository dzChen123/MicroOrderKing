//
//  UIView+ZYFUIViewCategory.m
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/13.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "UIView+ZYFUIViewCategory.h"

@implementation UIView (ZYFUIViewCategory)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame= frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)alignHorizontal
{
    self.x = (self.superview.width - self.width) * 0.5;
}

- (void)alignVertical
{
    self.y = (self.superview.height - self.height) *0.5;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    
    if (borderWidth < 0) {
        return;
    }
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (BOOL)isShowOnWindow
{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //相对于父控件转换之后的rect
    CGRect newRect = [keyWindow convertRect:self.frame fromView:self.superview];
    //主窗口的bounds
    CGRect winBounds = keyWindow.bounds;
    //判断两个坐标系是否有交汇的地方，返回bool值
    BOOL isIntersects =  CGRectIntersectsRect(newRect, winBounds);
    if (self.hidden != YES && self.alpha >0.01 && self.window == keyWindow && isIntersects) {
        return YES;
    }else{
        return NO;
    }
}

- (CGFloat)borderWidth
{
    return self.borderWidth;
}

- (UIColor *)borderColor
{
    return self.borderColor;
    
}

- (CGFloat)cornerRadius
{
    return self.cornerRadius;
}

- (UIViewController *)parentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}


-(void)addTapEventWith:(id)Target action:(SEL)action
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:Target action:action];
    [self addGestureRecognizer:tap];
}


-(UIImage *)convertViewToImage

{
    
    UIGraphicsBeginImageContext(self.bounds.size);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


-(void)drawTrapezoidBackViewWithViewBackColor:(UIColor *) color
{
    CGSize finalSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    CGFloat layerHeight = finalSize.height;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(0, finalSize.height - layerHeight)];
    [bezier addLineToPoint:CGPointMake(0, finalSize.height-1)];
    [bezier addLineToPoint:CGPointMake(finalSize.width, finalSize.height - 1)];
    [bezier addLineToPoint:CGPointMake(finalSize.width-7, finalSize.height - layerHeight)];
    [bezier addLineToPoint:CGPointMake(0,0)];
    layer.path = bezier.CGPath;
    layer.fillColor = color.CGColor;
    [self.layer addSublayer:layer];
}


-(void)drawDownTrapezoidBackViewWithViewBackColor:(UIColor *) color
{
    CGSize finalSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    CGFloat layerHeight = finalSize.height;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(0, finalSize.height - layerHeight)];
    [bezier addLineToPoint:CGPointMake(0, finalSize.height-1)];
    [bezier addLineToPoint:CGPointMake(finalSize.width*0.7, finalSize.height - 1)];
    [bezier addLineToPoint:CGPointMake(finalSize.width,finalSize.height - layerHeight )];
    [bezier addLineToPoint:CGPointMake(0,0)];
    layer.path = bezier.CGPath;
    layer.fillColor = color.CGColor;
    [self.layer addSublayer:layer];
}



+ (void)drawTrapezoidBackViewWithView:(UIView *)view BackColor:(UIColor *) color
{
    CGSize finalSize = CGSizeMake(CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    CGFloat layerHeight = finalSize.height;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(0, finalSize.height - layerHeight)];
    [bezier addLineToPoint:CGPointMake(0, finalSize.height-1)];
    [bezier addLineToPoint:CGPointMake(finalSize.width, finalSize.height - 1)];
    [bezier addLineToPoint:CGPointMake(finalSize.width-7, finalSize.height - layerHeight)];
    [bezier addLineToPoint:CGPointMake(0,0)];
    layer.path = bezier.CGPath;
    layer.fillColor = color.CGColor;
    [view.layer addSublayer:layer];
}


+ (void)drawDownTrapezoidBackViewWithView:(UIView *)view BackColor:(UIColor *)color
{
    CGSize finalSize = CGSizeMake(CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    CGFloat layerHeight = finalSize.height;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(0, finalSize.height - layerHeight)];
    [bezier addLineToPoint:CGPointMake(0, finalSize.height-1)];
    [bezier addLineToPoint:CGPointMake(finalSize.width*0.7, finalSize.height - 1)];
    [bezier addLineToPoint:CGPointMake(finalSize.width,finalSize.height - layerHeight )];
    [bezier addLineToPoint:CGPointMake(0,0)];
    layer.path = bezier.CGPath;
    layer.fillColor = color.CGColor;
    [view.layer addSublayer:layer];
}


+(UIView *)getRadiusView:(NSInteger)radius
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, radius, radius)];
    view.layer.cornerRadius=radius/2.0;
    view.layer.masksToBounds=YES;
    return view;
}

@end
