//
//  MKAddreManageController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/5.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAddreManageController.h"
#import "MKEditAddreController.h"

#import "MKAddreMangeCell.h"
#import "MKAddreManageTable.h"

#import "MKAddreManageModel.h"
#import "MKMemberBaseModel.h"


@interface MKAddreManageController ()

@end

@implementation MKAddreManageController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _addreManageTable.mj_header = nil;
    _addreManageTable.mj_footer = nil;

    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self tableViewReload:_addreManageTable];
}

- (void)setTopView {
    [super setTopView];
    self.topTitle = @"地址管理";
    [self.topView.rightButton setImage:[[UIImage imageNamed:@"mberManAdd"] imageByScalingToSize:CGSizeMake(18 * autoSizeScaleW, 18 * autoSizeScaleW)] forState:UIControlStateNormal];
    [self.topView setRightEvent:self action:@selector(goToAddAddre)];
}

- (void)goToAddAddre{
    
    if (_addreManageTable.dataArray.count + 1 > 20) {
        [self.hud showTipMessageAutoHide:@"地址数量不能超过20"];
        return;
    }
    
    MKEditAddreController *controller = [[MKEditAddreController alloc] initWithType:0];
    controller.memberId = _memberId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)CreatView {
    _addreManageTable = [[MKAddreManageTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"addreManageCellid" class:[MKAddreMangeCell class]];
    [self addSubview:_addreManageTable];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [_addreManageTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(ws.view);
        make.top.mas_equalTo(ws.topView.mas_bottom);
    }];
    
    [super updateViewConstraints];
}

- (void)tableViewReload:(BaseUITableView *)tableView {
   
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:_memberId forKey:@"member_id"];
    [AFNetWorkingUsing httpGet:@"address" params:plist success:^(id json) {
        NSMutableArray *modelArra = [MKMemAddreModel mj_objectArrayWithKeyValuesArray:[json objectForKey:@"data"]];
        [tableView.dataArray removeAllObjects];
        for (MKMemAddreModel *model in modelArra) {
            [tableView.dataArray addObject:model];
        }
        [tableView reloadData];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [tableView.dataArray removeAllObjects];
        [tableView reloadData];
        [self.hud showTipMessageAutoHide:@"暂无数据"];
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
