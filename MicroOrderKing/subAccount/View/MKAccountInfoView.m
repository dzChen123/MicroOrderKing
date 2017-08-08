//
//  MKAccountInfoView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKPerformanceController.h"

#import "MKAccountInfoView.h"

#import "MKAccountBaseModel.h"

@implementation MKAccountInfoView
{
    UIView *whiteView;
    UILabel *nameTittle;
    UILabel *nameLab;
    UILabel *conditionLab;
    UILabel *phoneTittle;
    UILabel *phoneLab;
    UILabel *accountLab;
    UILabel *timeTittle;
    UILabel *timeLab;
    MKAccountRecordView *recordView;
}

- (void)CreatView {
    whiteView = [[UIView alloc] init];
    nameTittle = [[UILabel alloc] init];
    nameLab = [[UILabel alloc] init];
    conditionLab = [[UILabel alloc] init];
    phoneTittle = [[UILabel alloc] init];
    phoneLab = [[UILabel alloc] init];
    accountLab = [[UILabel alloc] init];
    timeTittle = [[UILabel alloc] init];
    timeLab = [[UILabel alloc] init];
    recordView = [[MKAccountRecordView alloc] init];

    [self addSubview:whiteView];
    [self addSubview:recordView];
    [whiteView addSubview:nameTittle];
    [whiteView addSubview:nameLab];
    [whiteView addSubview:conditionLab];
    [whiteView addSubview:phoneTittle];
    [whiteView addSubview:phoneLab];
    [whiteView addSubview:accountLab];
    [whiteView addSubview:timeTittle];
    [whiteView addSubview:timeLab];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    self.backgroundColor = VIEWBACKGRAY;
    
    whiteView.backgroundColor = customWhite;
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws);
        make.bottom.mas_equalTo(timeTittle).offset(60 * autoSizeScaleH);
    }];
    
    [recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.top.mas_equalTo(whiteView.mas_bottom).offset(-25 * autoSizeScaleH);
    }];
    
    
    nameTittle.text = @"姓名";
    nameTittle.font = FONT(14);
    nameTittle.textColor = [UIColor hexStringToColor:@"#858585"];
    [nameTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(whiteView).offset(20 * autoSizeScaleW);
        make.top.mas_equalTo(whiteView).offset(30 * autoSizeScaleH);
    }];
    
    nameLab.font = FONT(15);
    nameLab.textColor = [UIColor hexStringToColor:@"#212121"];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameTittle.mas_right).offset(50 * autoSizeScaleW);
        make.bottom.mas_equalTo(nameTittle);
    }];
    
    conditionLab.font = FONT(10);
    conditionLab.textColor = customWhite;
    conditionLab.layer.cornerRadius = 2.0;
    conditionLab.layer.masksToBounds = YES;
    conditionLab.textAlignment = NSTextAlignmentCenter;
    [conditionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab.mas_right).offset(10 * autoSizeScaleW);
        make.centerY.mas_equalTo(nameLab);
        make.size.mas_equalTo(CGSizeMake(43 * autoSizeScaleW, 17 * autoSizeScaleH));
    }];
    
    phoneTittle.text = @"手机号";
    phoneTittle.font = FONT(14);
    phoneTittle.textColor = [UIColor hexStringToColor:@"#858585"];
    [phoneTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameTittle);
        make.top.mas_equalTo(nameTittle.mas_bottom).offset(25 * autoSizeScaleH);
    }];
    
    phoneLab.font = FONT(12);
    phoneLab.layer.cornerRadius = 5.0;
    phoneLab.layer.masksToBounds = YES;
    phoneLab.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
    phoneLab.textColor = [UIColor hexStringToColor:@"#535353"];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab).offset(-5 * autoSizeScaleW);
        make.centerY.mas_equalTo(phoneTittle);
        make.height.mas_equalTo(30 * autoSizeScaleH);
    }];
    
    accountLab.text = @"账号";
    accountLab.font = FONT(10);
    accountLab.textAlignment = NSTextAlignmentCenter;
    accountLab.textColor = [UIColor hexStringToColor:@"#B1C6E5"];
    accountLab.layer.borderWidth = 1.0;
    accountLab.layer.borderColor = [UIColor hexStringToColor:@"#B1C6E5"].CGColor;
    [accountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLab.mas_right).offset(10 * autoSizeScaleW);
        make.centerY.mas_equalTo(phoneLab);
        make.size.mas_equalTo(CGSizeMake(43 * autoSizeScaleW, 18 * autoSizeScaleH));
    }];
    
    timeTittle.text = @"录入时间";
    timeTittle.font = FONT(14);
    timeTittle.textColor = [UIColor hexStringToColor:@"#858585"];
    [timeTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneTittle);
        make.top.mas_equalTo(phoneTittle.mas_bottom).offset(30 * autoSizeScaleH);
    }];
    
    timeLab.font = FONT(12);
    timeLab.layer.cornerRadius = 5.0;
    timeLab.layer.masksToBounds = YES;
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
    timeLab.textColor = [UIColor hexStringToColor:@"#535353"];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(timeTittle);
        make.size.centerX.mas_equalTo(phoneLab);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(recordView);
    }];
    
}

