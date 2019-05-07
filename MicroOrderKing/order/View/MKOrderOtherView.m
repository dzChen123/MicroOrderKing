//
//  MKOrderOtherView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKOrderOtherView.h"

#define holderColor [UIColor hexStringToColor:@"#D7D7D8"]

@implementation MKOrderOtherView
{
    UILabel *remarkTittle;
    UIView *whiteView;
    UITextView *remarkView;
    UIView *whiteView2;
    UILabel *paidTittle;
    UISwitch *switchButn;
    UIButton *confirmButn;
    UIButton *deleteButn;
    MKOrderOptionView *timeChoiceView;
    MKOrderOptionView *deliverChoiceView;
    
    NSInteger _type;
    NSString *placeHolder;
    NSString *remark;
}

- (instancetype)initWithType:(NSInteger)type {      //0 录入订单  1保存
    _type = type;
    self = [super init];
    return  self;
}

- (void)CreatView {
    remarkTittle = [[UILabel alloc] init];
    whiteView = [[UIView alloc] init];
    remarkView = [[UITextView alloc] init];
    whiteView2 = [[UIView alloc] init];
    paidTittle = [[UILabel alloc] init];
    switchButn = [[UISwitch alloc] init];
    confirmButn = [[UIButton alloc] init];
    deleteButn = [[UIButton alloc] init];
    
    timeChoiceView = [[MKOrderOptionView alloc] initWithTitle:@"发货时间选择" AndContent:[self getCurrentDate]];
    deliverChoiceView = [[MKOrderOptionView alloc] initWithTitle:@"配送方式选择" AndContent:@"请选择配送方式"];
    
    [self addSubview:remarkTittle];
    [self addSubview:whiteView];
    [self addSubview:whiteView2];
    [self addSubview:confirmButn];
    [self addSubview:deleteButn];
    [self addSubview:timeChoiceView];
    [self addSubview:deliverChoiceView];
    [whiteView addSubview:remarkView];
    [whiteView2 addSubview:paidTittle];
    [whiteView2 addSubview:switchButn];
    
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    remark = @"";
    
    remarkTittle.text = @"备注信息";
    remarkTittle.font = FONT(14);
    remarkTittle.textColor = [UIColor hexStringToColor:@"#A7A8AA"];
    [remarkTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.top.mas_equalTo(ws).offset(15 * autoSizeScaleH);
    }];
    
    whiteView.backgroundColor = customWhite;
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws);
        make.top.mas_equalTo(remarkTittle.mas_bottom).offset(15 * autoSizeScaleH);
        make.height.mas_equalTo(120 * autoSizeScaleH);
    }];
    
    placeHolder = @"需要写点什么...";
    remarkView.text  =placeHolder;
    remarkView.textColor = holderColor;
    remarkView.font = FONT(14);
    remarkView.delegate = self;
    [remarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(whiteView);
        make.left.mas_equalTo(whiteView).offset(5 * autoSizeScaleW);
        make.right.mas_equalTo(whiteView).offset(-5 * autoSizeScaleW);
    }];
    
    whiteView2.backgroundColor = customWhite;
    [whiteView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(whiteView);
        make.top.mas_equalTo(whiteView.mas_bottom).offset(15 * autoSizeScaleH);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    paidTittle.text = @"会员已付款";
    paidTittle.font = FONT(14);
    paidTittle.textColor = [UIColor hexStringToColor:@"#A4A4A4"];
    [paidTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(whiteView2).offset(leftPadding);
        make.centerY.mas_equalTo(whiteView2);
    }];
    
    [switchButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(whiteView2).offset(rightPadding);
        make.centerY.mas_equalTo(whiteView2);
        make.size.mas_equalTo(CGSizeMake(50 * autoSizeScaleW, 30 * autoSizeScaleH));
    }];
    
    [timeChoiceView addTapEventWith:self action:@selector(timeChoiceClick)];
    [timeChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws);
        make.top.mas_equalTo(whiteView2.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    [deliverChoiceView addTapEventWith:self action:@selector(deliverClick)];
    [deliverChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws);
        make.top.mas_equalTo(timeChoiceView.mas_bottom).offset(1);
    }];
    
    confirmButn.backgroundColor = themeGreen;
    [confirmButn setTitle: _type == 0 ? @"录入订单" : @"保存" forState: UIControlStateNormal];
    [confirmButn addTarget:self action:@selector(confirmButnClick) forControlEvents:UIControlEventTouchUpInside];
    confirmButn.titleLabel.textColor = customWhite;
    confirmButn.titleLabel.font = FONT(16);
    [confirmButn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (!_type) {
             make.left.right.mas_equalTo(ws);
        } else {
            make.width.mas_equalTo(ws).multipliedBy(.5);
            make.right.mas_equalTo(ws);
        }
        make.top.mas_equalTo(deliverChoiceView.mas_bottom).offset(15 * autoSizeScaleH);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    if (_type) {
        deleteButn.backgroundColor = [UIColor hexStringToColor:@"#cccccc"];
        [deleteButn setTitle: @"删除" forState: UIControlStateNormal];
        [deleteButn addTarget:self action:@selector(deleteButnClick) forControlEvents:UIControlEventTouchUpInside];
        deleteButn.titleLabel.textColor = customWhite;
        deleteButn.titleLabel.font = FONT(16);
        [deleteButn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.centerY.mas_equalTo(confirmButn);
            make.left.mas_equalTo(ws);
        }];
    }else{
    
    }
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(confirmButn);
    }];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:placeHolder]) {
        textView.text = @"";
        textView.textColor = wordThreeColor;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(textView.text.length < 1) {
        textView.text = placeHolder;
        textView.textColor = holderColor;
    }else{
        remark = textView.text;
    }
}

