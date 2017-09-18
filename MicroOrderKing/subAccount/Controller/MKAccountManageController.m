//
//  MKAccountManageController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAccountManageController.h"
#import "MKAccountInfoController.h"
#import "MKAddAccountController.h"

#import "MKAccountManageTable.h"
#import "MKAccountManageCell.h"

#import "MKAccountBaseModel.h"

#define listRows 5

@interface MKAccountManageController ()

@end

@implementation MKAccountManageController
{
    MKAccountManageTable *accountTable;
    
    NSInteger page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(ws)
    accountTable.reloadMessage =^(UITableView *tableView){
        [ws tableViewReload:tableView];
    };
    accountTable.loadMoreMessage =^(UITableView *tableView){
        [ws tableViewLoadMore:tableView];
    };
    accountTable.cellSelcet =^(UITableView *tableView,NSIndexPath *indexPath){
        [ws gotoAccountInfoWithTable:(BaseUITableView *)tableView IndexPath:indexPath];
    };
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [accountTable.mj_header beginRefreshing];
}

- (void)setTopView {
    [super setTopView];
    self.topTitle = @"分账号管理";
    [self.topView.rightButton setImage:[[UIImage imageNamed:@"mberManAdd"] imageByScalingToSize:CGSizeMake(20, 20)]
                              forState:UIControlStateNormal];
    [self.topView setRightEvent:self action:@selector(gotoAddAccount)];
}

- (void)gotoAccountInfoWithTable:(BaseUITableView *)tableView IndexPath:(NSIndexPath *)indexPath {
    MKAccountInfoController *controller = [[MKAccountInfoController alloc] init];
    MKAccountBaseModel *model = tableView.dataArray[indexPath.row];
    controller.accountId = model.accountId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)CreatView {
    page = 1;
    accountTable = [[MKAccountManageTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"accountManage" class:[MKAccountManageCell  class]];

    [self addSubview: accountTable];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [accountTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.topView.mas_bottom);
        make.left.right.bottom.mas_equalTo(ws.view);
    }];
    
    [super updateViewConstraints];
}

- (void)gotoAddAccount {
    MKAddAccountController *controller = [[MKAddAccountController alloc] initWithType:0];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)tableViewReload:(UITableView *)tableView {
    page = 1;
    BaseUITableView *table = (BaseUITableView *)tableView;
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@(listRows) forKey:@"list_rows"];
    [plist setObject:@(page) forKey:@"page"];
    [AFNetWorkingUsing httpGet:@"subaccount" params:plist success:^(id json) {
        [table.dataArray removeAllObjects];
        MKAccountHttpBaseModel *model = [MKAccountHttpBaseModel mj_objectWithKeyValues:json];
        for (int count = 0; count < model.data.count; count ++) {
            [table.dataArray addObject:model.data[count]];
        }
        [table reloadData];
        [table.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [table.mj_header endRefreshing];
    } other:^(id json) {
        [table.dataArray removeAllObjects];
        [table reloadData];
        [table.mj_header endRefreshing];
        if ([[json objectForKey:@"msg"] isEqualToString:@"子账号无权访问！"]) {
            [self.hud showTipMessageAutoHide:@"子账号无权访问！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.hud showTipMessageAutoHide:@"暂无数据"];
        }

    }];
}

- (void)tableViewLoadMore:(UITableView *)tableView {
    page ++;
    BaseUITableView *table = (BaseUITableView *)tableView;
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@(listRows) forKey:@"list_rows"];
    [plist setObject:@(page) forKey:@"page"];
    [AFNetWorkingUsing httpGet:@"subaccount" params:plist success:^(id json) {
        MKAccountHttpBaseModel *model = [MKAccountHttpBaseModel mj_objectWithKeyValues:json];
        for (int count = 0; count < model.data.count; count ++) {
            [table.dataArray addObject:model.data[count]];
        }
        [table reloadData];
        [table.mj_footer endRefreshing];
    } fail:^(NSError *error) {
        [table.mj_footer endRefreshing];
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:@"已无新数据"];
        [table.mj_footer endRefreshing];
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
