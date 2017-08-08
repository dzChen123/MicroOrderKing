//
//  MKAccountManageCell.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAccountManageCell.h"

#import "MKAccountBaseModel.h"

@implementation MKAccountManageCell
{
    UIImageView *avatarIcon;
    UIImageView *phoneIcon;
    UIImageView *rightArrow;
    UILabel *nameLab;
    UILabel *conditionLab;
    UILabel *phoneNumLab;
    UIView *lineView;
}

- (void)createView {
    avatarIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"subactName"]];
    phoneIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"subactPhNum"]];
    rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"subactArrow"]];
    nameLab = [[UILabel alloc] init];
    conditionLab = [[UILabel alloc] init];
    phoneNumLab = [[UILabel alloc] init];
    lineView = [[UIView alloc] init];
    
    [self.contentView addSubview:avatarIcon];
    [self.contentView addSubview:phoneIcon];
    [self.contentView addSubview:rightArrow];
    [self.contentView addSubview:nameLab];
    [self.contentView addSubview:conditionLab];
    [self.contentView addSubview:phoneNumLab];
    [self.contentView addSubview:lineView];
}

- (void)setttingViewAtuoLayout {
    
    WS(ws)
    
    [avatarIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.contentView).offset(leftPadding);
        make.top.mas_equalTo(ws.contentView).offset(20 * autoSizeScaleH);
        make.width.height.mas_equalTo(14 * autoSizeScaleW);
    }];
    
    nameLab.font = FONT(14);
    nameLab.textColor = [UIColor hexStringToColor:@"#474747"];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(avatarIcon.mas_right).offset(10 * autoSizeScaleW);
        make.centerY.mas_equalTo(avatarIcon);
    }];
    
    conditionLab.font = FONT(12);
    conditionLab.textColor = customWhite;
    conditionLab.layer.cornerRadius = 2.0;
    conditionLab.layer.masksToBounds = YES;
    conditionLab.textAlignment = NSTextAlignmentCenter;
    [conditionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab.mas_right).offset(10 * autoSizeScaleW);
        make.centerY.mas_equalTo(nameLab);
        make.size.mas_equalTo(CGSizeMake(43 * autoSizeScaleW, 20 * autoSizeScaleH));
    }];
    
    [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(avatarIcon);
        make.top.mas_equalTo(avatarIcon.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    phoneNumLab.font = FONT(12);
    phoneNumLab.textColor = [UIColor hexStringToColor:@"#585858"];
    [phoneNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab);
        make.centerY.mas_equalTo(phoneIcon);
    }];
    
    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(ws.contentView);
        make.top.mas_equalTo(phoneIcon.mas_bottom).offset(20 * autoSizeScaleH);
        make.height.mas_equalTo(1);
    }];
    
    [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(ws.contentView);
        make.right.mas_equalTo(ws.contentView).offset(rightPadding);
    }];
    
}

- (void)setData:(id)model {
    MKAccountBaseModel *cellModel = (MKAccountBaseModel *)model;
    nameLab.text = cellModel.name;
    phoneNumLab.text = cellModel.phoneNum;
    if (![cellModel.conditionType integerValue]) {
        conditionLab.text = @"未激活";
        conditionLab.backgroundColor = [UIColor hexStringToColor:@"#DDDDDD"];
    }else{
        conditionLab.text = @"激活";
        conditionLab.backgroundColor = themeGreen;
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
