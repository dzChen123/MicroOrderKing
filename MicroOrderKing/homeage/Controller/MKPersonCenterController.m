//
//  MKPersonCenterController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/1.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKPersonCenterController.h"
#import "MKChangePasdController.h"
#import "MKLoginViewController.h"
#import "MKAppInfoController.h"
#import "BaseNavigationController.h"

#import "MKPersonInfoView.h"
#import "MKSignOutView.h"

#import "MKPersonModel.h"

@interface MKPersonCenterController ()

@end

@implementation MKPersonCenterController
{
    MKPersonInfoView *personInfoView;
    
    UIView *contentView;            //做出密码修改  和  关于微单王 的圆角
    MKChangePasdView *changeView;
    MKChangePasdView *aboutInfoView;
    
    UIButton *signOutButn;
    UIView *maskView;
    MKSignOutView *signOutView;
    
    MASConstraint *bottomConstraint;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(ws)
    signOutView.cancelBlock =^(){
        [ws cancel];
    };
    signOutView.confirmBlock =^(){
        [ws signOut];
    };
    
    [self signOutViewLayOutSetting];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)setTopView {
    [super setTopView];
    self.topTitle = @"个人中心";
    if (_isOut) {
        self.topView.leftButton.hidden = YES;
    }
}

- (void)CreatView {
    personInfoView = [[MKPersonInfoView alloc] init];
    contentView = [[UIView alloc] init];
    changeView = [[MKChangePasdView alloc] initWithTitle:@"密码修改" AndImage:@"personPasd"];
    aboutInfoView = [[MKChangePasdView alloc] initWithTitle:@"关于微单王" AndImage:@"personCenterInfo"];
    signOutButn = [[UIButton alloc] init];
    maskView = [[UIView alloc] init];
    signOutView = [[MKSignOutView alloc] init];
    
    [self addSubview:personInfoView];
    [self addSubview:contentView];
    [contentView addSubview:changeView];
    [contentView addSubview:aboutInfoView];
    [self addSubview:signOutButn];
    [self addSubview:maskView];
    [self addSubview:signOutView];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [personInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).offset(leftPadding);
        make.right.mas_equalTo(ws.view).offset(rightPadding);
        make.top.mas_equalTo(ws.topView.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    contentView.cornerRadius = 5.0;
    contentView.layer.masksToBounds = YES;
    contentView.clipsToBounds = YES;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(personInfoView);
        make.top.mas_equalTo(personInfoView.mas_bottom).offset(15 * autoSizeScaleH);
        make.bottom.mas_equalTo(aboutInfoView);
    }];
    
    [changeView addTapEventWith:self action:@selector(gotoChangePasd)];
    [changeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(contentView);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    [aboutInfoView addTapEventWith:self action:@selector(goToAppInfoController)];
    [aboutInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.mas_equalTo(changeView);
        make.top.mas_equalTo(changeView.mas_bottom).offset(1);
    }];
    
    signOutButn.layer.masksToBounds = YES;
    signOutButn.layer.cornerRadius = 6.0;
    signOutButn.backgroundColor = customWhite;
    [signOutButn addTarget:self action:@selector(goToSignOut) forControlEvents:UIControlEventTouchUpInside];
    [signOutButn setTitle:@"退出登录" forState:UIControlStateNormal];
    [signOutButn setTitleColor:[UIColor hexStringToColor:@"#F88489"] forState:UIControlStateNormal];
    signOutButn.titleLabel.font = FONT(16);
    [signOutButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(changeView);
        make.top.mas_equalTo(contentView.mas_bottom).offset(15 * autoSizeScaleH);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    [maskView addTapEventWith:self action:@selector(cancel)];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(ws.view);
        make.size.mas_equalTo(ws.view);
    }];
    
    [super updateViewConstraints];
    
}

- (void)signOutViewLayOutSetting {
    
    WS(ws)
    
    maskView.alpha = 0;
    maskView.hidden = YES;
    [self.view sendSubviewToBack:maskView];
    
    [signOutView mas_makeConstraints:^(MASConstraintMaker *make) {
        bottomConstraint = make.bottom.mas_equalTo(ws.view).offset(180 * autoSizeScaleH);
        make.left.right.mas_equalTo(ws.view);
    }];
}

- (void)goToSignOut {
    WS(ws)
    [self.view bringSubviewToFront:maskView];
    [self.view bringSubviewToFront:signOutView];
    [bottomConstraint uninstall];
    maskView.hidden = NO;
    [signOutView mas_makeConstraints:^(MASConstraintMaker *make) {
        bottomConstraint = make.bottom.mas_equalTo(ws.view);
    }];
    [UIView animateWithDuration:.3 animations:^{
        maskView.alpha = 1;
        [self.view layoutIfNeeded];
    }];

}

- (void)cancel {
    WS(ws)
    [bottomConstraint uninstall];
    [signOutView mas_makeConstraints:^(MASConstraintMaker *make) {
        bottomConstraint = make.bottom.mas_equalTo(ws.view).offset(180 * autoSizeScaleH);
    }];
    [UIView animateWithDuration:.3 animations:^{
        maskView.alpha = 0;
        [ws.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        maskView.hidden = YES;
        [ws.view sendSubviewToBack:maskView];
    }];
}

- (void)gotoChangePasd {
    MKChangePasdController *controller = [[MKChangePasdController alloc] initWithTitle:@"修改密码"];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)goToAppInfoController {
    MKAppInfoController *controller = [[MKAppInfoController alloc] initWithTitle:@"关于微单王"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)loadData {     
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:@"user/public/userInfo" params:plist success:^(id json) {
        MKPersonModel *model = [MKPersonHttpModel mj_objectWithKeyValues:json].data;
        [personInfoView setData:model];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)signOut {
    [self.hud showWait];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:@"user/public/logout" params:plist success:^(id json) {
        [self.hud hideAnimated:YES];
        [ZYFUserDefaults removeObjectForKey:@"pasd"];
        [ZYFUserDefaults setBool:NO key:@"loginFlag"];
        [ZYFUserDefaults removeObjectForKey:@"token"];
        [ZYFUserDefaults removeObjectForKey:@"parentId"];
        NSString *key = @"transition";
        CATransition *transition=[CATransition animation];
        //动画时长
        transition.duration=0.6;
        //动画类型wodou
        transition.type=kCATransitionFade;
        transition.removedOnCompletion = YES;
        MKLoginViewController *vc =[[MKLoginViewController alloc] init];
        [UIApplication sharedApplication].delegate.window.rootViewController = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [[UIApplication sharedApplication].delegate.window.layer addAnimation:transition forKey:key];
    } fail:^(NSError *error) {
        [self.hud hideAnimated:YES];
    } other:^(id json) {
        [self.hud hideAnimated: YES];
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
