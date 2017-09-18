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
    isReload = YES;
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
    isReload = NO;
    [self loadOrder];
}

- (void)loadOrder {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@(page) forKey:@"page"];
    [plist setObject:_searchContent forKey:@"search"];
    [AFNetWorkingUsing httpGet:@"order" params:plist success:^(id json) {
        LxDBAnyVar(json);
        if (isReload) {
            [orderTable.dataArray removeAllObjects];
        }
        NSMutableArray *modelArra = [MKOrderCellHttpModel mj_objectWithKeyValues:json].data;
        for (int count = 0; count < modelArra.count; count ++) {
            [orderTable.dataArray addObject:modelArra[count]];
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
        if (isReload) {
            [orderTable.dataArray removeAllObjects];
        }
        [orderTable reloadData];
        //NSString *signStr;
        if (isReload) {
            [orderTable.mj_header endRefreshing];
        } else {
            [orderTable.mj_footer endRefreshing];
        }
        [self.hud showTipMessageAutoHide:@"暂无数据"];
    }];
}

- (void)loadMember {
    
    //本地查询  先搜名字  再搜其他的
    
    NSMutableArray *total = [[NSMutableArray alloc] init];
    NSMutableArray *matchedArra = [[NSMutableArray alloc] init];
    for (NSArray *arra in [ZYFUserDefaults objectForKey:@"memberDics"]) {
        for (NSDictionary *dic in arra) {
            [total addObject:[MKMemberBaseModel mj_objectWithKeyValues:dic]];
        }
    }
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",_searchContent];
    for (MKMemberBaseModel *model in total) {
        if ([model.name rangeOfString:_searchContent].location != NSNotFound) {
            [matchedArra addObject:model];
        }else{
            if ([model.phoneNum rangeOfString:_searchContent].location != NSNotFound) {
                [matchedArra addObject:model];
            }else{
                if ([model.remark rangeOfString:_searchContent].location != NSNotFound) {
                    [matchedArra addObject:model];
                }
            }
        }
        //if ([pred evaluateWithObject:model.phoneNum] || [pred evaluateWithObject:model.remark]) {
        //    [matchedArra addObject:model];
        //}
    }
    if (!matchedArra.count) {
        [memberTable.dataArray removeAllObjects];
        [memberTable reloadData];
        [memberTable.mj_header endRefreshing];
        [self.hud showTipMessageAutoHide:isReload ? @"暂无数据" : @"已无新数据"];
    } else {
        [memberTable.dataArray removeAllObjects];
        for (MKMemberBaseModel *model in matchedArra) {
            [memberTable.dataArray addObject:model];
        }
        [memberTable reloadData];
        [memberTable.mj_header endRefreshing];
        
    }
}

- (void)loadGoods {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@"1" forKey:@"list"];
    [plist setObject:_searchContent forKey:@"goods_name"];
    [AFNetWorkingUsing httpGet:@"goods" params:plist success:^(id json) {
        NSMutableArray *modelArr = [MKGoodsInfoHttpModel mj_objectWithKeyValues:json].data;
        [_resultTable.dataArray removeAllObjects];
        for (int count = 0; count < modelArr.count; count ++) {
            [_resultTable.dataArray addObject:modelArr[count]];
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
        [self.hud showTipMessageAutoHide:@"暂无数据"];
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
