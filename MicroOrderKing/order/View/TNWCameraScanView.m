//
//  TNWCameraScanView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/9/4.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "TNWCameraScanView.h"

@interface TNWCameraScanView()
{
    CGFloat sceenHeight;
    NSTimer *timer;
    CGRect  scanRect;
    CGFloat kScreen_Width;
    CGFloat kScreen_Height;
}

@property (nonatomic,assign)CGFloat lineWidth;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,strong)UIColor  *lineColor;
@property (nonatomic, assign)CGFloat scanTime;

@end

@implementation TNWCameraScanView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor]; // 清空背景色，否则为黑
        sceenHeight =self.frame.size.height;
        _height =   250 * autoSizeScaleW; // 宽高200的正方形
        _lineWidth = 2;   // 扫描框4个脚的宽度
        _lineColor =  customWhite; // 扫描框4个脚的颜色
        _scanTime = 3;      //扫描线的时间间隔设置
        
        kScreen_Width = [UIScreen mainScreen].bounds.size.width;
        kScreen_Height = [UIScreen mainScreen].bounds.size.height;
        [self scanLineMove];
        
        //定时，多少秒扫描线刷新一次
        timer =  [NSTimer scheduledTimerWithTimeInterval:_scanTime target:self selector:@selector(scanLineMove) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)scanLineMove{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake((kScreen_Width-_height)/2, 70 * autoSizeScaleH, _height, 2)];
    line.backgroundColor = customWhite;
    [self addSubview:line];
    [UIView animateWithDuration:_scanTime animations:^{
        line.frame = CGRectMake((kScreen_Width-_height)/2,  70 * autoSizeScaleH + _height, _height, 0.5);
    } completion:^(BOOL finished) {
        [line removeFromSuperview];
    }];
}

- (void)drawRect:(CGRect)rect {

    //CGFloat   bottomHeight =  (sceenHeight-_height)/2;
    CGFloat   leftWidth = (kScreen_Width-_height)/2;        //cdz  项目需要 做出一定调整  没有用到参数
    
    //cdz
    CGFloat topHeight = 70 * autoSizeScaleH;
    CGFloat bottomHeight = sceenHeight - _height - topHeight;
    CGFloat lineLength = 50 * autoSizeScaleW;
    
    
    
    //cdz end
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置4个方向的灰度值，透明度为0.5，可自行调整。
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.3);
    CGContextFillRect(ctx, CGRectMake(0, 0, kScreen_Width, topHeight));
    CGContextStrokePath(ctx);
    CGContextFillRect(ctx, CGRectMake(0,topHeight, leftWidth, _height));
    CGContextStrokePath(ctx);
    CGContextFillRect(ctx, CGRectMake((kScreen_Width+_height)/2, topHeight, leftWidth, _height));
    CGContextStrokePath(ctx);
    CGContextFillRect(ctx, CGRectMake(0,topHeight + _height, kScreen_Width, bottomHeight));
    CGContextStrokePath(ctx);
    
    //扫描框4个脚的设置
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextSetStrokeColorWithColor(ctx, _lineColor.CGColor);
    //左上角
    CGContextMoveToPoint(ctx, leftWidth, topHeight + lineLength);
    CGContextAddLineToPoint(ctx, leftWidth, topHeight);
    CGContextAddLineToPoint(ctx, leftWidth + lineLength, topHeight);
    CGContextStrokePath(ctx);
    //右上角
    CGContextMoveToPoint(ctx, (kScreen_Width+_height)/2 - lineLength, topHeight);
    CGContextAddLineToPoint(ctx, (kScreen_Width+_height)/2, topHeight);
    CGContextAddLineToPoint(ctx, (kScreen_Width+_height)/2, topHeight + lineLength);
    CGContextStrokePath(ctx);
    //左下角
    CGContextMoveToPoint(ctx, leftWidth, topHeight + _height - lineLength);
    CGContextAddLineToPoint(ctx, leftWidth,  topHeight + _height);
    CGContextAddLineToPoint(ctx, leftWidth + lineLength, topHeight + _height);
    CGContextStrokePath(ctx);
    //右下角
    CGContextMoveToPoint(ctx, (kScreen_Width+_height)/2-lineLength, topHeight + _height);
    CGContextAddLineToPoint(ctx,  (kScreen_Width+_height)/2,  topHeight + _height);
    CGContextAddLineToPoint(ctx,  (kScreen_Width+_height)/2, topHeight + _height - lineLength);
    CGContextStrokePath(ctx);
    
    //设置扫描框4个边的颜色和线框。
    //    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    //    CGContextSet_lineWidth(ctx, 1);
    //    CGContextAddRect(ctx, CGRectMake(leftWidth, bottomHeight, height, height));
    //    CGContextStrokePath(ctx);
    scanRect = CGRectMake(leftWidth, topHeight, _height, _height);
    CGContextSetRGBFillColor(ctx, 1, 1, 1, .06);
    CGContextFillRect(ctx, scanRect);
    
}

- (void)dealloc{
    //清除计时器
    [timer invalidate];
    timer = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
