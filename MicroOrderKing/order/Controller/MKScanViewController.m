//
//  MKScanViewController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/9/4.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVMediaFormat.h>

#import "MKScanViewController.h"
#import "MKScanSuccessController.h"

#import "TNWCameraScanView.h"

@interface MKScanViewController ()

@end

@implementation MKScanViewController
{
    UILabel *titleLab;
    UILabel *signLab;
    UILabel *titleLab2;
    UIButton *netButn;
    UILabel *content1;
    UILabel *content2;
    UILabel *content3;
}

- (void)CreatView {
    
    CGFloat kScreen_Width = [UIScreen mainScreen].bounds.size.width;
    
    //定位扫描框在屏幕正中央，并且宽高为200的正方形
    self.scanView = [[UIView alloc]initWithFrame:CGRectMake((kScreen_Width-250 * autoSizeScaleW)/2, 64 * autoSizeScaleH + 70 * autoSizeScaleH, 250 * autoSizeScaleW, 250 * autoSizeScaleW)];
    //_scanView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.scanView];
    
    //设置扫描界面（包括扫描界面之外的部分置灰，扫描边框等的设置）,后面设置
    TNWCameraScanView *clearView = [[TNWCameraScanView alloc]initWithFrame:CGRectMake(0, 64 * autoSizeScaleH, SCREEN_WIDTH, SCREEN_HEIGHT - 64 * autoSizeScaleH)];
    [self.view addSubview:clearView];
    
    titleLab = [[UILabel alloc] init];
    signLab = [[UILabel alloc] init];
    netButn = [[UIButton alloc] init];
    titleLab2 = [[UILabel alloc] init];
    content1 = [[UILabel alloc] init];
    content2 = [[UILabel alloc] init];
    content3 = [[UILabel alloc] init];
    
    [self addSubview:titleLab];
    [self addSubview:signLab];
    [self addSubview:netButn];
    [self addSubview:titleLab2];
    [self addSubview:content1];
    [self addSubview:content2];
    [self addSubview:content3];
    
}

