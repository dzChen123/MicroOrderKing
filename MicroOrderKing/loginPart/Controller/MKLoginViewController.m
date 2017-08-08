//
//  MKLoginViewController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/25.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKLoginViewController.h"
#import "MKSignUpViewController.h"
#import "MKHomePageViewController.h"
#import "BaseNavigationController.h"

#import "MKLoginModel.h"

#define bgGrayColor [UIColor hexStringToColor:@"#F8F8F8"]

@interface MKLoginViewController ()<MDHTMLLabelDelegate>

@end

@implementation MKLoginViewController
{
    UIImageView *bgView;
    UIImageView *logoView;
    UIView *phoneView;
    UIView *pasdView;
    UIImageView *phoneIcon;
    UITextField *phoneField;
    UIImageView *pasdIcon;
    UITextField *pasdField;
    UIButton *loginBtn;
    UILabel *signUpLab;
    MDHTMLLabel *forgetLab;
}

- (void)viewDidLoad {
    self.topView.hidden = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)CreatView {
    bgView = [[UIImageView alloc] init];
    logoView = [[UIImageView alloc] init];
    phoneView = [[UIView alloc] init];
    pasdView = [[UIView alloc] init];
    phoneIcon = [[UIImageView alloc] init];
    phoneField = [[UITextField alloc] init];
    pasdIcon = [[UIImageView alloc] init];
    pasdField = [[UITextField alloc] init];
    loginBtn = [[UIButton alloc] init];
    signUpLab = [[UILabel alloc] init];
    forgetLab = [[MDHTMLLabel alloc] init];
    
    [self addSubview:bgView];
    [self addSubview:logoView];
    [self addSubview:phoneView];
    [self addSubview:pasdView];
    [self addSubview:loginBtn];
    [phoneView addSubview:phoneIcon];
    [self addSubview:phoneField];
    [pasdView addSubview:pasdIcon];
    [self addSubview:pasdField];
    [self addSubview:signUpLab];
    [self addSubview:forgetLab];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    bgView.image = [UIImage imageNamed:@"loginBg"];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(ws.view);
        make.center.mas_equalTo(ws.view);
    }];
    
    logoView.image = [UIImage imageNamed:@"logo"];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.top.mas_equalTo(bgView).offset(126 * autoSizeScaleH);
        make.width.height.mas_equalTo(70 * autoSizeScaleW);
    }];
    
    phoneView.backgroundColor = bgGrayColor;
    phoneView.cornerRadius = 5.0;
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView).offset(40 * autoSizeScaleW);
        make.right.mas_equalTo(bgView).offset(- 40 * autoSizeScaleW);
        make.top.mas_equalTo(logoView.mas_bottom).offset(35 * autoSizeScaleH);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    phoneIcon.image = [UIImage imageNamed:@"loginPhone"];
    [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(phoneView);
        make.left.mas_equalTo(phoneView).offset(20 * autoSizeScaleW);
        make.width.height.mas_equalTo(15 * autoSizeScaleW);
    }];
    
    phoneField.placeholder = @"请输入手机号";
    phoneField.font = FONT(14);
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.clearButtonMode = UITextFieldViewModeAlways;
    [phoneField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    [phoneField setValue:[UIColor hexStringToColor:@"#C6C6C6"] forKeyPath:@"_placeholderLabel.textColor"];
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(phoneView);
        make.left.mas_equalTo(phoneIcon.mas_right).offset(leftPadding);
        make.right.mas_equalTo(phoneView).offset(rightPadding);
    }];
    
    pasdView.backgroundColor = bgGrayColor;
    pasdView.cornerRadius = 5.0;
    [pasdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(phoneView);
        make.top.mas_equalTo(phoneView.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    pasdIcon.image = [UIImage imageNamed:@"loginPasd"];
    [pasdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(pasdView);
        make.size.left.mas_equalTo(phoneIcon);
    }];
    
    pasdField.placeholder = @"请输入密码";
    pasdField.font = FONT(14);
    pasdField.secureTextEntry = YES;
    pasdField.clearButtonMode = UITextFieldViewModeAlways;
    [pasdField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    [pasdField setValue:[UIColor hexStringToColor:@"#C6C6C6"] forKeyPath:@"_placeholderLabel.textColor"];
    [pasdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(pasdView);
        make.size.left.mas_equalTo(phoneField);
    }];
    
    loginBtn.cornerRadius = 5.0;
    loginBtn.backgroundColor = themeGreen;
    loginBtn.titleLabel.textColor = [UIColor whiteColor];
    loginBtn.titleLabel.font = FONT(16);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pasdView.mas_bottom).offset(15 * autoSizeScaleH);
        make.width.centerX.mas_equalTo(pasdView);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    signUpLab.text = @"用户注册";
    signUpLab.font = FONT(14);
    signUpLab.textColor = [UIColor hexStringToColor:@"#707070"];
    signUpLab.userInteractionEnabled = YES;
    [signUpLab addTapEventWith:self action:@selector(goToSignUp)];
    [signUpLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(loginBtn);
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(20 * autoSizeScaleH);
    }];
    
    forgetLab.delegate = self;
    NSString *signStr = [NSString stringWithFormat:@"<a href='#' style='text-decoration:underline;'>忘记密码</a>"];
    forgetLab.htmlText = signStr;
    forgetLab.linkAttributes = @{NSForegroundColorAttributeName:[UIColor hexStringToColor:@"#737373"],
                                 NSFontAttributeName:FONT(14),
                                 NSUnderlineColorAttributeName:[UIColor hexStringToColor:@"#737373"],
                                 NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)};
    [forgetLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(loginBtn);
        make.bottom.mas_equalTo(signUpLab);
    }];
    
    [super updateViewConstraints];
}

