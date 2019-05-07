//
//  MKChangePasdController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/1.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKChangePasdController.h"
#import "MKLoginViewController.h"
#import "BaseNavigationController.h"

#import "MKTittleTextView.h"

@interface MKChangePasdController ()

@end

@implementation MKChangePasdController
{
    NSMutableArray *textViewArray;
    UIButton *saveButn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)CreatView {
    textViewArray = [[NSMutableArray alloc] init];
    NSArray *holderArra = @[@"当前密码",@"请输入新密码",@"重复密码"];
    for (int count = 0; count < 3; count ++) {
        MKTextViewModel *model = [[MKTextViewModel alloc] init];
        model.superView = self.view;
        model.type = 0;
        model.isPasd = YES;
        model.placeHolder = holderArra[count];
        MKTittleTextView *textView = [[MKTittleTextView alloc] initWithModel:model];
        [textViewArray addObject:textView];
    }
    
    saveButn = [[UIButton alloc] init];
    [self addSubview:saveButn];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    MKTittleTextView *lastView;
    for (int index = 0 ; index < 3; index ++) {
        MKTittleTextView *itemView = textViewArray[index];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!index) {
                make.top.mas_equalTo(ws.topView.mas_bottom).offset(15 * autoSizeScaleH);
            }else{
                make.top.mas_equalTo(lastView.mas_bottom).offset(15 * autoSizeScaleH);
            }
            make.left.right.mas_equalTo(ws.view);
        }];
        lastView = itemView;
    }
    
    [saveButn setTitle:@"修改" forState:UIControlStateNormal];
    [saveButn addTarget:self action:@selector(changePasd) forControlEvents:UIControlEventTouchUpInside];
    saveButn.titleLabel.textColor = customWhite;
    saveButn.titleLabel.font = FONT(16);
    saveButn.backgroundColor = themeGreen;
    [saveButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(ws.view);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    
    [super updateViewConstraints];
}

- (void)changePasd {
    NSString *current,*new,*repeat;
    for (int index = 0; index < 3; index ++) {
        MKTittleTextView *itemView = textViewArray[index];
        switch (index) {
            case 0:
                current = itemView.text;
                break;
            case 1:
                new = itemView.text;
                break;
            case 2:
                repeat = itemView.text;
                break;
            default:
                break;
        }
    }
    if (!current.length) {
        [self.hud showTipMessageAutoHide:@"请先填写当前密码"];
        return;
    }
    if (!new.length) {
        [self.hud showTipMessageAutoHide:@"请先填写新密码"];
        return;
    }
    if (!repeat.length) {
        [self.hud showTipMessageAutoHide:@"请先重复新密码"];
        return;
    }
    if (![current isEqualToString:[ZYFUserDefaults objectForKey:@"pasd"]]) {
        [self.hud showTipMessageAutoHide:@"当前密码填写错误"];
        return;
    }
    if (![new isEqualToString:repeat]) {
        [self.hud showTipMessageAutoHide:@"两次填写的新密码不一致"];
        return;
    }
    if (new.length < 6 || new.length > 12) {
        [self.hud showTipMessageAutoHide:@"密码长度限制为6-12位，请修改您的密码"];
        return;
    }
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:current forKey:@"old_password"];
    [plist setObject:new forKey:@"password"];
    [plist setObject:repeat forKey:@"confirm_password"];
    [self.hud showWaitHudWithMessage:@"修改密码中..."];
    [AFNetWorkingUsing httpPost:@"user/profile/changePassword" params:plist success:^(id json) {
        [self.hud hideAnimated:YES];
        [ZYFUserDefaults setObject:new key:@"pasd"];
        //[self.navigationController popViewControllerAnimated:YES];
        
        [ZYFUserDefaults setBool:NO key:@"loginFlag"];
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