- (NSArray *)getOrderOtherInfo {
    return @[remark,@(switchButn.isOn)];
}

- (void)setOrderOtherInfo:(NSString *)remarkStr IsPaid:(BOOL)isPaid {
    [switchButn setOn:isPaid];
    if (remarkStr.length) {
        remarkView.text = remarkStr;
        remarkView.textColor = wordThreeColor;
        remark = remarkStr;
    }
    
}

- (void)confirmButnClick {
    if (_confirmButnBlock) {
        _confirmButnBlock();
    }
}

- (void)deleteButnClick {
    if (_deleteButnBlock) {
        _deleteButnBlock();
    }
}

- (void)deliverClick {
    if (_deliverChoiceBlock) {
        _deliverChoiceBlock();
    }
}

- (void)timeChoiceClick {
    if (_timeChoiceBlock) {
        _timeChoiceBlock();
    }
}

- (NSString *)getCurrentDate {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd号"];
    return [formatter stringFromDate:[NSDate date]];
}

- (void)setDeliverStr:(NSString *)deliver { deliverChoiceView.title = deliver; }

- (void)setDateStr:(NSString *)date { timeChoiceView.title = date; }

@end

@implementation MKOrderOptionView
{
    UILabel *titleLab;
    UILabel *contentLab;
    UIImageView *narrowView;
    UIPickerView *_pickerView;
    
    NSString *_title;
    NSString *_content;
}

- (instancetype)initWithTitle:(NSString *)title AndContent:(NSString *)content {

    _title = title;
    _content = content;
    
    self = [super init];
    
    return self;
}

- (void)CreatView {
    
    titleLab = [[UILabel alloc] init];
    contentLab = [[UILabel alloc] init];
    narrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"subactArrow"]];
    
    [self addSubview:titleLab];
    [self addSubview:contentLab];
    [self addSubview:narrowView];
}

- (void)SettingViewAttributes {
    
    WS(ws)

    self.backgroundColor = customWhite;
    
    titleLab.text  =_title;
    titleLab.textColor = wordSixColor;
    titleLab.font = FONT(14);
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.centerY.mas_equalTo(ws);
    }];
    
    [narrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.centerY.mas_equalTo(ws);
        make.width.height.mas_equalTo(15 * autoSizeScaleW);
    }];
    
    contentLab.text = _content;
    contentLab.textColor = wordThreeColor;
    contentLab.font = FONT(14);
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(narrowView.mas_left).offset(rightPadding);
        make.centerY.mas_equalTo(ws);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
}

- (void)setTitle:(NSString *)title {
    
    contentLab.text = title;
    _title = title;
}



@end