- (void)goToSignUp {
    MKSignUpViewController *controller = [[MKSignUpViewController alloc] initWithType:0];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)HTMLLabel:(MDHTMLLabel *)label didSelectLinkWithURL:(NSURL *)URL {
    MKSignUpViewController *controller = [[MKSignUpViewController alloc] initWithType:1];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)login {
    if ([phoneField.text isEqualToString:@""]) {
        [self.hud showTipMessageAutoHide:@"请填写手机号"];
        return;
    }
    if ([pasdField.text isEqualToString:@""]) {
        [self.hud showTipMessageAutoHide:@"请填写密码"];
        return;
    }
    [self.hud showWaitHudWithMessage:@"登录中,请耐心等待..."];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:phoneField.text forKey:@"username"];
    [plist setObject:[pasdField.text md5String] forKey:@"password"];
    [plist setObject:@"iphone" forKey:@"device_type"];
    [AFNetWorkingUsing httpPost:@"user/public/login" params:plist success:^(id json) {
        MKHttpLoginModel *model =  [MKHttpLoginModel mj_objectWithKeyValues:json];
        [ZYFUserDefaults setBool:YES key:@"loginFlag"];
        [ZYFUserDefaults setObject:model.data.token key:@"token"];
        [ZYFUserDefaults setObject:model.data.parent_id key:@"parentId"];
        [ZYFUserDefaults setObject:pasdField.text key:@"pasd"];
        [self.hud hideAnimated:YES];
        [self goToHomePage];
    } fail:^(NSError *error) {
        [self.hud hideAnimated:YES];
    } other:^(id json) {
        [self.hud hideAnimated:YES];
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)goToHomePage {
    BaseNavigationController *controller = [[BaseNavigationController alloc] initWithRootViewController:[[MKHomePageViewController alloc] init]];
    [self Diss:controller];
}

- (void)Diss:(UIViewController *)controller {
    NSString *key = @"transition";
    CATransition *transition = [CATransition animation];
    transition.duration = .6;
    transition.type = kCATransitionFade;
    transition.removedOnCompletion = YES;
    [[UIApplication sharedApplication].delegate window].rootViewController = controller;
    [[[UIApplication sharedApplication].delegate window].layer addAnimation:transition forKey:key];
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
