//
//  MKTradesInfoView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/26.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKOrderManageController.h"

#import "MKTradesInfoView.h"

#import "MKHomeModel.h"

@implementation MKTradesInfoView
{
    UIImageView *bgView;
    MKTradesItemView *orderView;
    MKTradesItemView *tradesView;
    MKToDoItemView *toDoView;
}

- (void)CreatView {
    bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeBg"]];
    orderView = [[MKTradesItemView alloc] initWithTitles:@[@"今日订单数",@"周订单数",@"月订单数"]
                                             andIconName:@"homeOrderNum"
                                              isNeedLine:YES];
    tradesView = [[MKTradesItemView alloc] initWithTitles:@[@"今日交易额(元)",@"周交易额",@"月交易额"]
                                              andIconName:@"homeTransaction"
                                               isNeedLine:NO];
    toDoView = [[MKToDoItemView alloc] init];
    [self addSubview:bgView];
    [self addSubview:orderView];
    [self addSubview:tradesView];
    [self addSubview:toDoView];
    
    [orderView setUpdateData:@[@"...",@"...",@"..."]];
    [tradesView setUpdateData:@[@"...",@"...",@"..."]];
    [toDoView setUpdateData:@[@" ... ",@" ... "]];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    self.backgroundColor = VIEWBACKGRAY;
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.top.mas_equalTo(ws);
        make.bottom.mas_equalTo(tradesView).offset(20 * autoSizeScaleH);
    }];
    
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.centerX.mas_equalTo(ws);
    }];
    
    [tradesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderView.mas_bottom);
        make.size.centerX.mas_equalTo(orderView);
    }];
    
    [toDoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.top.mas_equalTo(tradesView.mas_bottom);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(toDoView).offset(20 * autoSizeScaleH);
    }];
}

- (void)setUpdateModel:(id)model {
    
    MKHomeModel *dataModel = (MKHomeModel *)model;
    
    [orderView setUpdateDataToday:dataModel.today_count Week:dataModel.week_count Month:dataModel.month_count];
    [tradesView setUpdateDataToday:dataModel.today_sum Week:dataModel.week_sum Month:dataModel.month_sum];
    [toDoView setUpdataDeliver:dataModel.shipping_count Confirm:dataModel.confirm_count];
}

@end

@implementation MKTradesItemView
{
    UIView *todayPart;
    UILabel *todayNum;
    UIImageView *todayIcon;
    UILabel *todayTittle;
    UIView *lineView;
    UIView *sumPart;
    UILabel *weekNum;
    UILabel *weekTittle;
    UILabel *monthNum;
    UILabel *monthTittle;
    UIView *bottomView;
}

- (instancetype)initWithTitles:(NSArray *)tittleArra andIconName:(NSString *)iconName isNeedLine:(BOOL)isNeed {
    if(self == [super init]) {
        [self setUpTittles:tittleArra andIcon:[UIImage imageNamed:iconName]];
        bottomView.hidden = !isNeed;
    }
    return self;
}

- (void)setUpTittles:(NSArray *)arra andIcon:(UIImage *)icon {
    todayTittle.text = arra[0];
    weekTittle.text = arra[1];
    monthTittle.text = arra[2];
    todayIcon.image = icon;
}

- (void)setUpdateDataToday:(NSInteger)today Week:(NSInteger)week Month:(NSInteger)month {
    todayNum.text = [self ConvertToString:today];
    weekNum.text = [self ConvertToString:week];
    monthNum.text = [self ConvertToString:month];
}

- (NSString *)ConvertToString:(NSInteger)number {
    NSString *resultStr;
    if (number > 10000) {
        number = number / 10000;
        resultStr = [NSString stringWithFormat:@"%ld万",(long)number];
    }else{
        resultStr = [NSString stringWithFormat:@"%ld",(long)number];
    }
    return resultStr;
}

- (void)setUpdateData:(NSArray *)arra {
    todayNum.text = arra[0];
    weekNum.text = arra[1];
    monthNum.text = arra[2];
}

