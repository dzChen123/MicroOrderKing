//
//  MKHomePageViewController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/26.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKHomePageViewController.h"
#import "MKOrderManageController.h"
#import "MKPersonCenterController.h"

#import "MKTradesInfoView.h"
#import "MKSectionView.h"

#import "MKHomeModel.h"

@interface MKHomePageViewController ()

@end

@implementation MKHomePageViewController
{
    MKTradesInfoView *tradesInfoView;
    MKSectionView *sectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)CreatView {
    tradesInfoView = [[MKTradesInfoView alloc] init];
    sectionView = [[MKSectionView alloc] init];
    
    [self addSubview:tradesInfoView];
    [self addSubview:sectionView];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [tradesInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(ws.containerView);
    }];
    
    [sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.mas_equalTo(ws.containerView);
        make.top.mas_equalTo(tradesInfoView.mas_bottom);
    }];
    
    [self setBottomView:sectionView withHeight:.1f];
    
    [super updateViewConstraints];
}

- (void)setTopView{
    [super setTopView];
    self.topTitle = @"微单王";
    self.topView.lineView.hidden = YES;
    self.topView.titleLabel.textColor = customWhite;
    self.topView.backgroundColor = themeGreen;
    [self.topView.rightButton setImage:[[UIImage imageNamed:@"homePersonCenter"] imageByScalingToSize:CGSizeMake(25, 25)]
                              forState:UIControlStateNormal];
    [self.topView setRightEvent:self action:@selector(goToPersonCenter)];
    self.topView.leftButton.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)loadData {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:@"" params:plist success:^(id json) {
        MKHomeModel *model = [MKHomeHttpModel mj_objectWithKeyValues:json].data;
        [tradesInfoView setUpdateModel:model];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)goToPersonCenter {
    MKPersonCenterController *controller = [[MKPersonCenterController alloc] initWithTitle:@"个人中心"];
    controller.isOut = NO;
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
