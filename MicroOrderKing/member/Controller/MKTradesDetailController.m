//
//  MKTradesDetailController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKTradesDetailController.h"

#import "MKTradesHeaderView.h"
#import "BaseUITableView.h"
#import "MKOrderManageCell.h"

#import "MKOrderCellModel.h"

@interface MKTradesDetailController ()

@end

@implementation MKTradesDetailController
{
    MKTradesHeaderView *headerView;
    BaseUITableView *tradesTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(ws)
    tradesTable.reloadMessage =^(UITableView *tableView){
        [ws tableViewReload:tableView];
    };
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [tradesTable.mj_header beginRefreshing];
}

- (void)CreatView {
    headerView = [[MKTradesHeaderView alloc] init];
    tradesTable = [[BaseUITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"orderHistory" class:[MKOrderManageCell class]];
    [self addSubview:headerView];
    [self addSubview:tradesTable];
    
    [headerView setCost:@"1200" andCount:@"100"];
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

-(void)tableViewReload:(UITableView *)tableView
{
    BaseUITableView *table = (BaseUITableView *)tableView;
    MKGoodsInfoModel *goodsModel = [[MKGoodsInfoModel alloc] init];
    goodsModel.imgUrl = @"goods1";
    goodsModel.goodsName = @"泰国金枕头榴莲泰国金枕头榴莲泰国金枕头榴莲泰国金枕头榴莲";
    goodsModel.price = @"99";
//    goodsModel.count = @"20";
    MKOrderCellModel *model3 = [[MKOrderCellModel alloc] init];
    model3.goodsInfoArra = [[NSMutableArray alloc] init];
    model3.orderId = @"201710258984565616";
//    model3.conditionType = 3;
    model3.address = @"浙江省温州市鹿城区松台街道XXXXXX";
    model3.totalAmount = @"40";
    model3.totalCost = @"3600";
    [model3.goodsInfoArra addObject:goodsModel];
    [model3.goodsInfoArra addObject:goodsModel];
    
    MKOrderCellModel *model4 = [[MKOrderCellModel alloc] init];
    model4.goodsInfoArra = [[NSMutableArray alloc] init];
    model4.orderId = @"201710258984565616";
//    model4.conditionType = 3;
    model4.address = @"浙江省温州市鹿城区松台街道XXXXXX";
    model4.totalAmount = @"40";
    model4.totalCost = @"3600";
    [model4.goodsInfoArra addObject:goodsModel];
    [model4.goodsInfoArra addObject:goodsModel];
    
    [table.dataArray removeAllObjects];
    [table.dataArray addObject:model3];
    [table.dataArray addObject:model4];
    [tableView reloadData];
    [tableView.mj_header endRefreshing];
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