- (void)CreatView {
    todayPart = [[UIView alloc] init];
    todayNum = [[UILabel alloc] init];
    todayIcon = [[UIImageView alloc] init];
    todayTittle = [[UILabel alloc] init];
    lineView = [[UILabel alloc] init];
    sumPart = [[UIView alloc] init];
    weekNum = [[UILabel alloc] init];
    weekTittle = [[UILabel alloc] init];
    monthNum = [[UILabel alloc] init];
    monthTittle = [[UILabel alloc] init];
    bottomView = [[UILabel alloc] init];
    
    [self addSubview:todayPart];
    [self addSubview:sumPart];
    [self addSubview:lineView];
    [self addSubview:bottomView];
    [todayPart addSubview:todayNum];
    [todayPart addSubview:todayIcon];
    [todayPart addSubview:todayTittle];
    [sumPart addSubview:weekNum];
    [sumPart addSubview:weekTittle];
    [sumPart addSubview:monthNum];
    [sumPart addSubview:monthTittle];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    [todayPart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(ws);
        make.bottom.mas_equalTo(todayIcon.mas_bottom).offset(20 * autoSizeScaleH);
        make.width.mas_equalTo(175 * autoSizeScaleW);
    }];
    
    todayNum.textColor = customWhite;
    todayNum.font = FONT(26);
    [todayNum mas_makeConstraints:^(MASConstraintMaker *make) {
        if (SCREEN_WIDTH == 320) {
            make.top.mas_equalTo(5 * autoSizeScaleH);
        }else{
            make.top.mas_equalTo(todayPart).offset(20 * autoSizeScaleH);
        }
        make.left.mas_equalTo(todayPart).offset(50 * autoSizeScaleH);
    }];
    
    [todayIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(todayNum.mas_bottom).offset(10 * autoSizeScaleH);
        make.left.mas_equalTo(todayPart).offset(35 * autoSizeScaleW);
        make.width.height.mas_equalTo(15 * autoSizeScaleW);
    }];
    
    todayTittle.textColor = customWhite;
    todayTittle.font = FONT(12);
    [todayTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(todayIcon.mas_right).offset(5 * autoSizeScaleW);
        make.bottom.mas_equalTo(todayIcon);
    }];
    
    
    lineView.backgroundColor = customWhite;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(todayPart.mas_right);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(todayPart).offset(35 * autoSizeScaleH);
        make.bottom.mas_equalTo(todayPart).offset(-25 * autoSizeScaleH);
    }];
    
    [sumPart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_right);
        make.height.centerY.right.mas_equalTo(ws);
    }];
    
    weekTittle.textColor = customWhite;
    weekTittle.font = FONT(12);
    [weekTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sumPart).offset(25 * autoSizeScaleW);
        make.bottom.mas_equalTo(todayTittle);
    }];
    
    weekNum.textColor = customWhite;
    weekNum.font = FONT(16);
    [weekNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weekTittle);
        make.bottom.mas_equalTo(todayNum).offset(-2 * autoSizeScaleH);
    }];
    
    monthTittle.textColor = customWhite;
    monthTittle.font = FONT(12);
    [monthTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weekTittle.mas_right).offset(45 * autoSizeScaleW);
        make.bottom.mas_equalTo(weekTittle);
    }];
    
    monthNum.textColor = customWhite;
    monthNum.font = FONT(16);
    [monthNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(monthTittle);
        make.bottom.mas_equalTo(weekNum);
    }];
    
    bottomView.backgroundColor = [UIColor hexStringToColor:@"#27b064"];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(35 * autoSizeScaleW);
        make.right.mas_equalTo(ws).offset(-35 * autoSizeScaleW);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(ws);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(todayPart);
    }];
}


@end

