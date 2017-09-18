//
//  MKReceiverInfoView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKReceiverInfoView.h"

#define holderColor [UIColor hexStringToColor:@"#D7D7D8"]

@implementation MKReceiverInfoView
{
    UILabel *receiverLab;
    UIView *whiteView;
    UILabel *nameTittle;
    UITextField *nameField;
    UIView *lineView1;
    UILabel *phoneTittle;
    UITextField *phoneField;
    UIView *lineView2;
    UILabel *addreTittle;
    UIButton *addreButn;
    UITextView *addreView;
    
    NSString *placeHolder;
    NSString *addressStr;
}

- (void)CreatView {
    receiverLab = [[UILabel alloc] init];
    whiteView = [[UIView alloc] init];
    nameTittle = [[UILabel alloc] init];
    nameField = [[UITextField alloc] init];
    lineView1 = [[UILabel alloc] init];
    phoneTittle = [[UILabel alloc] init];
    phoneField = [[UITextField alloc] init];
    lineView2 = [[UILabel alloc] init];
    addreTittle = [[UILabel alloc] init];
    addreButn = [[UIButton alloc] init];
    addreView = [[UITextView alloc] init];
    
    [self addSubview:receiverLab];
    [self addSubview:whiteView];
    [whiteView addSubview:nameTittle];
    [whiteView addSubview:nameField];
    [whiteView addSubview:lineView1];
    [whiteView addSubview:phoneTittle];
    [whiteView addSubview:phoneField];
    [whiteView addSubview:lineView2];
    [whiteView addSubview:addreTittle];
    [whiteView addSubview:addreButn];
    [whiteView addSubview:addreView];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    addressStr = @"";
    
    receiverLab.text = @"收货信息";
    receiverLab.textColor = [UIColor hexStringToColor:@"#A7A8AA"];
    receiverLab.font = FONT(14);
    [receiverLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.top.mas_equalTo(ws).offset(15 * autoSizeScaleH);
    }];
    
    whiteView.backgroundColor = [UIColor whiteColor];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws);
        make.top.mas_equalTo(receiverLab.mas_bottom).offset(10 * autoSizeScaleH);
        make.bottom.mas_equalTo(addreView).offset(20 * autoSizeScaleH);
    }];

    nameTittle.text = @"收货人";
    [nameTittle sizeToFit];
    nameTittle.textColor = [UIColor hexStringToColor:@"#6E6E6E"];
    nameTittle.font = FONT(14);
    [nameTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(receiverLab);
        make.top.mas_equalTo(whiteView).offset(15 * autoSizeScaleH);
    }];

    nameField.placeholder = @"请输入收件人姓名";
    nameField.font = FONT(14);
    nameField.textColor = [UIColor hexStringToColor:@"#5A5A5A"];
    nameField.clearButtonMode = UITextFieldViewModeAlways;
    [nameField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    [nameField setValue:holderColor forKeyPath:@"_placeholderLabel.textColor"];
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nameTittle);
        make.height.mas_equalTo(45 * autoSizeScaleH);
        make.left.mas_equalTo(whiteView).offset(85 * autoSizeScaleW);
        make.right.mas_equalTo(whiteView).offset(rightPadding);
    }];

    lineView1.backgroundColor = VIEWBACKGRAY;
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(nameField);
        make.top.mas_equalTo(nameField.mas_bottom);
        make.height.mas_equalTo(1);
    }];

    phoneTittle.text = @"联系方式";
    phoneTittle.textColor = [UIColor hexStringToColor:@"#6E6E6E"];
    phoneTittle.font = FONT(14);
    [phoneTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameTittle);
        make.top.mas_equalTo(lineView1).offset(15 * autoSizeScaleH);
    }];

    phoneField.placeholder = @"请输入手机号";
    phoneField.font = FONT(14);
    phoneField.delegate = self;
    phoneField.textColor = [UIColor hexStringToColor:@"#5A5A5A"];
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.clearButtonMode = UITextFieldViewModeAlways;
    [phoneField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    [phoneField setValue:holderColor forKeyPath:@"_placeholderLabel.textColor"];
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(phoneTittle);
        make.size.centerX.mas_equalTo(nameField);
    }];

    lineView2.backgroundColor = VIEWBACKGRAY;
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(lineView1);
        make.top.mas_equalTo(phoneField.mas_bottom);
    }];
    
    addreTittle.text = @"收货地址";
    addreTittle.textColor = [UIColor hexStringToColor:@"#6E6E6E"];
    addreTittle.font = FONT(14);
    [addreTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameTittle);
        make.top.mas_equalTo(lineView2).offset(15 * autoSizeScaleH);
    }];
    
    [addreButn setImage:[[UIImage imageNamed:@"enorderAddre"] imageByScalingToSize:CGSizeMake(25 * autoSizeScaleW,25 * autoSizeScaleW)] forState:UIControlStateNormal];
    [addreButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(addreTittle);
        make.top.mas_equalTo(addreTittle.mas_bottom).offset(15 * autoSizeScaleH);
        make.width.height.mas_equalTo(25 * autoSizeScaleW);
    }];

    placeHolder = @"请输入收货地址";
    addreView.text  =placeHolder;
    addreView.textColor = holderColor;
    addreView.font = FONT(14);
    addreView.delegate = self;
    [addreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(phoneField);
        make.top.mas_equalTo(addreTittle).offset(-7 * autoSizeScaleH);
        make.height.mas_equalTo(75 * autoSizeScaleH);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(whiteView);
    }];
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
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
        addressStr = textView.text;
    }
}

- (void)setReceiverInfo:(NSString *)name Phone:(NSString *)phone Address:(NSString *)address {
    
    nameField.text = name;
    
    phoneField.text = phone;
    phoneField.enabled = NO;
    phoneField.clearButtonMode = UITextFieldViewModeNever;
    
    addreView.text = address;
    addreView.textColor = wordThreeColor;
    addressStr = address;
}

- (void)setInfoPhoneNum:(NSString *)phoneNum {
    
    phoneField.text = phoneNum;
    phoneField.enabled = NO;
    phoneField.clearButtonMode = UITextFieldViewModeNever;
}

- (NSArray *)getReceiverInfo {
    return @[nameField.text,phoneField.text,addressStr];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
