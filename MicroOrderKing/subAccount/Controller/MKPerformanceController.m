//
//  MKPerformanceController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKPerformanceController.h"
#import "MKOrderDetailController.h"
#import "MKMemberDetailController.h"

#import "MKMemberCell.h"
#import "MKOrderManageCell.h"
#import "MKPerformceOrderTable.h"
#import "MKSearchMenberTable.h"

#import "MKOrderCellModel.h"
#import "MKAccountBaseModel.h"

#import "MKMemberBaseModel.h"

#define deliverCellid @"orderDeliver"
#define confirmCellid @"orderConfirm"
#define historyCellid @"orderHistory"

@interface MKPerformanceController ()


@end

@implementation MKPerformanceController
{
    MKPerformceOrderTable *orderTable;
    MKSearchMenberTable *memberTable;
    
    NSInteger page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(ws)
    BaseUITableView *table = self.tableViewArray[1];
    table.cellSelcet =^(UITableView *tableView,NSIndexPath *indexPath){
        [ws goToOrderDetail:(BaseUITableView *)tableView indexPath:indexPath];
    };
    BaseUITableView *table2 = self.tableViewArray[0];
    table2.cellSelcet =^(UITableView *tableView,NSIndexPath *indexPath){
        [ws cellSelect:(BaseUITableView *)tableView indexPath:indexPath];
    };
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BaseUITableView *table = self.tableViewArray[self.currentIndex];
    [table.mj_header beginRefreshing];
}

- (void)reloadSecondTable {
    BaseUITableView *table = self.tableViewArray[1];
    [table.mj_header beginRefreshing];
}

- (void)goToOrderDetail:(BaseUITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    MKOrderDetailController *controller = [[MKOrderDetailController alloc] initWithTitle:@"订单详情"];
    MKOrderCellModel *model = tableView.dataArray[indexPath.row];
    controller.orderId = model.orderId;
    controller.postStatus = model.conditionType;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)cellSelect:(BaseUITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    MKMemberBaseModel *model = tableView.dataArray[indexPath.row];
    MKMemberDetailController *controller = [[MKMemberDetailController alloc] initWithTitle:@"会员详情"];
    controller.memberId = model.memberId;
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)tabScrollViewSetting {
    orderTable = [[MKPerformceOrderTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:deliverCellid class:[MKOrderManageCell class]];
    [orderTable registerClass:[MKOrderManageCell class] forCellReuseIdentifier:confirmCellid];
    [orderTable registerClass:[MKOrderManageCell class] forCellReuseIdentifier:historyCellid];
    
    memberTable = [[MKSearchMenberTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"memberCell" class:[MKMemberCell class]];
    
    self.tableViewArray = [[NSMutableArray alloc] initWithObjects:memberTable,orderTable, nil];
    [self setTabDataSource:[[NSMutableArray alloc] initWithObjects:@"会员数",@"订单数", nil]];
    [self.tabScrollerView SetButnNormalColor:[UIColor hexStringToColor:@"#666666"] andSelectedColor:themeGreen];
    [self.tabScrollerView SetButnFont:FONT(14)];
    [self.tabScrollerView SetSlideViewBackgroundColor:themeGreen];
}

- (void)setData {
    [self tabScrollViewSetting];
}

/**
 *  下拉刷新
 *
 *  @param tableView <#tableView description#>
 */
-(void)tableViewReload:(UITableView *)tableView
{
    NSInteger refreshIndex = self.currentIndex;
    NSMutableArray *dataArra = self.dataAllArray[refreshIndex];
    NSString *requestStr = !refreshIndex ? @"member" : @"order";
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@"1" forKey:@"single"];
    [plist setObject:_userId forKey:@"id"];
    if (refreshIndex == 1) {
        page = 1;
        [plist setObject:@(page) forKey:@"page"];
    }
    [AFNetWorkingUsing httpGet:requestStr params:plist success:^(id json) {
        [dataArra removeAllObjects];
        if (!refreshIndex) {
            NSMutableDictionary *dic = (NSMutableDictionary *)[json objectForKey:@"data"];
            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSArray *datas = [MKMemberBaseModel mj_objectArrayWithKeyValuesArray:obj];
                if (datas.count > 0) {
                    for (MKMemberBaseModel *item in datas) {
                        [dataArra addObject:item];
                    }
                }
            }];
        }else{
            NSMutableArray *modelArra = [MKOrderCellHttpModel mj_objectWithKeyValues:json].data;
            for (MKOrderCellModel *model in modelArra) {
                [dataArra addObject:model];
            }
        }
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
        LxDBAnyVar(json);
    } fail:^(NSError *error) {
        [dataArra removeAllObjects];
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:@"没有了"];
        [dataArra removeAllObjects];
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
    }];

}

/**
 *  上拉加载
 *
 *  @param tableView <#tableView description#>
 */
-(void)tableViewLoadMore:(BaseUITableView *)tableView
{
    NSInteger refreshIndex = self.currentIndex;
    NSMutableArray *dataArra = self.dataAllArray[refreshIndex];
    if (!refreshIndex) {
        [tableView.mj_footer endRefreshing];
    }else{
        page ++;
        NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
        [plist setObject:@(page) forKey:@"page"];
        [plist setObject:_userId forKey:@"single"];
        [AFNetWorkingUsing httpGet:@"order" params:plist success:^(id json) {
            NSMutableArray *modelArra = [MKOrderCellHttpModel mj_objectWithKeyValues:json].data;
            for (MKOrderCellModel *model in modelArra) {
                [dataArra addObject:model];
            }
            [tableView.mj_footer endRefreshing];
        } fail:^(NSError *error) {
            [tableView.mj_footer endRefreshing];
        } other:^(id json) {
            [tableView.mj_footer endRefreshing];
        }];
    }
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
