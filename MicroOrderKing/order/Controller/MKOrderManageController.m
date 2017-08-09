//
//  MKOrderManageController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/27.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKOrderManageController.h"
#import "MKOrderDetailController.h"
#import "MKSearchGoodsController.h"

#import "MKOrderManageTable.h"
#import "MKOrderManageCell.h"
#import "MKConfirmView.h"

#import "MKOrderCellModel.h"


@interface MKOrderManageController ()

@end

@implementation MKOrderManageController
{
    UIView *maskView;
    MKConfirmView *confirmView;
    
    NSMutableArray *pageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(ws)
    MKOrderManageTable *secondTable = (MKOrderManageTable *)self.tableViewArray[1];
    [secondTable SetGreenBtn];
    secondTable.greenButnBlock =^(){
        [ws goToConfirm];
    };
    self.cellSelcet =^(UITableView *tableView,NSIndexPath *indexPath){
        [ws goToOrderDetail:(BaseUITableView *)tableView indexPath:indexPath];
    };
//    [((MKOrderManageTable *)self.tableViewArray[0]) SetGreenBtn];
    // Do any additional setup after loading the view.
}

- (void)reloadTableView:(NSInteger)index {
    BaseUITableView *table = self.tableViewArray[index];
    [table.mj_header beginRefreshing];
}

- (void)goToOrderDetail:(BaseUITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    MKOrderDetailController *controller = [[MKOrderDetailController alloc] initWithTitle:@"订单详情"];
    MKOrderCellModel *model = tableView.dataArray[indexPath.row];
    controller.orderId = model.orderId;
    controller.postStatus = model.conditionType;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)setTopView{
    [super setTopView];
    [self.topView.rightButton setImage:[[UIImage imageNamed:@"comManSearch"] imageByScalingToSize:CGSizeMake(20, 20)]
                              forState:UIControlStateNormal];
    [self.topView setRightEvent:self action:@selector(goToSearch)];
}

- (void)goToSearch {
    MKSearchGoodsController *controller = [[MKSearchGoodsController alloc] initWithType:0];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BaseUITableView *table = self.tableViewArray[self.currentIndex];
    [table.mj_header beginRefreshing];
}


- (void)tabScrollViewSetting {
    
    self.tableViewArray = [[NSMutableArray alloc] initWithObjects:
                           [[BaseUITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"orderDeliver" class:[MKOrderManageCell class]],
                           [[MKOrderManageTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"orderConfirm" class:[MKOrderManageCell class] type:1],
                           [[BaseUITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"orderHistory" class:[MKOrderManageCell class]], nil];
    [self setTabDataSource:[[NSMutableArray alloc] initWithObjects:@"待发货订单",@"待确认订单",@"历史订单", nil]];
    [self.tabScrollerView SetButnNormalColor:[UIColor hexStringToColor:@"#666666"] andSelectedColor:themeGreen];
    [self.tabScrollerView SetButnFont:FONT(14)];
    [self.tabScrollerView SetSlideViewBackgroundColor:themeGreen];
}

- (void)setData {
    pageArray = [[NSMutableArray alloc] initWithObjects:@(1),@(1),@(1), nil];
    
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
    NSInteger page = [[pageArray objectAtIndex:refreshIndex] integerValue];
    page = 1;
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@(page) forKey:@"page"];
    [plist setObject:@(refreshIndex) forKey:@"post_status"];
    [AFNetWorkingUsing httpGet:@"order" params:plist success:^(id json) {
        NSMutableArray *modelArra = [MKOrderCellHttpModel mj_objectWithKeyValues:json].data;
        [dataArra removeAllObjects];
        for (MKOrderCellModel *model in modelArra) {
            [dataArra addObject:model];
        }
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [tableView.mj_header endRefreshing];
    } other:^(id json) {
        [dataArra removeAllObjects];
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
//        [self.hud showTipMessageAutoHide:@"没有啦～"];
    }];
}

/**
 *  上拉加载
 *
 *  @param tableView <#tableView description#>
 */
-(void)tableViewLoadMore:(UITableView *)tableView
{
    NSInteger refreshIndex = self.currentIndex;
    NSMutableArray *dataArra = self.dataAllArray[refreshIndex];
    NSInteger page = [[pageArray objectAtIndex:refreshIndex] integerValue];
    page ++;
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@(page) forKey:@"page"];
    [plist setObject:@(refreshIndex) forKey:@"post_status"];
    [AFNetWorkingUsing httpGet:@"order" params:plist success:^(id json) {
        NSMutableArray *modelArra = [MKOrderCellHttpModel mj_objectWithKeyValues:json].data;
        for (MKOrderCellModel *model in modelArra) {
            [dataArra addObject:model];
        }
        [tableView reloadData];
        [tableView.mj_footer endRefreshing];
    } fail:^(NSError *error) {
        [tableView.mj_footer endRefreshing];
    } other:^(id json) {
        [tableView reloadData];
        [tableView.mj_footer endRefreshing];
        //        [self.hud showTipMessageAutoHide:@"没有啦～"];
    }];
}

- (void)goToConfirm{

    maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    maskView.alpha = 0;
    [self addSubview:maskView];
    [self.view bringSubviewToFront:maskView];
    WS(ws)
    [maskView addTapEventWith:self action:@selector(cancelConfirm)];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(ws.view);
        make.center.mas_equalTo(ws.view);
    }];
    confirmView = [[MKConfirmView alloc] init];
    [confirmView setSignStr:@[@"请确定您已收到货款并用户已收货",@"交易成功"]];
    [self addSubview:confirmView];
    confirmView.cancelBlock =^(){
        [ws cancelConfirm];
    };
    confirmView.confirmBlock =^(){
        [ws confirm];
    };
    confirmView.alpha = 0;
    confirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
    [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).offset(leftPadding);
        make.right.mas_equalTo(ws.view).offset(rightPadding);
        make.centerY.mas_equalTo(ws.view);
    }];
    [UIView animateWithDuration:.3 animations:^{
        maskView.alpha = 1;
        confirmView.alpha = 1;
        confirmView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)cancelConfirm {
    
    [UIView animateWithDuration:.2 animations:^{
        maskView.alpha = 0;
        confirmView.alpha = 0;
        confirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
    }completion:^(BOOL finished) {
        maskView.hidden = YES;
        confirmView.hidden = YES;
        [maskView removeFromSuperview];
        [confirmView removeFromSuperview];
    }];
}

- (void)confirm {
    NSString *requestStr = @"order/";
    NSMutableArray *dataArra = self.dataAllArray[1];
    for (int index = 0; index < dataArra.count; index ++) {
        MKOrderCellModel *model = dataArra[index];
        requestStr = [requestStr stringByAppendingString:!index ? model.orderId : [NSString stringWithFormat:@",%@",model.orderId]];
    }
    requestStr = [requestStr stringByAppendingString:@"/change"];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject: @"2" forKey:@"post_status"];
    [AFNetWorkingUsing httpPut:requestStr params:plist success:^(id json) {
        [self.hud showTipMessageAutoHide:@"订单状态已更新"];
        BaseUITableView *table = self.tableViewArray[self.currentIndex];
        [table.mj_header beginRefreshing];
        [self cancelConfirm];
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
