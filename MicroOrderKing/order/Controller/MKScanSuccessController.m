//
//  MKScanSuccessController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/9/4.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKScanSuccessController.h"

@interface MKScanSuccessController ()

@end

@implementation MKScanSuccessController
{
    UIImageView *successView;
    UIButton *greenButn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setTopView {
    
    [super setTopView];
    
    self.topTitle = @"扫码打印";
    [self.topView setLeftEvent:self action:@selector(goToHomePage)];
    
}

- (void)CreatView {
    
    successView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bigCheck"]];
    greenButn = [[UIButton alloc] init];
    
    [self addSubview:successView];
    [self addSubview:greenButn];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        
    }
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [successView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view);
        make.top.mas_equalTo(ws.topView.mas_bottom).offset(53 * autoSizeScaleH);
        make.width.height.mas_equalTo(137 * autoSizeScaleW);
    }];
    
    [greenButn setTitle:@"返回首页" forState:UIControlStateNormal];
    [greenButn setTitleColor:customWhite forState:UIControlStateNormal];
    greenButn.backgroundColor = themeGreen;
    greenButn.layer.cornerRadius = 10.0;
    greenButn.layer.masksToBounds = YES;
    greenButn.titleLabel.font = FONT(16);
    [greenButn addTarget:self action:@selector(goToHomePage) forControlEvents:UIControlEventTouchUpInside];
    [greenButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(ws.view).offset(- 15 * autoSizeScaleH);
        make.left.mas_equalTo(ws.view).offset(leftPadding);
        make.right.mas_equalTo(ws.view).offset(rightPadding);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    [super updateViewConstraints];
}

- (void)goToHomePage {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