@implementation MKToDoItemView      //代办事项
{
    UIImageView *toDoIcon;
    UILabel *toDoTittle;
    UIView *horizonLine;
    UIView *toDeliverView;
    UIImageView *deliverIcon;
    UILabel *deliverTittle;
    UILabel *deliverBadge;
    UIView *verticLine;
    UIView *toConfirmView;
    UIImageView *confirmIcon;
    UILabel *confirmTittle;
    UILabel *confirmBadge;
    
    MASConstraint *widthConstraint;
    MASConstraint *widthConstraint2;
}

- (instancetype)init {
    if(self == [super init]) {
        [self setShadowAndRadius];
    }
    return self;
}

- (void)setShadowAndRadius {
    self.backgroundColor = customWhite;
    self.layer.cornerRadius = 6.0;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(4, 4);
    self.layer.shadowOpacity = .6;
    self.layer.shadowRadius = 4;
}

- (void)setUpdateData:(NSArray *)data {
    deliverBadge.text = data[0];
    confirmBadge.text = data[1];
}

- (void)setUpdataDeliver:(NSInteger)deliver Confirm:(NSInteger)confirm {
    NSString *deliverStr = [self ConvertToString:deliver];
    deliverBadge.hidden = deliverStr.length == 0 ? YES : NO;
    if (deliverStr.length) {
        deliverBadge.text = [NSString stringWithFormat:@" %@ ",deliverStr];
    }
    NSString *confirmStr = [self ConvertToString:confirm];
    confirmBadge.hidden = confirmStr.length == 0 ? YES : NO;
    if (confirmStr.length) {
        confirmBadge.text = [NSString stringWithFormat:@" %@ ",confirmStr];
    }
}

- (NSString *)ConvertToString:(NSInteger)number {
    
    return number == 0 ? @"" : [NSString stringWithFormat:@" %ld ",(long)number];
}

- (void)setDelieryNum:(NSString *)deliveryNum {
    
    deliverBadge.text = deliveryNum;
}

- (void)setConfirmNum:(NSString *)confirmNum {
    
    confirmBadge.text = confirmNum;
}

