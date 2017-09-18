//
//  MKMemberDetailController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/30.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKMemberDetailController.h"
#import "MKEditMemberController.h"
#import "MKOrderWritingController.h"

#import "MKMemberInfoView.h"
#import "MKMemTradesInfoView.h"

#import "MKMemberBaseModel.h"

@interface MKMemberDetailController ()

@end

@implementation MKMemberDetailController
{
    MKMemberInfoView *infoView;
    MKMemTradesInfoView *tradesView;
    UIButton *addButn;
    UIScrollView *scrollerView;
    UIView *containerView;
    
    NSString *phoneNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //[self loadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self loadData];
}

- (void)setTopView {
    [super setTopView];
    [self.topView.rightButton setImage:[[UIImage imageNamed:@"mberManDetEdit"] imageByScalingToSize:CGSizeMake(19 * autoSizeScaleW, 19 * autoSizeScaleW)] forState:UIControlStateNormal];
    [self.topView setRightEvent:self action:@selector(goToEdit)];
}

- (void)goToEdit {
    MKEditMemberController *controller = [[MKEditMemberController alloc] initWithTitle:@"会员编辑"];
    controller.memberId = _memberId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)CreatView {
    
    infoView = [[MKMemberInfoView alloc] init];
    tradesView = [[MKMemTradesInfoView alloc] init];
    addButn = [[UIButton alloc] init];
    scrollerView = [[UIScrollView alloc] init];
    containerView = [[UIView alloc] init];
    
    [self addSubview:scrollerView];
    [self addSubview:addButn];
    [scrollerView addSubview:containerView];
    [containerView addSubview:infoView];
    [containerView addSubview:tradesView];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [addButn setTitle:@"录入订单" forState:UIControlStateNormal];
    [addButn addTarget:self action:@selector(goToAddOrder) forControlEvents:UIControlEventTouchUpInside];
    addButn.titleLabel.textColor = customWhite;
    addButn.titleLabel.font = FONT(16);
    addButn.backgroundColor = themeGreen;
    [addButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(ws.view);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    scrollerView.bounces = NO;
    scrollerView.showsVerticalScrollIndicator = NO;
    scrollerView.showsHorizontalScrollIndicator = NO;
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(ws.topView.mas_bottom);
        make.bottom.mas_equalTo(addButn.mas_top);
    }];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(scrollerView);
        make.width.mas_equalTo(scrollerView);
        make.bottom.mas_equalTo(tradesView).offset(20 * autoSizeScaleH);
    }];
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(containerView);
    }];
    
    [tradesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(containerView).offset(leftPadding);
        make.right.mas_equalTo(containerView).offset(rightPadding);
        make.top.mas_equalTo(infoView.mas_bottom).offset(-15 * autoSizeScaleH);
    }];
    
    
    [super updateViewConstraints];
}


- (void)loadData {
    
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:[NSString stringWithFormat:@"member/%@",_memberId] params:plist success:^(id json) {
        MKMemberDetailModel *detailModel = [MKMemberDetailModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
        [infoView setData:detailModel];
        [tradesView setDataWithModel:detailModel];
        phoneNum = detailModel.phoneNum;
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];

}

- (void)goToAddOrder {
    MKOrderWritingController *controller = [[MKOrderWritingController alloc] initWithTitle:@"录入订单"];
    controller.phoneNum = phoneNum;
    [self.navigationController pushViewController:controller animated:YES];
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
