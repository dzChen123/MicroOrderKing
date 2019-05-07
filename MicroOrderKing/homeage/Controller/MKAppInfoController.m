//
//  MKAppInfoController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 2017/10/20.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAppInfoController.h"

@interface MKAppInfoController ()

@end

@implementation MKAppInfoController
{
    UIImageView *appIconView;
    UILabel *nameLab;
    UILabel *infoLab;
    UILabel *infoLab2;
}

- (void)CreatView {
    
    appIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    nameLab = [[UILabel alloc] init];
    infoLab = [[UILabel alloc] init];
    infoLab2 = [[UILabel alloc] init];
    
    [self.view addSubview:appIconView];
    [self.view addSubview:nameLab];
    [self.view addSubview:infoLab];
    [self.view addSubview:infoLab2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [appIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.topView.mas_bottom).offset(60 * autoSizeScaleH);
        make.centerX.mas_equalTo(ws.view);
        make.width.height.mas_equalTo(87 * autoSizeScaleW);
    }];
    
    nameLab.text = @"微单王  6.0.1";
    nameLab.font = FONT(14);
    nameLab.textColor = [UIColor hexStringToColor:@"#3CC175"];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(appIconView);
        make.top.mas_equalTo(appIconView.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    infoLab.text = @"杭州点奈科技有限公司";
    infoLab.font = FONT(12);
    infoLab.textColor = [UIColor hexStringToColor:@"#9E9E9E"];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view);
        make.bottom.mas_equalTo(infoLab2.mas_top).offset(-5 * autoSizeScaleH);
    }];
    
    infoLab2.text = @"© 2016-2017 | 浙ICP备17001486号";
    infoLab2.font = FONT(12);
    infoLab2.textColor = [UIColor hexStringToColor:@"#9E9E9E"];
    [infoLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view);
        make.bottom.mas_equalTo(ws.view).offset(-15 * autoSizeScaleH);
    }];
    
    
    [super updateViewConstraints];
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
