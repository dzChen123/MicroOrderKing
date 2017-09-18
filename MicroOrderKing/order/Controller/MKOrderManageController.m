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
#import "MKScanViewController.h"

#import "MKOrderManageTable.h"
#import "MKOrderManageCell.h"
#import "MKConfirmView.h"
#import "MKScanConfirmView.h"

#import "MKOrderCellModel.h"


@interface MKOrderManageController ()

@end

@implementation MKOrderManageController
{
    UIView *maskView;
    MKConfirmView *confirmView;
    MKScanConfirmView *scanConfirmView;
    
    NSMutableArray *pageArray;
    NSMutableArray *selectIdArray;
    NSString *printString;      //批量打印的IDString
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(ws)
    
    MKOrderManageTable *firstTable = (MKOrderManageTable *)self.tableViewArray[0];
    [firstTable SetGreenBtn];
    firstTable.printButnBlock =^(NSInteger tag){
        [ws firstTableClick:tag];
    };
    
    MKOrderManageTable *secondTable = (MKOrderManageTable *)self.tableViewArray[1];
    [secondTable SetGreenBtn];
    secondTable.confirmButnBlock =^(){
        [ws goToConfirm];
    };
    self.cellSelcet =^(UITableView *tableView,NSIndexPath *indexPath){
        [ws goToOrderDetail:(BaseUITableView *)tableView indexPath:indexPath];
    };
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
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BaseUITableView *table = self.tableViewArray[self.currentIndex];
    [table.mj_header beginRefreshing];
}


- (void)tabScrollViewSetting {
    
    self.tableViewArray = [[NSMutableArray alloc] initWithObjects:
                           [[MKOrderManageTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"orderDeliver" class:[MKOrderManageCell class] type:0],
                           [[MKOrderManageTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"orderConfirmCenter" class:[MKOrderManageCell class] type:1],
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
            model.isSelected = NO;
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
        [self.hud showTipMessageAutoHide:@"暂无数据"];
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
        for (int count = 0; count < modelArra.count; count ++) {
            [dataArra addObject:modelArra[count]];
        }
        [tableView reloadData];
        [tableView.mj_footer endRefreshing];
    } fail:^(NSError *error) {
        [tableView.mj_footer endRefreshing];
    } other:^(id json) {
        [tableView reloadData];
        [tableView.mj_footer endRefreshing];
        [self.hud showTipMessageAutoHide:@"已无新数据"];
    }];
}

- (void)firstTableClick:(NSInteger)tag {
    if (tag == 20) {
        [self goToOutPut];
    } else {
        [self goToPrint];
    }
}

- (void)goToOutPut {
    
    printString = @"";
    
    MKOrderManageTable *firstTable = (MKOrderManageTable *)self.tableViewArray[0];
    for (MKOrderCellModel *model in firstTable.dataArray) {
        if (model.isSelected) {
            
            if (!printString.length) {
                printString = model.orderId;
            }else{
                printString = [NSString stringWithFormat:@"%@,%@",printString,model.orderId];
            }
        }
    }
    
    if (!printString.length) {
        [self.hud showTipMessageAutoHide:@"请您先勾选订单，再进行批量导出"];
        return;
    }
    
    MKScanViewController *controller = [[MKScanViewController alloc] initWithTitle:@"打码扫印"];
    controller.printStr = printString;
    controller.printType = 10;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)goToPrint {
    
    printString = @"";
    
    MKOrderManageTable *firstTable = (MKOrderManageTable *)self.tableViewArray[0];
    for (MKOrderCellModel *model in firstTable.dataArray) {
        if (model.isSelected) {
            
            if (!printString.length) {
                printString = model.orderId;
            }else{
                printString = [NSString stringWithFormat:@"%@,%@",printString,model.orderId];
            }
        }
    }
    
    if (!printString.length) {
        [self.hud showTipMessageAutoHide:@"请您先勾选订单，再进行批量打印"];
        return;
    }
    
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
    
    scanConfirmView = [[MKScanConfirmView alloc] init];
    [self addSubview:scanConfirmView];
    scanConfirmView.cancelBlock =^(){
        [ws cancelConfirm];
    };
    scanConfirmView.confirmBlock =^(){
        [ws scanConfirm];
    };
    scanConfirmView.alpha = 0;
    scanConfirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
    [scanConfirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).offset(leftPadding);
        make.right.mas_equalTo(ws.view).offset(rightPadding);
        make.centerY.mas_equalTo(ws.view);
    }];
    [UIView animateWithDuration:.3 animations:^{
        maskView.alpha = 1;
        scanConfirmView.alpha = 1;
        scanConfirmView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

- (void)goToConfirm{
    
    NSInteger selectCount = 0;
    NSString *signStr = @"您勾选了";
    selectIdArray = [[NSMutableArray alloc] init];
    MKOrderManageTable *secondTable = (MKOrderManageTable *)self.tableViewArray[1];
    for (MKOrderCellModel *model in secondTable.dataArray) {
        if (model.isSelected) {
            selectCount ++;
            [selectIdArray addObject:model.orderId];
            if (selectCount < 4) {
                signStr = [signStr stringByAppendingString:[NSString stringWithFormat:@"%@,",model.orderSn]];
            }
        }
    }
    
    if (!selectCount) {
        [self.hud showTipMessageAutoHide:@"请您先勾选订单，再进行批量确认"];
        return;
    }
    
    signStr = [signStr substringWithRange:NSMakeRange(0, signStr.length - 1)];
    if (selectCount > 3) {
        signStr = [signStr stringByAppendingString:@"..."];
    }
    signStr = [signStr stringByAppendingString:[NSString stringWithFormat:@"这%ld笔订单,请确认用户已收货，且您已收到这%ld笔贷款",(long)selectCount,(long)selectCount]];
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
    [confirmView setSignStr:@[signStr,@"交易成功"]];
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
        scanConfirmView.alpha = 0;
        confirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
        scanConfirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
    }completion:^(BOOL finished) {
        maskView.hidden = YES;
        confirmView.hidden = YES;
        scanConfirmView.hidden = YES;
        [maskView removeFromSuperview];
        [confirmView removeFromSuperview];
        [scanConfirmView removeFromSuperview];
    }];
}

- (void)scanConfirm {
    
    if (!scanConfirmView.type) {
        [self.hud showTipMessageAutoHide:@"请先选择打印类型"];
        return;
    }
    
    [self cancelConfirm];
    
    MKScanViewController *controller = [[MKScanViewController alloc] initWithTitle:@"打码扫印"];
    controller.printStr = printString;
    controller.printType = scanConfirmView.type;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)confirm {
    NSString *requestStr = @"order/";
    for (int index = 0; index < selectIdArray.count; index ++) {
        requestStr = [requestStr stringByAppendingString:!index ? selectIdArray[index] : [NSString stringWithFormat:@",%@",selectIdArray[index]]];
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
