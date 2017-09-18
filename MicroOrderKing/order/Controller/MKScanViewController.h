//
//  MKScanViewController.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/9/4.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface MKScanViewController : BaseViewController<AVCaptureMetadataOutputObjectsDelegate>

@property ( strong , nonatomic ) AVCaptureDevice * device; //捕获设备，默认后置摄像头
@property ( strong , nonatomic ) AVCaptureDeviceInput * input; //输入设备
@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;//输出设备，需要指定他的输出类型及扫描范围
@property ( strong , nonatomic ) AVCaptureSession * session; //AVFoundation框架捕获类的中心枢纽，协调输入输出设备以获得数据
@property ( strong , nonatomic ) AVCaptureVideoPreviewLayer * previewLayer;//展示捕获图像的图层，是CALayer的子类
@property (nonatomic,strong) UIView *scanView; //定位扫描框在哪个位置

@property (strong,nonatomic) NSString *printStr;
@property (assign,nonatomic) NSInteger printType;

@end
