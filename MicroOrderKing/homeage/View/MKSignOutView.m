//
//  MKSignOutView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/3.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKSignOutView.h"

@implementation MKSignOutView
{
    UIView *whiteView;
    UILabel *tittleLab;
    UIView *lineView;
    UIButton *signOutButn;
    UIButton *cancelButn;
}

- (void)CreatView {
    whiteView = [[UIView alloc] init];
    tittleLab = [[UILabel alloc] init];
    lineView = [[UIView alloc] init];
    signOutButn = [[UIButton alloc] init];
    cancelButn = [[UIButton alloc] init];
    
    [self addSubview:whiteView];
    [whiteView addSubview:tittleLab];
    [whiteView addSubview:lineView];
    [whiteView addSubview:signOutButn];
    [self addSubview:cancelButn];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    cancelButn.backgroundColor = customWhite;
    [cancelButn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelButn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButn setTitleColor:wordThreeColor forState:UIControlStateNormal];
    cancelButn.layer.masksToBounds = YES;
    cancelButn.layer.cornerRadius = 6.0;
    cancelButn.titleLabel.font = FONT(15);
    [cancelButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.bottom.mas_equalTo(ws).offset(-15 * autoSizeScaleH);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    whiteView.backgroundColor = customWhite;
    whiteView.layer.masksToBounds = YES;
    whiteView.clipsToBounds = YES;
    whiteView.layer.cornerRadius = 6.0;
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(cancelButn);
        make.bottom.mas_equalTo(cancelButn.mas_top).offset(-10 * autoSizeScaleH);
        make.top.mas_equalTo(tittleLab).offset(-10 * autoSizeScaleH);
    }];
    
    signOutButn.titleLabel.font = FONT(15);
    [signOutButn addTarget:self action:@selector(signOut) forControlEvents:UIControlEventTouchUpInside];
    [signOutButn setTitle:@"退出登录" forState:UIControlStateNormal];
    [signOutButn setTitleColor:[UIColor hexStringToColor:@"#ff0000"] forState:UIControlStateNormal];
    signOutButn.backgroundColor = customWhite;
    [signOutButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(whiteView);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(signOutButn.mas_top);
        make.left.right.mas_equalTo(signOutButn);
        make.height.mas_equalTo(1);
    }];
    
    tittleLab.text = @"确认退出登录";
    tittleLab.textColor = [UIColor lightGrayColor];
    tittleLab.font = FONT(12);
    [tittleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws);
        make.bottom.mas_equalTo(signOutButn.mas_top).offset(-10 * autoSizeScaleH);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(whiteView);
    }];
    
    
}

- (void)cancelClick {
    if (_cancelBlock) {
        _cancelBlock();
    }
}

- (void)signOut {
    if (_confirmBlock) {
        _confirmBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
