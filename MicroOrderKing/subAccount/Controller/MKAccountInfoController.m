//
//  MKAccountInfoController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAccountInfoController.h"
#import "MKAddAccountController.h"

#import "MKAccountInfoView.h"

#import "MKAccountBaseModel.h"

@interface MKAccountInfoController ()

@end

@implementation MKAccountInfoController
{
    MKAccountInfoView *accountInfoView;
    UIButton *deleteButn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)setTopView {
    [super setTopView];
    self.topTitle = @"子账户详情";
    [self.topView.rightButton setImage:[[UIImage imageNamed:@"mberManDetEdit"] imageByScalingToSize:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    [self.topView setRightEvent:self action:@selector(goToEdit)];
}

- (void)CreatView {
    
    accountInfoView = [[MKAccountInfoView alloc] init];
    deleteButn = [[UIButton alloc] init];
    [self addSubview:accountInfoView];
    [self addSubview:deleteButn];
}

- (void)goToEdit {
    MKAddAccountController *controller = [[MKAddAccountController alloc] initWithType:0];
    controller.topTitle = @"子账户编辑";
    controller.editId = _accountId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)loadData {

    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:[NSString stringWithFormat:@"subaccount/%@",_accountId] params:plist success:^(id json) {
        MKAccountDetailModel *model = [MKAccountHttpDetailModel mj_objectWithKeyValues:json].data;
        [accountInfoView setDataWithModel:model];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)delete {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [self.hud showWait];
    [AFNetWorkingUsing httpDelete:[NSString stringWithFormat:@"subaccount/%@",_accountId] params:plist success:^(id json) {
        [self.hud hideAnimated:YES];
        [self.hud showTipMessageAutoHide:@"删除成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        [self.hud hideAnimated:YES];
    } other:^(id json) {
        [self.hud hideAnimated:YES];
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
    
}

- (void)updateViewConstraints {

    WS(ws)
    
    [accountInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.topView.mas_bottom);
        make.left.right.mas_equalTo(ws.view);
    }];
    
    deleteButn.titleLabel.textColor = customWhite;
    deleteButn.titleLabel.font = FONT(16);
    deleteButn.layer.cornerRadius = 5.0;
    deleteButn.layer.masksToBounds = YES;
    deleteButn.backgroundColor = [UIColor hexStringToColor:@"#D41B2D"];
    [deleteButn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [deleteButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).offset(leftPadding);
        make.right.mas_equalTo(ws.view).offset(rightPadding);
        make.top.mas_equalTo(accountInfoView.mas_bottom).offset(20 * autoSizeScaleH);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    [super updateViewConstraints];
    
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
