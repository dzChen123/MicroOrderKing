//
//  MKMemManageCell.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/30.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKMemManageCell.h"

#import "MKMemberBaseModel.h"

@implementation MKMemManageCell
{
    UILabel *nameLab;
    UIView *lineView;
    UILabel *remarkLab;
}

- (void)createView {
    nameLab = [[UILabel alloc] init];
    lineView = [[UIView alloc] init];
    remarkLab = [[UILabel alloc] init];
    
    [self.contentView addSubview:nameLab];
    [self.contentView addSubview:lineView];
    [self.contentView addSubview:remarkLab];
}

- (void)setttingViewAtuoLayout {
    
    WS(ws)
    
    nameLab.font = FONT(15);
    nameLab.textColor = [UIColor hexStringToColor:@"#1D1D1D"];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.contentView).offset(leftPadding);
        make.centerY.mas_equalTo(ws.contentView);
    }];
    
    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab);
        make.right.mas_equalTo(ws.contentView);
        make.bottom.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(1);
    }];
    
    remarkLab.font = FONT(11);
    remarkLab.textColor = [UIColor hexStringToColor:@"#999999"];
    remarkLab.backgroundColor = [UIColor hexStringToColor:@"#f4f4f4"];
    remarkLab.layer.masksToBounds = YES;
    remarkLab.layer.cornerRadius = 5.0;
    [remarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws).offset(-20 * autoSizeScaleW);
        make.centerY.mas_equalTo(nameLab);
        make.height.mas_equalTo(20 * autoSizeScaleH);
        make.left.greaterThanOrEqualTo(ws.contentView).offset(230 * autoSizeScaleW);
    }];
}

- (void)setData:(id)model{
    MKMemberBaseModel *cellModel = (MKMemberBaseModel *)model;
    nameLab.text = cellModel.name;
    if (cellModel.remark.length > 0) {
        remarkLab.text = [NSString stringWithFormat:@"   %@   ",cellModel.remark];
    }else{
        remarkLab.hidden = YES;
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
