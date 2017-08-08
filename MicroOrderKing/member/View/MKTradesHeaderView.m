//
//  MKTradesHeaderView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKTradesHeaderView.h"

@implementation MKTradesHeaderView
{
    UILabel *tradesCost;
    UILabel *tradesCostTittle;
    UIView *leftView;
    UILabel *tradesCount;
    UILabel *tradesCountTittle;
    UIView *rightView;
    UIView *lineView;
}

- (void)CreatView {
    leftView = [[UIView alloc] init];
    rightView = [[UIView alloc] init];
    tradesCost = [[UILabel alloc] init];
    tradesCostTittle = [[UILabel alloc] init];
    tradesCount = [[UILabel alloc] init];
    tradesCountTittle = [[UILabel alloc] init];
    lineView = [[UIView alloc] init];
    
    [self addSubview:leftView];
    [self addSubview:rightView];
    [self addSubview:tradesCost];
    [self addSubview:tradesCostTittle];
    [self addSubview:tradesCount];
    [self addSubview:tradesCountTittle];
    [self addSubview:lineView];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    self.backgroundColor = themeGreen;
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(ws);
        make.width.mas_equalTo(ws).multipliedBy(.5);
        make.bottom.mas_equalTo(tradesCountTittle).offset(25 * autoSizeScaleH);
    }];
    
    tradesCount.textColor = customWhite;
    tradesCount.font = FONTBOLD(25);
    [tradesCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(rightView);
        make.top.mas_equalTo(rightView).offset(25 * autoSizeScaleH);
    }];
    
    tradesCountTittle.text = @"交易次数";
    tradesCountTittle.textColor = customWhite;
    tradesCountTittle.font = FONT(14);
    [tradesCountTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(tradesCount);
        make.top.mas_equalTo(tradesCount.mas_bottom).offset(5 * autoSizeScaleH);
    }];
    
    lineView.backgroundColor = [UIColor hexStringToColor:@"#3ABE67"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rightView).offset(40 * autoSizeScaleH);
        make.bottom.mas_equalTo(rightView).offset(-40 * autoSizeScaleH);
        make.right.mas_equalTo(rightView.mas_left);
        make.width.mas_equalTo(1);
    }];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerY.mas_equalTo(rightView);
        make.left.mas_equalTo(ws);
    }];
    
    tradesCostTittle.text = @"交易金额(元)";
    tradesCostTittle.textColor = customWhite;
    tradesCostTittle.font = FONT(14);
    [tradesCostTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tradesCountTittle);
        make.centerX.mas_equalTo(leftView);
    }];
    
    tradesCost.textColor = customWhite;
    [tradesCost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(tradesCostTittle);
        make.bottom.mas_equalTo(tradesCostTittle.mas_top).offset(-5 * autoSizeScaleH);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(rightView);
    }];
}

- (void)setCost:(NSString *)cost andCount:(NSString *)count {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",cost]];
    [attr addAttribute:NSFontAttributeName
                 value:FONTBOLD(25)
                 range:NSMakeRange(1, cost.length)];
    [attr addAttribute:NSFontAttributeName
                 value:FONT(12)
                 range:NSMakeRange(0, 1)];
    tradesCost.attributedText = attr;
    tradesCount.text = count;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
