//
//  MKSignUpViewController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/26.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKSignUpViewController.h"

@interface MKSignUpViewController ()

@end

@implementation MKSignUpViewController
{
    UIView *phoneView;
    UITextField *phoneField;
    UIView *vertifyView;
    UITextField *vertifyField;
    UIButton *vertifyBtn;
    UIView *nameView;
    UITextField *nameField;
    UIView *pasdView;
    UITextField *pasdField;
    UIView *confirmView;
    UITextField *confirmField;
    UIButton *signUpBtn;
    
    NSTimer *timer;
    NSInteger timeOut;
    NSInteger _type;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithType:(NSInteger)type {      //0  注册  1    重置密码
    _type = type;
    self = [super init];
    return self;
}

- (void)setTopView {
    [super setTopView];
    self.topTitle = _type == 0 ? @"注册" : @"重置密码";
}

- (void)CreatView {
    phoneView = [[UIView alloc] init];
    phoneField = [[UITextField alloc] init];
    vertifyView = [[UIView alloc] init];
    vertifyField = [[UITextField alloc] init];
    vertifyBtn = [[UIButton alloc] init];
    nameView = [[UIView alloc] init];
    nameField = [[UITextField alloc] init];
    pasdView = [[UIView alloc] init];
    pasdField = [[UITextField alloc] init];
    confirmView = [[UIView alloc] init];
    confirmField = [[UITextField alloc] init];
    signUpBtn = [[UIButton alloc] init];
    
    [self addSubview:phoneView];
    [self addSubview:vertifyView];
    [self addSubview:pasdView];
    [self addSubview:confirmView];
    [self addSubview:nameView];
    [self addSubview:nameField];
    [self addSubview:signUpBtn];
    [self addSubview:phoneField];
    [self addSubview:vertifyField];
    [vertifyView addSubview:vertifyBtn];
    [self addSubview:pasdField];
    [self addSubview:confirmField];
}

- (void)updateViewConstraints{
    WS(ws)
    
    phoneView.backgroundColor = [UIColor whiteColor];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.mas_equalTo(ws.view);
        make.top.mas_equalTo(ws.topView.mas_bottom).offset(15 * autoSizeScaleH);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    phoneField.placeholder = @"请输入手机号";
    phoneField.font = FONT(14);
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.clearButtonMode = UITextFieldViewModeAlways;
    [phoneField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    [phoneField setValue:[UIColor hexStringToColor:@"#C6C6C6"] forKeyPath:@"_placeholderLabel.textColor"];
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(phoneView);
        make.left.mas_equalTo(phoneView).offset(leftPadding);
        make.right.mas_equalTo(phoneView).offset(rightPadding);
    }];
    
    vertifyView.backgroundColor = [UIColor whiteColor];
    [vertifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(phoneView);
        make.top.mas_equalTo(phoneView.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    [vertifyBtn addTarget:self action:@selector(getVertifyCode) forControlEvents:UIControlEventTouchUpInside];
    [vertifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    vertifyBtn.backgroundColor = themeGreen;
    vertifyBtn.titleLabel.textColor = [UIColor whiteColor];
    vertifyBtn.titleLabel.font = FONT(14);
    [vertifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.right.centerY.mas_equalTo(vertifyView);
        make.width.mas_equalTo(110 * autoSizeScaleW);
    }];
    
    vertifyField.placeholder = @"请输入验证码";
    vertifyField.font = FONT(14);
    vertifyField.keyboardType = UIKeyboardTypeNumberPad;
    vertifyField.clearButtonMode = UITextFieldViewModeAlways;
    [vertifyField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    [vertifyField setValue:[UIColor hexStringToColor:@"#C6C6C6"] forKeyPath:@"_placeholderLabel.textColor"];
    [vertifyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(vertifyView);
        make.left.mas_equalTo(vertifyView).offset(leftPadding);
        make.right.mas_equalTo(vertifyBtn.mas_left).offset(rightPadding);
    }];
    
    if (!_type) {
        nameView.backgroundColor = customWhite;
        [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.centerX.mas_equalTo(phoneView);
            make.top.mas_equalTo(vertifyView.mas_bottom).offset(15 * autoSizeScaleH);
        }];
        
        nameField.placeholder = @"请输入姓名";
        nameField.font = FONT(14);
        nameField.clearButtonMode = UITextFieldViewModeAlways;
        [nameField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
        [nameField setValue:[UIColor hexStringToColor:@"#C6C6C6"] forKeyPath:@"_placeholderLabel.textColor"];
        [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.centerX.mas_equalTo(phoneField);
            make.centerY.mas_equalTo(nameView);
        }];
        
    }else {
        [nameView removeFromSuperview];
        [nameField removeFromSuperview];
    }
    
    pasdView.backgroundColor = [UIColor whiteColor];
    [pasdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(vertifyView);
        if (!_type) {
            make.top.mas_equalTo(nameView.mas_bottom).offset(15 * autoSizeScaleH);
        }else{
            make.top.mas_equalTo(vertifyView.mas_bottom).offset(15 * autoSizeScaleH);
        }
    }];
    
    pasdField.placeholder = @"请输入密码";
    pasdField.font = FONT(14);
    pasdField.clearButtonMode = UITextFieldViewModeAlways;
    [pasdField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    [pasdField setValue:[UIColor hexStringToColor:@"#C6C6C6"] forKeyPath:@"_placeholderLabel.textColor"];
    [pasdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(phoneField);
        make.centerY.mas_equalTo(pasdView);
    }];
    
    confirmView.backgroundColor = [UIColor whiteColor];
    [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(pasdView);
        make.top.mas_equalTo(pasdView.mas_bottom).offset(1);
    }];
    
    confirmField.placeholder = @"请确认密码";
    confirmField.font = FONT(14);
    confirmField.clearButtonMode = UITextFieldViewModeAlways;
    [confirmField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    [confirmField setValue:[UIColor hexStringToColor:@"#C6C6C6"] forKeyPath:@"_placeholderLabel.textColor"];
    [confirmField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(pasdField);
        make.centerY.mas_equalTo(confirmView);
    }];
    
    signUpBtn.cornerRadius = 5.0;
    [signUpBtn setTitle:_type == 0 ? @"注册" : @"重置密码" forState:UIControlStateNormal];
    [signUpBtn addTarget:self action:@selector(signUpOrChangePasd) forControlEvents:UIControlEventTouchUpInside];
    signUpBtn.backgroundColor = themeGreen;
    signUpBtn.titleLabel.textColor = [UIColor whiteColor];
    signUpBtn.titleLabel.font = FONT(16);
    [signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(confirmView.mas_bottom).offset(15 * autoSizeScaleH);
        make.width.centerX.mas_equalTo(confirmField);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    [super updateViewConstraints];
}

