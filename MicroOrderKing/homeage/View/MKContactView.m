//
//  MKContactView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/1.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseViewController.h"

#import "MKContactView.h"

#import "MKContactModel.h"

@implementation MKContactView
{
    UILabel *tittleLab;
    UIImageView *QRCodeView;
    UILabel *serverTittle;
    UILabel *signLab;
    UIButton *weChatButn;
    UILabel *contactWayLab;
    UILabel *phoneLab;
    UILabel *qqNumLab;
    
    NSString *weChatNum;
}

- (void)setColorAndRadius {
    
    self.backgroundColor = customWhite;
    self.layer.cornerRadius = 6.0;
    self.layer.masksToBounds = YES;
}

- (void)CreatView {
    tittleLab = [[UILabel alloc] init];
    QRCodeView = [[UIImageView alloc] init];
    serverTittle = [[UILabel alloc] init];
    signLab = [[UILabel alloc] init];
    weChatButn = [[UIButton alloc] init];
    contactWayLab = [[UILabel alloc] init];
    phoneLab = [[UILabel alloc] init];
    qqNumLab = [[UILabel alloc] init];
    
    [self addSubview:tittleLab];
    [self addSubview:QRCodeView];
    [self addSubview:serverTittle];
    [self addSubview:signLab];
    [self addSubview:weChatButn];
    [self addSubview:contactWayLab];
    [self addSubview:phoneLab];
    [self addSubview:qqNumLab];
    
    [self setColorAndRadius];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    tittleLab.text = @"微信客服二维码";
    tittleLab.font = FONT(14);
    tittleLab.textColor = [UIColor hexStringToColor:@"#333333"];
    [tittleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws);
        make.top.mas_equalTo(ws.mas_top).offset(25 * autoSizeScaleH);
    }];
    
    //QRCodeView.backgroundColor = VIEWBACKGRAY;
    QRCodeView.image = [UIImage imageNamed:@"weChatNum"];
    [QRCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tittleLab.mas_bottom).offset(20 * autoSizeScaleH);
        make.centerX.mas_equalTo(ws);
        make.width.height.mas_equalTo(260 * autoSizeScaleW);
    }];
    
    serverTittle.text = @"客服微信号";
    serverTittle.font = FONT(13);
    serverTittle.textColor = [UIColor hexStringToColor:@"#4D4D4D"];
    [serverTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws);
        make.top.mas_equalTo(QRCodeView.mas_bottom).offset(35 * autoSizeScaleH);
    }];
    
    signLab.text = @"(点击下方可复制微信号)";
    signLab.font = FONT(12);
    signLab.textColor = [UIColor hexStringToColor:@"#949494"];
    [signLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws);
        make.top.mas_equalTo(serverTittle.mas_bottom).offset(10 * autoSizeScaleH);
    }];
    
    [weChatButn addTarget:self action:@selector(copyWeChatNumToPasteboard) forControlEvents:UIControlEventTouchUpInside];
    [weChatButn setTitleColor:[UIColor hexStringToColor:@"#868686"] forState:UIControlStateNormal];
    weChatButn.layer.masksToBounds = YES;
    weChatButn.layer.cornerRadius = 6.0;
    weChatButn.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
    weChatButn.titleLabel.font = FONT(14);
    [weChatButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws);
        make.top.mas_equalTo(signLab.mas_bottom).offset(10 * autoSizeScaleH);
        make.size.mas_equalTo(CGSizeMake(260 * autoSizeScaleW, 50 * autoSizeScaleH));
    }];
    
    contactWayLab.text = @"客服联系方式";
    contactWayLab.font = FONT(13);
    contactWayLab.textColor = [UIColor hexStringToColor:@"#666666"];
    [contactWayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws);
        make.top.mas_equalTo(weChatButn.mas_bottom).offset(20 * autoSizeScaleH);
    }];
    
    phoneLab.font = FONT(12);
    phoneLab.textColor = [UIColor hexStringToColor:@"#919191"];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws);
        make.top.mas_equalTo(contactWayLab.mas_bottom).offset(12 * autoSizeScaleH);
    }];
    
    qqNumLab.font = FONT(12);
    qqNumLab.textColor = [UIColor hexStringToColor:@"#919191"];
    [qqNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws);
        make.top.mas_equalTo(phoneLab.mas_bottom).offset(10 * autoSizeScaleH);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(qqNumLab).offset(25 * autoSizeScaleH);
    }];
}

- (void)setData:(id)model {
    MKContactModel *dataModel = (MKContactModel *)model;
    weChatNum = dataModel.weChatNum;
    [weChatButn setTitle:dataModel.weChatNum forState:UIControlStateNormal];
    phoneLab.text = [NSString stringWithFormat:@"手机号：%@",dataModel.phoneNum];
    qqNumLab.text = [NSString stringWithFormat:@"QQ号：%@",dataModel.qqNum];
}

- (void)copyWeChatNumToPasteboard {
    
    BaseViewController *controller = (BaseViewController *)[self parentController];
    [controller.hud showTipMessageAutoHide:@"已复制微信号"];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = weChatNum;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
