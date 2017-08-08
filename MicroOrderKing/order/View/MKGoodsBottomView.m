//
//  MKGoodsBottomView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKGoodsBottomView.h"

@implementation MKGoodsBottomView
{
    UILabel *selectTittle;
    UILabel *selectNum;
    UIButton *clearButn;
    UIButton *confirmButn;
    UIView *blackView;
}

- (void)CreatView {
    blackView = [[UIView alloc] init];
    clearButn = [[UIButton alloc] init];
    confirmButn = [[UIButton alloc] init];
    selectNum = [[UILabel alloc] init];
    selectTittle = [[UILabel alloc] init];
    
    [self addSubview:confirmButn];
    [self addSubview:blackView];
    [blackView addSubview:selectNum];
    [blackView addSubview:clearButn];
    [blackView addSubview:selectTittle];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    blackView.backgroundColor = [UIColor hexStringToColor:@"#3B3B3B"];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.height.mas_equalTo(ws);
        make.right.mas_equalTo(confirmButn.mas_left);
    }];
    
    selectTittle.text = @"已选商品";
    selectTittle.textColor = customWhite;
    selectTittle.font = FONT(10);
    [selectTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(blackView).offset(leftPadding);
        make.centerY.mas_equalTo(blackView);
    }];

    selectNum.textColor = customWhite;
    selectNum.font = FONTBOLD(16);
    [selectNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selectTittle.mas_right).offset(5 * autoSizeScaleW);
        make.centerY.mas_equalTo(selectTittle);
    }];
    
    [clearButn setTitle:@"清空" forState:UIControlStateNormal];
    [clearButn addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
    clearButn.titleLabel.font = FONT(10);
    clearButn.titleLabel.textColor = customWhite;
    [clearButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.mas_equalTo(confirmButn);
        make.width.mas_equalTo(50 * autoSizeScaleW);
        make.right.mas_equalTo(confirmButn.mas_left);
    }];
    
    [confirmButn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    confirmButn.titleLabel.textColor = customWhite;
    confirmButn.titleLabel.font = FONT(16);
    confirmButn.backgroundColor = themeGreen;
    [confirmButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.right.centerY.mas_equalTo(ws);
        make.width.mas_equalTo(100 * autoSizeScaleW);
    }];
}

- (void)setSelecNum:(NSInteger)num {
    selectNum.text = [NSString stringWithFormat:@"%ld",(long)num];
}

- (void)clearClick {
    if (_clearClickBlock) {
        _clearClickBlock();
    }
}

- (void)confirmClick {
    if (_confirmClickBlock) {
        _confirmClickBlock();
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