- (void)getVertifyCode {
    if (!phoneField.text.length) {
        [self.hud showTipMessageAutoHide:@"请先填写手机号"];
        return;
    }
    [self.hud showWaitHudWithMessage:@"正在获取..."];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:phoneField.text forKey:@"username"];
    [plist setObject: !_type ? @"0" : @"1" forKey:@"reset"];
    [AFNetWorkingUsing httpPost:@"user/verification_code/api_send" params:plist success:^(id json) {
        [self.hud hideAnimated:YES];
        timeOut = 60;
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [timer fire];
    } fail:^(NSError *error) {
        [self.hud hideAnimated:YES];
    } other:^(id json) {
        [self.hud hideAnimated:YES];
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)countDown {
    if (timeOut > 1) {
        timeOut --;
        vertifyBtn.enabled = NO;
        [vertifyBtn setTitle:[NSString stringWithFormat:@"%ld秒",timeOut] forState:UIControlStateNormal];
    }else{
        [timer invalidate];
        vertifyBtn.enabled = YES;
        [vertifyBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    }
}

- (void)signUpOrChangePasd {
    if (!phoneField.text.length) {
        [self.hud showTipMessageAutoHide:@"请先填写手机号"];
        return;
    }
    if (!vertifyField.text.length) {
        [self.hud showTipMessageAutoHide:@"请先获取验证码"];
        return;
    }
    if (_type == 0 && !nameField.text.length) {
        [self.hud showTipMessageAutoHide:@"请先填写姓名"];
    }
    if (!pasdField.text.length) {
        [self.hud showTipMessageAutoHide:@"请先填写密码"];
        return;
    }
    if (!confirmField.text.length) {
        [self.hud showTipMessageAutoHide:@"请先确认密码"];
        return;
    }
    if (![pasdField.text isEqualToString:confirmField.text]) {
        [self.hud showTipMessageAutoHide:@"两次填写的密码不一致，请重新填写"];
        return;
    }
    NSString *waitStr = _type == 0 ? @"注册中,请耐心等待..." : @"密码重置中,请耐心等待...";
    NSString *succeedStr = _type == 0 ? @"注册成功" : @"重置成功";
    NSString *requestStr = _type == 0 ? @"user/public/register" : @"user/public/passwordReset";
    [self.hud showWaitHudWithMessage:waitStr];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:phoneField.text forKey:@"username"];
    [plist setObject:[pasdField.text md5String] forKey:@"password"];
    if (!_type) {
         [plist setObject:nameField.text forKey:@"user_nickname"];   
    }
    [plist setObject:vertifyField.text forKey:@"verification_code"];
    [AFNetWorkingUsing httpPost:requestStr params:plist success:^(id json) {
        [self.hud hideAnimated:YES];
        [self.hud showTipMessageAutoHide:succeedStr];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        [self.hud hideAnimated:YES];
    } other:^(id json) {
        [self.hud hideAnimated:YES];
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