- (void)updateViewConstraints {
    
    WS(ws)
    
//    [ws.scanView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(ws.view);
//        make.top.mas_equalTo(ws.topView.mas_bottom).offset(70 * autoSizeScaleH);
//        make.width.height.mas_equalTo(250 * autoSizeScaleW);
//    }];
    
    titleLab.text = @"官方网址";
    titleLab.font = FONT(14);
    titleLab.textColor = customWhite;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.scanView.mas_bottom).offset(24 * autoSizeScaleH);
        make.centerX.mas_equalTo(ws.view);
    }];
    
    signLab.text = @"(点击下方复制网址)";
    signLab.font = FONT(14);
    signLab.textColor = customWhite;
    [signLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10 * autoSizeScaleH);
        make.centerX.mas_equalTo(ws.view);
    }];
    
    [netButn setTitle:@"http://wap.hongyaer.cn" forState:UIControlStateNormal];
    [netButn setTitleColor:customWhite forState:UIControlStateNormal];
    netButn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.06];
    netButn.titleLabel.font = FONT(14);
    [netButn addTarget:self action:@selector(copyNetAddress) forControlEvents:UIControlEventTouchUpInside];
    [netButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(signLab.mas_bottom).offset(15 * autoSizeScaleH);
        make.centerX.mas_equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(200 * autoSizeScaleW, 35 * autoSizeScaleH));
    }];
    
    content1.text = @"1、使用电脑浏览器进入官网";
    content1.textColor = customWhite;
    content1.font = FONT(12);
    [content1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(netButn).offset(5 * autoSizeScaleW);
        make.top.mas_equalTo(netButn.mas_bottom).offset(20 * autoSizeScaleH);
    }];
    
    content2.text = @"2、点击右上角【扫码打印／导出】按钮";
    content2.textColor = customWhite;
    content2.font = FONT(12);
    [content2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(content1);
        make.top.mas_equalTo(content1.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    content3.text = @"3、扫描页面二维码";
    content3.textColor = customWhite;
    content3.font = FONT(12);
    [content3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(content1);
        make.top.mas_equalTo(content2.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    titleLab2.text = @"说明：";
    titleLab2.font = FONT(12);
    titleLab2.textColor = customWhite;
    [titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(content1.mas_left).offset(-5 * autoSizeScaleW);
        make.centerY.mas_equalTo(content1);
    }];
    
    [super updateViewConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startScan];
    
    // Do any additional setup after loading the view.
}


- (void)startScan
{
    //要判断用户是否允许app访问相机
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请您设置允许app访问您的相机->设置->隐私->相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    // 1.判断输入能否添加到会话中
    if (![self.session canAddInput:self.input]) return;
    [self.session addInput:self.input];
    
    
    // 2.判断输出能够添加到会话中
    if (![self.session canAddOutput:self.output]) return;
    [self.session addOutput:self.output];
    
    // 4.设置输出能够解析的数据类型
    // 注意点: 设置数据类型一定要在输出对象添加到会话之后才能设置
    //设置availableMetadataObjectTypes为二维码、条形码等均可扫描，如果想只扫描二维码可设置为
    // [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes;
    
    // 5.设置监听监听输出解析到的数据
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 6.添加预览图层
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    self.previewLayer.frame = self.view.bounds;
    
    // 8.开始扫描
    [self.session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    [self.session stopRunning];   //停止扫描
    //我们捕获的对象可能不是AVMetadataMachineReadableCodeObject类，所以要先判断，不然会崩溃
    if (![[metadataObjects lastObject] isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
        [self.session startRunning];
        return;
    }
    // id 类型不能点语法,所以要先去取出数组中对象
    AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
    if ( object.stringValue == nil ){
        [self.session startRunning];
    }else{
        
        LxDBAnyVar(object.stringValue);
        NSString *codeStr = object.stringValue;
        
        if ([codeStr rangeOfString:@"http://api.hongyaer.cn/uuid/"].location != NSNotFound) {
            
            [self.hud showTipMessageAutoHide:@"扫描成功"];
            
            codeStr = [codeStr stringByReplacingOccurrencesOfString:@"http://api.hongyaer.cn/uuid/" withString:@""];
            
            NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
            [plist setObject:codeStr forKey:@"uuid"];
            [plist setObject:self.printStr forKey:@"order_ids"];
            [plist setObject:@(self.printType) forKey:@"type"];
            [AFNetWorkingUsing httpGet:@"user/profile/qrcodeLogin" params:plist success:^(id json) {
                
                MKScanSuccessController *controller = [[MKScanSuccessController alloc] init];
                [self.navigationController pushViewController:controller animated:YES];
                
            } fail:^(NSError *error) {
                
                [self.hud showTipMessageAutoHide:@"打印订单请求失败"];
                [self.session startRunning];
                
            } other:^(id json) {
                
                [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
                [self.session startRunning];
                
            }];
            
        } else {
            
            [self.session startRunning];
            
        }
    }
}

- (void)copyNetAddress {
    
    [self.hud showTipMessageAutoHide:@"已复制官网网址"];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"http://wap.hongyaer.cn";
}

- (AVCaptureDevice *)device
{
    if (_device == nil) {
        // 设置AVCaptureDevice的类型为Video类型
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureDeviceInput *)input
{
    if (_input == nil) {
        //输入设备初始化
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}

- (AVCaptureMetadataOutput *)output
{
    if (_output == nil) {
        //初始化输出设备
        _output = [[AVCaptureMetadataOutput alloc] init];
        
        // 1.获取屏幕的frame
        CGRect viewRect = self.view.frame;
        // 2.获取扫描容器的frame
        CGRect containerRect = self.scanView.frame;
        
        CGFloat x = containerRect.origin.y / viewRect.size.height;
        CGFloat y = containerRect.origin.x / viewRect.size.width;
        CGFloat width = containerRect.size.height / viewRect.size.height;
        CGFloat height = containerRect.size.width / viewRect.size.width;
        //rectOfInterest属性设置设备的扫描范围
        _output.rectOfInterest = CGRectMake(x, y, width, height);
    }
    return _output;
}

- (AVCaptureSession *)session
{
    if (_session == nil) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer
{
    if (_previewLayer == nil) {
        //负责图像渲染出来
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _previewLayer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
