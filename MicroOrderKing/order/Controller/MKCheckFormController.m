//
//  MKCheckFormController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKCheckFormController.h"

@interface MKCheckFormController ()

@end

@implementation MKCheckFormController
{
    UILabel *titleLab;
    UILabel *contentLab1;
    UILabel *instanceLab1;
    UILabel *contentLab2;
    UILabel *instanceLab2;
}

- (void)CreatView {
    titleLab = [[UILabel alloc] init];
    contentLab1 = [[UILabel alloc] init];
    instanceLab1 = [[UILabel alloc] init];
    contentLab2 = [[UILabel alloc] init];
    instanceLab2 = [[UILabel alloc] init];
    
    [self addSubview:titleLab];
    [self addSubview:contentLab1];
    [self addSubview:instanceLab1];
    [self addSubview:contentLab2];
    [self addSubview:instanceLab2];
}

- (void)updateViewConstraints {
    WS(ws)
    
    self.view.backgroundColor = customWhite;
    
    titleLab.text = @"智能识别支持一下两种格式：";
    titleLab.font = FONT(14);
    titleLab.textColor = wordThreeColor;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.topView.mas_bottom).offset(20 * autoSizeScaleH);
        make.left.mas_equalTo(ws.view).offset(leftPadding);
    }];
    
    NSString *contentStr = @"1、姓名、地址、手机号三者顺序不固定，但之间必须存在分隔符，分隔符可以是“逗号”、“句号”、“感叹号”、“空格”。";
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    
    [attr addAttribute:NSFontAttributeName value:FONT(14) range:NSMakeRange(0, contentStr.length)];
    [attr addAttribute:NSForegroundColorAttributeName value:wordThreeColor range:NSMakeRange(0, contentStr.length - 21)];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor hexStringToColor:@"#ff7878"] range:NSMakeRange(contentStr.length - 21, 21)];
    
    contentLab1.attributedText = attr;
    contentLab1.numberOfLines = 0;
    [contentLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab);
        make.right.lessThanOrEqualTo(ws.view).offset(rightPadding);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10 * autoSizeScaleH);
    }];
    
    instanceLab1.text = @"例：王小明，浙江省XX市XX区XX公寓XXX，182****8921；";
    instanceLab1.font = FONT(12);
    instanceLab1.textColor = wordSixColor;
    instanceLab1.numberOfLines = 0;
    [instanceLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentLab1);
        make.right.lessThanOrEqualTo(ws.view).offset(rightPadding);
        make.top.mas_equalTo(contentLab1.mas_bottom).offset(5 * autoSizeScaleH);
    }];
    
    contentLab2.text = @"2、手机号信息显示在姓名和地址之间。";
    contentLab2.font = FONT(14);
    contentLab2.textColor = wordThreeColor;
    contentLab2.numberOfLines = 0;
    [contentLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentLab1);
        make.right.lessThanOrEqualTo(ws.view).offset(rightPadding);
        make.top.mas_equalTo(instanceLab1.mas_bottom).offset(25 * autoSizeScaleH);
    }];
    
    instanceLab2.text = @"例：王小明182****8921浙江省XX市XX公寓XXX；";
    instanceLab2.font = FONT(12);
    instanceLab2.textColor = wordSixColor;
    instanceLab2.numberOfLines = 0;
    [instanceLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentLab2);
        make.right.lessThanOrEqualTo(ws.view).offset(rightPadding);
        make.top.mas_equalTo(contentLab2.mas_bottom).offset(5 * autoSizeScaleH);
    }];
    
    
    
    [super updateViewConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