- (void)setDataWithModel:(id)model {

    MKAccountDetailModel *dataModel = (MKAccountDetailModel *)model;
    nameLab.text = dataModel.name;
    phoneLab.text = [NSString stringWithFormat:@"  %@   ",dataModel.phoneNum];
    timeLab.text = dataModel.timeStr;
    if (![dataModel.conditionType integerValue]) {
        conditionLab.text = @"未激活";
        conditionLab.backgroundColor = [UIColor hexStringToColor:@"#DDDDDD"];
    }else{
        conditionLab.text = @"激活";
        conditionLab.backgroundColor = themeGreen;
    }
    [recordView setMemberNum:dataModel.memberNum andOrderNum:dataModel.orderNum];
}


@end

@implementation MKAccountRecordView
{
    UIView *memberNumView;
    UIView *lineView;
    UIView *orderNumView;
    UILabel *memberTittle;
    UILabel *memberNum;
    UIImageView *rightArrow1;
    UILabel *orderTittle;
    UILabel *orderNum;
    UIImageView *rightArrow2;
}

- (instancetype)init {
    if (self == [super init]) {
        [self setShadowAndRadius];
    }
    return self;
}

- (void)setShadowAndRadius {
    self.backgroundColor = customWhite;
    self.layer.cornerRadius = 6.0;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(4, 4);
    self.layer.shadowOpacity = .4;
    self.layer.shadowRadius = 4;
}

- (void)CreatView {
    memberNumView = [[UIView alloc] init];
    lineView = [[UIView alloc] init];
    orderNumView = [[UIView alloc] init];
    memberTittle = [[UILabel alloc] init];
    memberNum = [[UILabel alloc] init];
    memberTittle = [[UILabel alloc] init];
    orderTittle = [[UILabel alloc] init];
    orderNum = [[UILabel alloc] init];
    rightArrow1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"subactDateArrow"]];
    rightArrow2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"subactDateArrow"]];
    
    [self addSubview:memberNumView];
    [self addSubview:lineView];
    [self addSubview:orderNumView];
    [memberNumView addSubview:memberTittle];
    [memberNumView addSubview:memberNum];
    [memberNumView addSubview:rightArrow1];
    [orderNumView addSubview:orderTittle];
    [orderNumView addSubview:orderNum];
    [orderNumView addSubview:rightArrow2];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    memberNumView.tag = 21;
    [memberNumView addTapEventWith:self action:@selector(goToRecord:)];
    [memberNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws);
        make.bottom.mas_equalTo(memberTittle).offset(15 * autoSizeScaleH);
    }];
    
    memberTittle.text = @"录入会员数";
    memberTittle.font = FONT(14);
    memberTittle.textColor = [UIColor hexStringToColor:@"#686868"];
    [memberTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(memberNumView).offset(25 * autoSizeScaleW);
        make.top.mas_equalTo(memberNumView).offset(15 * autoSizeScaleH);
    }];
    
    memberNum.font = FONT(12);
    memberNum.textColor = [UIColor hexStringToColor:@"#4D4D4D"];
    [memberNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(memberNumView);
        make.right.mas_equalTo(rightArrow1.mas_left).offset(-10 * autoSizeScaleW);
    }];
    
    [rightArrow1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(memberNumView);
        make.right.mas_equalTo(memberNumView).offset(-30 * autoSizeScaleW);
        make.width.height.mas_equalTo(10 * autoSizeScaleW);
    }];
    
    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(memberTittle);
        make.right.mas_equalTo(rightArrow1);
        make.top.mas_equalTo(memberNumView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    orderNumView.tag = 22;
    [orderNumView addTapEventWith:self action:@selector(goToRecord:)];
    [orderNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(memberNumView);
        make.top.mas_equalTo(lineView.mas_bottom);
    }];
    
    orderTittle.text = @"录入订单数";
    orderTittle.font = FONT(14);
    orderTittle.textColor = [UIColor hexStringToColor:@"#686868"];
    [orderTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(memberTittle);
        make.centerY.mas_equalTo(orderNumView);
    }];
    
    orderNum.font = FONT(12);
    orderNum.textColor = [UIColor hexStringToColor:@"#4D4D4D"];
    [orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(orderNumView);
        make.left.mas_equalTo(memberNum);
    }];
    
    [rightArrow2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(rightArrow1);
        make.centerY.mas_equalTo(orderNumView);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(orderNumView);
    }];
}

- (void)goToRecord:(UITapGestureRecognizer *)tap {
    UIViewController *parent = [self parentController];
    MKPerformanceController *controller = [[MKPerformanceController alloc] init];
    controller.currentIndex = tap.view.tag == 21 ? 0 : 1;
    controller.topTitle = @"录入详情";
    [parent.navigationController pushViewController:controller animated:YES];
}

- (void)setMemberNum:(NSString *)member andOrderNum:(NSString *)order {
    memberNum.text = member;
    orderNum.text = order;
}


@end
