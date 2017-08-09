//
//  MKMemTradesInfoView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/30.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKTradesDetailController.h"

#import "MKMemTradesInfoView.h"

#import "MKMemberBaseModel.h"

#define tradesInfoColor [UIColor hexStringToColor:@"#6C6C6C"]

@implementation MKMemTradesInfoView
{
    UILabel *tradesTitle;
    UIView *lineView;
    UILabel *timesTittle;
    UILabel *timesLab;
    UILabel *moneyTittle;
    UILabel *moneyLab;
    UILabel *timeTittle;
    UILabel *timeLab;
    UIButton *checkButn;
    
    NSString *totalCost;
    NSString *totalCount;
    NSString *userId;
}

- (void)setShadowAndRadius {
    self.backgroundColor = customWhite;
    self.layer.cornerRadius = 6.0;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(4, 4);
    self.layer.shadowOpacity = .6;
    self.layer.shadowRadius = 4;
}

- (void)CreatView {
    tradesTitle = [[UILabel alloc] init];
    lineView = [[UIView alloc] init];
    timesTittle = [[UILabel alloc] init];
    timesLab = [[UILabel alloc] init];
    moneyTittle = [[UILabel alloc] init];
    moneyLab = [[UILabel alloc] init];
    timeTittle = [[UILabel alloc] init];
    timeLab = [[UILabel alloc] init];
    checkButn = [[UIButton alloc] init];
    
    [self addSubview:tradesTitle];
    [self addSubview:lineView];
    [self addSubview:timesTittle];
    [self addSubview:timesLab];
    [self addSubview:moneyTittle];
    [self addSubview:moneyLab];
    [self addSubview:timeLab];
    [self addSubview:timeTittle];
    [self addSubview:checkButn];
    
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    [self setShadowAndRadius];
    
    tradesTitle.text = @"交易信息";
    tradesTitle.font = FONT(14);
    tradesTitle.textColor = [UIColor hexStringToColor:@"#7E7E7E"];
    [tradesTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(25 * autoSizeScaleW);
        make.top.mas_equalTo(ws).offset(15 * autoSizeScaleH);
    }];
    
    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(30 * autoSizeScaleW);
        make.right.mas_equalTo(ws).offset(-30 * autoSizeScaleW);
        make.top.mas_equalTo(tradesTitle.mas_bottom).offset(15 * autoSizeScaleH);
        make.height.mas_equalTo(1);
    }];
    
    
    timesTittle.text = @"交易次数:";
    timesTittle.font = FONT(12);
    timesTittle.textColor = tradesInfoColor;
    [timesTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tradesTitle);
        make.top.mas_equalTo(lineView).offset(15 * autoSizeScaleH);
    }];
    
    timesLab.font = FONT(12);
    timesLab.textColor = tradesInfoColor;
    [timesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws).offset(-25 * autoSizeScaleW);
        make.centerY.mas_equalTo(timesTittle);
    }];
    
    moneyTittle.text = @"交易金额:";
    moneyTittle.font = FONT(12);
    moneyTittle.textColor = tradesInfoColor;
    [moneyTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timesTittle);
        make.top.mas_equalTo(timesTittle.mas_bottom).offset(10 * autoSizeScaleH);
    }];
    
    moneyLab.font = FONT(12);
    moneyLab.textColor = tradesInfoColor;
    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(moneyTittle);
        make.right.mas_equalTo(timesLab);
    }];
    
    timeTittle.text = @"最后一次交易时间:";
    timeTittle.font = FONT(12);
    timeTittle.textColor = tradesInfoColor;
    [timeTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(moneyTittle);
        make.top.mas_equalTo(moneyTittle.mas_bottom).offset(10 * autoSizeScaleH);
    }];
    
    timeLab.font = FONT(12);
    timeLab.textColor = tradesInfoColor;
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(moneyLab);
        make.centerY.mas_equalTo(timeTittle);
    }];
    
    [checkButn addTarget:self action:@selector(goToTradesDetail) forControlEvents:UIControlEventTouchUpInside];
    [checkButn setTitle:@"查看详情" forState:UIControlStateNormal];
    [checkButn setTitleColor:customWhite forState:UIControlStateNormal];
    checkButn.titleLabel.font = FONT(14);
    checkButn.layer.masksToBounds = YES;
    checkButn.layer.cornerRadius = 3.0;
    checkButn.backgroundColor = themeGreen;
    [checkButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws);
        make.top.mas_equalTo(timeTittle.mas_bottom).offset(25 * autoSizeScaleH);
        make.size.mas_equalTo(CGSizeMake(80 * autoSizeScaleW, 30 * autoSizeScaleH));
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(checkButn).offset(10 * autoSizeScaleH);
    }];
    
}

- (void)setDataWithArr:(NSArray *)arr {
    NSString *times = arr[0];
    NSString *money = arr[1];
    NSString *time = arr[2];
    if (!times.length) { times = @"0"; }
    if (!money.length) { times = @"0"; }
    if (!time.length) { times = @"最近没有进行交易"; }
    timesLab.text = [NSString stringWithFormat:@"%@次",times];
    moneyLab.text = [NSString stringWithFormat:@"%@元",money];
    timeLab.text = time;
}

- (void)setDataWithModel:(id)model {
    MKMemberDetailModel *dataModel = (MKMemberDetailModel *)model;
    NSString *times = dataModel.orderCount;
    NSString *money = dataModel.sum;
    NSString *time = dataModel.lastTime;
    if (!times.length) { times = @"0"; }
    if (!money.length) { money = @"0"; }
    if (!time.length) { time = @"最近没有进行交易"; }
    totalCost = money;
    totalCount = times;
    userId = dataModel.memberId;
    timesLab.text = [NSString stringWithFormat:@"%@次",times];
    moneyLab.text = [NSString stringWithFormat:@"%@元",money];
    timeLab.text = time;
}


- (void)goToTradesDetail {
    UIViewController *parent = [self parentController];
    MKTradesDetailController *controller = [[MKTradesDetailController alloc] init];
    controller.totalCount = totalCount;
    controller.totalCost = totalCost;
    controller.userId = userId;
    [parent.navigationController pushViewController:controller animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
