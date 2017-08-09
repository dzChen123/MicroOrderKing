//
//  MKTradesDetailController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKTradesDetailController.h"

#import "MKTradesHeaderView.h"
#import "MKPerformceOrderTable.h"
#import "MKOrderManageCell.h"

#import "MKOrderCellModel.h"
#import "MKMemberBaseModel.h"

#define deliverCellid @"orderDeliver"
#define confirmCellid @"orderConfirm"
#define historyCellid @"orderHistory"

@interface MKTradesDetailController ()

@end

@implementation MKTradesDetailController
{
    MKTradesHeaderView *headerView;
    MKPerformceOrderTable *tradesTable;
    
    NSInteger page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    tradesTable.mj_header = nil;
    tradesTable.mj_footer = nil;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];

}

- (void)reloadTableView {
    [tradesTable.mj_header beginRefreshing];
}

- (void)CreatView {
    
    self.topTitle = @"查看详情";
    
    headerView = [[MKTradesHeaderView alloc] init];
    tradesTable = [[MKPerformceOrderTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:historyCellid class:[MKOrderManageCell class]];
    [tradesTable registerClass:[MKOrderManageCell class] forCellReuseIdentifier:confirmCellid];
    [tradesTable registerClass:[MKOrderManageCell class] forCellReuseIdentifier:deliverCellid];
    [self addSubview:headerView];
    [self addSubview:tradesTable];
    
    [headerView setCost:@"..." andCount:@"..."];
}

- (void)updateViewConstraints {

    WS(ws)
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.topView.mas_bottom);
        make.left.right.mas_equalTo(ws.view);
    }];
    
    [tradesTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_bottom);
        make.left.right.bottom.mas_equalTo(ws.view);
    }];
    
    [super updateViewConstraints];
}

- (void)loadData {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:[NSString stringWithFormat:@"member/%@/detail",_userId] params:plist success:^(id json) {
        LxDBAnyVar(json);
        MKMemberTradesInfoModel *model = [MKMemberTradesInfoModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
        [headerView setCost:model.sumCount.sum andCount:model.sumCount.count];
        [tradesTable.dataArray removeAllObjects];
        for (MKOrderCellModel *orderModel in model.data) {
            [tradesTable.dataArray addObject:orderModel];
        }
        [tradesTable reloadData];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [headerView setCost:_totalCost andCount:_totalCount];
        [tradesTable.dataArray removeAllObjects];
        [tradesTable reloadData];
        [self.hud showTipMessageAutoHide:@"暂时没有数据"];
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
