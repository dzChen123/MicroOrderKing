//
//  MKConfirmView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/3.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKConfirmView.h"

@implementation MKConfirmView
{
    UIImageView *infoIcon;
    UILabel *signLab;
    UIButton *cancelButn;
    UIButton *confirmButn;
}

- (void)CreatView {
    infoIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"enorderNote"]];
    signLab = [[UILabel alloc] init];
    cancelButn = [[UIButton alloc] init];
    confirmButn = [[UIButton alloc] init];
    
    [self addSubview:infoIcon];
    [self addSubview:signLab];
    [self addSubview:cancelButn];
    [self addSubview:confirmButn];
}

- (void)SettingViewAttributes {

    WS(ws)

    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 6.0;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor hexStringToColor:@"#F3F4F6"];
    
    //signLab.text = @"请确定您已收到货款并用户已收货";
    signLab.font = FONT(14);
    signLab.textColor = [UIColor hexStringToColor:@"#222324"];
    [signLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws).offset(10 * autoSizeScaleW);
        make.top.mas_equalTo(ws).offset(40 * autoSizeScaleH);
    }];
    
    [infoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(15 * autoSizeScaleH);
        make.centerY.mas_equalTo(signLab);
        make.right.mas_equalTo(signLab.mas_left).offset(-10 * autoSizeScaleW);
    }];
    
    cancelButn.backgroundColor = customWhite;
    [cancelButn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelButn setTitleColor:[UIColor hexStringToColor:@"#969696"] forState:UIControlStateNormal];
    cancelButn.titleLabel.font = FONT(14);
    [cancelButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws);
        make.top.mas_equalTo(signLab.mas_bottom).offset(35 * autoSizeScaleH);
        make.width.mas_equalTo(ws).multipliedBy(.5);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    confirmButn.backgroundColor = themeGreen;
    //[confirmButn setTitle:@"交易成功" forState:UIControlStateNormal];
    [confirmButn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmButn setTitleColor:customWhite forState:UIControlStateNormal];
    confirmButn.titleLabel.font = FONT(14);
    [confirmButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws);
        make.size.centerY.mas_equalTo(cancelButn);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(cancelButn);
    }];
    
}

- (void)setSignStr:(NSArray *)signArra {
    signLab.text = signArra[0];
    [confirmButn setTitle:signArra[1] forState:UIControlStateNormal];
}

- (void)cancelClick {
    if (_cancelBlock) {
        _cancelBlock();
    }
}

- (void)confirmClick {
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
