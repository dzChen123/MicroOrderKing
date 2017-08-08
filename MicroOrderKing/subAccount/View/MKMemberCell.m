//
//  MKMemberCell.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKMemberCell.h"

#import "MKAccountBaseModel.h"

@implementation MKMemberCell
{
    UIImageView *avatar;
    UILabel *nameLab;
    UILabel *phoneLab;
    UIView *lineView;
}

- (void)createView {
    avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"subactName"]];
    nameLab = [[UILabel alloc] init];
    phoneLab = [[UILabel alloc] init];
    lineView = [[UIView alloc] init];
    
    [self.contentView addSubview:avatar];
    [self.contentView addSubview:nameLab];
    [self.contentView addSubview:phoneLab];
    [self.contentView addSubview:lineView];
}

- (void)setttingViewAtuoLayout {
    
    WS(ws)
    
    [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.contentView).offset(leftPadding);
        make.top.mas_equalTo(ws.contentView).offset(25 * autoSizeScaleH);
        make.bottom.mas_equalTo(ws.contentView).offset(-25 * autoSizeScaleH);
        make.width.height.mas_equalTo(15 * autoSizeScaleW);
    }];
    
    nameLab.font = FONT(14);
    nameLab.textColor = [UIColor hexStringToColor:@"#323232"];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(avatar.mas_right).offset(10 * autoSizeScaleW);
        make.centerY.mas_equalTo(avatar);
    }];
    
    phoneLab.layer.masksToBounds = YES;
    phoneLab.layer.cornerRadius = 5.0;
    phoneLab.font = FONT(12);
    phoneLab.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
    phoneLab.textColor = [UIColor hexStringToColor:@"#888888"];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws.contentView).offset(rightPadding);
        make.centerY.mas_equalTo(avatar);
        make.height.mas_equalTo(30 * autoSizeScaleH);
    }];
    
    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)setData:(id)model {
    
    MKAccountBaseModel *cellModel = (MKAccountBaseModel *)model;
    nameLab.text = cellModel.name;
    phoneLab.text = [NSString stringWithFormat:@"  %@  ",cellModel.phoneNum];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
