//
//  MKAddGoodsController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAddGoodsController.h"
#import "MKOrderWritingController.h"

#import "BaseUITableView.h"
#import "MKAddGoodsCell.h"
#import "MKGoodsBottomView.h"

#import "MKOrderCellModel.h"

@interface MKAddGoodsController ()

@end

@implementation MKAddGoodsController
{
    MKGoodsBottomView *bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(ws)
    _goodsTable.mj_header = nil;
    _goodsTable.mj_footer = nil;
    
    [bottomView setSelecNum:_totalCount];
    bottomView.clearClickBlock =^(){
        [ws clearBlock];
    };
    
    bottomView.confirmClickBlock =^(){
        [ws confirmBlock];
    };
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tableViewReload:_goodsTable];
}

- (void)setTopView {
    [super setTopView];
    self.topTitle = @"添加商品";
}

- (void)CreatView {
    
    _goodsTable = [[BaseUITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"addGoodsCell" class:[MKAddGoodsCell class]];
    bottomView = [[MKGoodsBottomView alloc] init];
    [self addSubview:_goodsTable];
    [self addSubview:bottomView];
    
}

- (void)setTotalCount:(NSInteger)totalCount {
    [bottomView setSelecNum:totalCount];
}

- (void)setBottomCount {
    NSInteger count = 0;
    for (MKAddGoodsCellModel *model in _goodsTable.dataArray) {
        count += [model.buyCount integerValue];
    }
    self.totalCount = count;
}

- (void)clearBlock {
    self.totalCount = 0;
    for (MKAddGoodsCellModel *model in _goodsTable.dataArray) {
        model.buyCount = @"0";
    }
    [_goodsTable reloadData];
}

- (void)confirmBlock {
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MKOrderWritingController class]]) {
            MKOrderWritingController *parent = (MKOrderWritingController *)controller;
            parent.tableViewData = _goodsTable.dataArray;
            parent.isOrdered = YES;
            [self.navigationController popToViewController:parent animated:YES];
            break;
        }
    }
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [_goodsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.topView.mas_bottom);
        make.left.right.mas_equalTo(ws.view);
        make.bottom.mas_equalTo(bottomView.mas_top).offset(-10 * autoSizeScaleH);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(ws.view);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    [super updateViewConstraints];
}

- (void)tableViewReload:(BaseUITableView *)tableView {

    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@"1" forKey:@"list"];
    [AFNetWorkingUsing httpGet:@"goods" params:plist success:^(id json) {
        NSMutableArray *modelArra = [MKAddGoodsCellHttpModel mj_objectWithKeyValues:json].data;
        [tableView.dataArray removeAllObjects];
        NSInteger count = 0;
        for (MKAddGoodsCellModel *model in modelArra) {
            model.buyCount = @"0";
            if (_tableViewData != nil && _tableViewData.count > 0) {
                for (MKCountCostCellModel *costModel in _tableViewData) {
                    if ([costModel.goodsCellModel.goodsId isEqualToString:model.goodsId]) {
                        model.buyCount = costModel.goodsCellModel.buyCount;
                        count += [costModel.goodsCellModel.buyCount integerValue];
                        break;
                    }
                }
            }
            [tableView.dataArray addObject:model];
        }
        self.totalCount = count;
        [tableView reloadData];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
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