- (void)CreatView {
    toDoIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeUpcoming"]];
    toDoTittle = [[UILabel alloc] init];
    horizonLine = [[UIView alloc] init];
    toDeliverView = [[UIView alloc] init];
    deliverIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeDeliver"]];
    deliverTittle = [[UILabel alloc] init];
    deliverBadge = [[UILabel alloc] init];
    verticLine = [[UIView alloc] init];
    toConfirmView = [[UIView alloc] init];
    confirmIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeConfirm"]];
    confirmTittle = [[UILabel alloc] init];
    confirmBadge = [[UILabel alloc] init];

    [self addSubview:toDoIcon];
    [self addSubview:toDoTittle];
    [self addSubview:horizonLine];
    [self addSubview:verticLine];
    [self addSubview:toDeliverView];
    [toDeliverView addSubview:deliverIcon];
    [toDeliverView addSubview:deliverTittle];
    [toDeliverView addSubview:deliverBadge];
    [self addSubview:toConfirmView];
    [toConfirmView addSubview:confirmIcon];
    [toConfirmView addSubview:confirmTittle];
    [toConfirmView addSubview:confirmBadge];
    
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    [toDoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws).offset(15 * autoSizeScaleH);
        make.left.mas_equalTo(ws).offset(20 * autoSizeScaleW);
        make.width.height.mas_equalTo(15 * autoSizeScaleW);
    }];
    
    toDoTittle.text = @"待办事务";
    toDoTittle.textColor = [UIColor hexStringToColor:@"#7A7A7A"];
    toDoTittle.font = FONT(12);
    [toDoTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(toDoIcon);
        make.left.mas_equalTo(toDoIcon.mas_right).offset(5 * autoSizeScaleW);
    }];
    
    horizonLine.backgroundColor = [UIColor hexStringToColor:@"#e7e7e7"];
    [horizonLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.top.mas_equalTo(toDoIcon.mas_bottom).offset(15 * autoSizeScaleH);
        make.height.mas_equalTo(1);
    }];
    
    [toDeliverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws);
        make.top.mas_equalTo(horizonLine);
        make.width.mas_equalTo(ws).multipliedBy(.5);
        make.bottom.mas_equalTo(deliverTittle).offset(15 * autoSizeScaleH);
    }];
    
    [deliverIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(toDeliverView);
        make.top.mas_equalTo(toDeliverView).offset(15 * autoSizeScaleH);
        make.width.height.mas_equalTo(30 * autoSizeScaleW);
    }];
    
    UIButton *deliverBtn = [[UIButton alloc] init];
    deliverBtn.tag = 1;
    [self addSubview:deliverBtn];
    [deliverBtn addTarget:self action:@selector(gotoOrderManage:) forControlEvents:UIControlEventTouchUpInside];
    [deliverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(toDeliverView);
        make.size.mas_equalTo(toDeliverView);
    }];
    
    deliverTittle.text = @"待发货";
    deliverTittle.font = FONT(12);
    deliverTittle.textColor = [UIColor hexStringToColor:@"#222222"];
    [deliverTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(deliverIcon);
        make.top.mas_equalTo(deliverIcon.mas_bottom).offset(5 * autoSizeScaleH);
    }];
    
    deliverBadge.hidden = YES;
    deliverBadge.backgroundColor = themeGreen;
    deliverBadge.font = FONT(12);
    deliverBadge.textColor = customWhite;
    deliverBadge.layer.cornerRadius = 6.0;
    deliverBadge.layer.masksToBounds = YES;
    [deliverBadge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(deliverIcon.mas_right).offset(-6 * autoSizeScaleW);
        make.bottom.mas_equalTo(deliverIcon.mas_top).offset(15 * autoSizeScaleH);
    }];
    
    verticLine.backgroundColor = [UIColor hexStringToColor:@"#e7e7e7"];
    [verticLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(toDeliverView.mas_right);
        make.top.mas_equalTo(toDeliverView).offset(20 * autoSizeScaleH);
        make.bottom.mas_equalTo(toDeliverView).offset(-20 * autoSizeScaleH);
        make.width.mas_equalTo(1);
    }];
    
    [toConfirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(toDeliverView.mas_right);
        make.size.centerY.mas_equalTo(toDeliverView);
    }];
    
    [confirmIcon addTapEventWith:self action:@selector(gotoOrderManage:)];
    [confirmIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(toConfirmView);
        make.centerY.mas_equalTo(deliverIcon);
        make.width.height.mas_equalTo(25 * autoSizeScaleW);
    }];
    
    UIButton *confirmBtn = [[UIButton alloc] init];
    confirmBtn.tag = 2;
    [self addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(gotoOrderManage:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(toConfirmView);
        make.size.mas_equalTo(toConfirmView);
    }];
    
    confirmTittle.text = @"待确认";
    confirmTittle.font = FONT(12);
    confirmTittle.textColor = [UIColor hexStringToColor:@"#222222"];
    [confirmTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(confirmIcon);
        make.centerY.mas_equalTo(deliverTittle);
    }];
    
    confirmBadge.hidden = YES;
    confirmBadge.backgroundColor = themeGreen;
    confirmBadge.font = FONT(12);
    confirmBadge.textColor = customWhite;
    confirmBadge.layer.cornerRadius = 5.0;
    confirmBadge.layer.masksToBounds = YES;
    [confirmBadge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(confirmIcon.mas_right).offset(-5 * autoSizeScaleW);
        make.centerY.mas_equalTo(deliverBadge);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(toDeliverView);
    }];
}

- (void)gotoOrderManage:(UIButton *)sender {
    UIViewController *parent = [self parentController];
    MKOrderManageController *controller = [[MKOrderManageController alloc] initWithTitle:@"订单管理"];
    controller.currentIndex = sender.tag == 1 ? 0 : 1;
    [parent.navigationController pushViewController:controller animated:YES];
}


@end
