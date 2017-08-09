//
//  MKSearResultController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/9.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKSearResultController.h"
#import "MKMemberDetailController.h"
#import "MKOrderDetailController.h"

#import "BaseUITableView.h"
#import "MKSearchMenberTable.h"
#import "MKPerformceOrderTable.h"
#import "MKOrderManageCell.h"
#import "MKGoodsManageCell.h"
#import "MKMemManageCell.h"

#import "MKOrderCellModel.h"
#import "MKMemberBaseModel.h"

#define deliverCellid @"orderDeliver"
#define confirmCellid @"orderConfirm"
#define historyCellid @"orderHistory"

#define listRows 10

@interface MKSearResultController ()

@end

@implementation MKSearResultController
{
    MKPerformceOrderTable *orderTable;
    MKSearchMenberTable *memberTable;
    
    NSInteger _type;
    NSInteger page;
    BOOL isReload;
}

- (instancetype)initWithType:(NSInteger)type {
    if (self == [super init]) {
        _type = type;
    }
    return self;
}

- (void)setTopView {
    [super setTopView];
    self.topTitle = @"搜寻结果";
}

- (void)CreatView {
    
    page = 1;
    isReload = YES;
    WS(ws)
    
    switch (_type) {
        case 0:     //  订单查询
        {
            orderTable = [[MKPerformceOrderTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:deliverCellid class:[MKOrderManageCell class]];
            [orderTable registerClass:[MKOrderManageCell class] forCellReuseIdentifier:confirmCellid];
            [orderTable registerClass:[MKOrderManageCell class] forCellReuseIdentifier:historyCellid];
            orderTable.reloadMessage =^(UITableView *tableView){
                [ws tableViewReload:(BaseUITableView *)tableView];
            };
            orderTable.loadMoreMessage =^(UITableView *tableView){
                [ws tableViewLoadMore:(BaseUITableView *)tableView];
            };
            orderTable.cellSelcet =^(UITableView *tableView,NSIndexPath *indexPath){
                [ws goToOrderDetail:(BaseUITableView *)tableView indexPath:indexPath];
            };
            [self addSubview:orderTable];
            
        }
            break;
        case 1:     //商品查询
        {
            _resultTable = [[BaseUITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"goodsCellid" class:[MKGoodsManageCell class]];
            _resultTable.reloadMessage =^(UITableView *tableView){
                [ws tableViewReload:(BaseUITableView *)tableView];
            };
            [self addSubview:_resultTable];
        }
            break;
        case 2:     //会员查询
        {
            memberTable = [[MKSearchMenberTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"memberCellid" class:[MKMemManageCell class]];
            memberTable.reloadMessage =^(UITableView *tableView){
                [ws tableViewReload:(BaseUITableView *)tableView];
            };
            memberTable.cellSelcet =^(UITableView *tableView,NSIndexPath *indexPath){
                [ws cellSelect:(BaseUITableView *)tableView indexPath:indexPath];
            };
            [self addSubview:memberTable];
        }
            break;
            
        default:
            break;
    }
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    switch (_type) {
        case 0:{
            [orderTable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(ws.topView.mas_bottom);
                make.left.right.bottom.mas_equalTo(ws.view);
            }];
        }
            break;
        case 1:
        {
            _resultTable.mj_footer = nil;
            [_resultTable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(ws.topView.mas_bottom);
                make.left.right.bottom.mas_equalTo(ws.view);
            }];
        }
            break;
        case 2:
        {
            memberTable.mj_footer = nil;
            [memberTable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(ws.topView.mas_bottom);
                make.left.right.bottom.mas_equalTo(ws.view);
            }];
        }
            break;
            
        default:
            break;
    }
    
    if (orderTable) {
        
    } else {
        
    }
    
    [super updateViewConstraints];
}

- (void)tableViewReload:(BaseUITableView *)tableView {
    page = 1;
    switch (_type) {
        case 0:
            [self loadOrder];
            break;
        case 1:
            [self loadGoods];
            break;
        case 2:
            [self loadMember];
            break;
            
        default:
            break;
    }
}

- (void)tableViewLoadMore:(BaseUITableView *)tableView {
    page ++;
    [self loadOrder];
}

