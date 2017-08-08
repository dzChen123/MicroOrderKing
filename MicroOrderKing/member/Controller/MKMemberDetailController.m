//
//  MKMemberDetailController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/30.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKMemberDetailController.h"
#import "MKEditMemberController.h"

#import "MKMemberInfoView.h"
#import "MKMemTradesInfoView.h"

#import "MKMemberBaseModel.h"

@interface MKMemberDetailController ()

@end

@implementation MKMemberDetailController
{
    MKMemberInfoView *infoView;
    MKMemTradesInfoView *tradesView;
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
    
    [self addSubview:infoView];
    [self addSubview:tradesView];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(ws.containerView);
    }];
    
    [tradesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).offset(leftPadding);
        make.right.mas_equalTo(ws.view).offset(rightPadding);
        make.top.mas_equalTo(infoView.mas_bottom).offset(-15 * autoSizeScaleH);
    }];
    
    [self setBottomView:tradesView withHeight:20 * autoSizeScaleH];
    
    [super updateViewConstraints];
}


- (void)loadData {
    
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:[NSString stringWithFormat:@"member/%@",_memberId] params:plist success:^(id json) {
        MKMemberDetailModel *detailModel = [MKMemberDetailModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
        [infoView setData:detailModel];
        [tradesView setDataWithModel:detailModel];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
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
