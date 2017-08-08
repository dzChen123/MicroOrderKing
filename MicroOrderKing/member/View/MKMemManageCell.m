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
}

- (void)createView {
    nameLab = [[UILabel alloc] init];
    lineView = [[UIView alloc] init];
    
    [self.contentView addSubview:nameLab];
    [self.contentView addSubview:lineView];
}

- (void)setttingViewAtuoLayout {
    
    WS(ws)
    
    nameLab.font = FONT(15);
    nameLab.textColor = [UIColor hexStringToColor:@"#1D1D1D"];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.contentView).offset(15 * autoSizeScaleW);
        make.centerY.mas_equalTo(ws.contentView);
    }];
    
    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab);
        make.right.mas_equalTo(ws.contentView);
        make.bottom.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)setData:(id)model{
    MKMemberBaseModel *cellModel = (MKMemberBaseModel *)model;
    nameLab.text = cellModel.name;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