- (void)loadOrder {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@(page) forKey:@"page"];
    [plist setObject:_searchContent forKey:@"search"];
    [AFNetWorkingUsing httpGet:@"order" params:plist success:^(id json) {
        LxDBAnyVar(json);
        [orderTable.dataArray removeAllObjects];
        NSMutableArray *modelArra = [MKOrderCellHttpModel mj_objectWithKeyValues:json].data;
        for (MKOrderCellModel *model in modelArra) {
            [orderTable.dataArray addObject:model];
        }
        [orderTable reloadData];
        if (isReload) {
            [orderTable.mj_header endRefreshing];
        } else {
            [orderTable.mj_footer endRefreshing];
        }
    } fail:^(NSError *error) {
        if (isReload) {
            [orderTable.mj_header endRefreshing];
        } else {
            [orderTable.mj_footer endRefreshing];
        }
    } other:^(id json) {
        [orderTable.dataArray removeAllObjects];
        [orderTable reloadData];
        if (isReload) {
            [orderTable.mj_header endRefreshing];
        } else {
            [orderTable.mj_footer endRefreshing];
        }
        [self.hud showTipMessageAutoHide:@"抱歉，没有相关数据"];
    }];
}

- (void)loadMember {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:_searchContent forKey:@"name"];
    [AFNetWorkingUsing httpGet:@"member" params:plist success:^(id json) {
        [memberTable.dataArray removeAllObjects];
        NSMutableDictionary *dic = (NSMutableDictionary *)[json objectForKey:@"data"];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSArray *datas = [MKMemberBaseModel mj_objectArrayWithKeyValuesArray:obj];
            if (datas.count > 0) {
                for (MKMemberBaseModel *item in datas) {
                    [memberTable.dataArray addObject:item];
                }
            }
        }];
        [memberTable reloadData];
        [memberTable.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [memberTable.dataArray removeAllObjects];
        [memberTable reloadData];
        [memberTable.mj_header endRefreshing];
    } other:^(id json) {
        [memberTable.dataArray removeAllObjects];
        [memberTable reloadData];
        [memberTable.mj_header endRefreshing];
        [self.hud showTipMessageAutoHide:@"抱歉，没有相关数据"];
    }];
}

- (void)loadGoods {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@"1" forKey:@"list"];
    [plist setObject:_searchContent forKey:@"goods_name"];
    [AFNetWorkingUsing httpGet:@"goods" params:plist success:^(id json) {
        NSMutableArray *modelArr = [MKGoodsInfoHttpModel mj_objectWithKeyValues:json].data;
        [_resultTable.dataArray removeAllObjects];
        for (MKGoodsInfoModel *model in modelArr) {
            [_resultTable.dataArray addObject:model];
        }
        [_resultTable reloadData];
        [_resultTable.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [_resultTable.dataArray removeAllObjects];
        [_resultTable reloadData];
        [_resultTable.mj_header endRefreshing];
    } other:^(id json) {
        [_resultTable.dataArray removeAllObjects];
        [_resultTable reloadData];
        [_resultTable.mj_header endRefreshing];
        [self.hud showTipMessageAutoHide:@"抱歉，没有相关数据"];
    }];
}

- (void)reloadTableView {
    [orderTable.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    switch (_type) {
        case 0:
            [orderTable.mj_header beginRefreshing];
            break;
        case 1:
            [_resultTable.mj_header beginRefreshing];
            break;
        case 2:
            [memberTable.mj_header beginRefreshing];
            break;
            
        default:
            break;
    }
}

- (void)cellSelect:(BaseUITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    MKMemberBaseModel *model = tableView.dataArray[indexPath.row];
    MKMemberDetailController *controller = [[MKMemberDetailController alloc] initWithTitle:@"会员详情"];
    controller.memberId = model.memberId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)goToOrderDetail:(BaseUITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    MKOrderDetailController *controller = [[MKOrderDetailController alloc] initWithTitle:@"订单详情"];
    MKOrderCellModel *model = tableView.dataArray[indexPath.row];
    controller.orderId = model.orderId;
    controller.postStatus = model.conditionType;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
