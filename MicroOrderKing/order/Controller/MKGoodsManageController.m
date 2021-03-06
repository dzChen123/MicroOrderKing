//
//  MKGoodsManageController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKGoodsManageController.h"
#import "MKNewGoodsController.h"
#import "MKSearchGoodsController.h"

#import "MKGoodsManageCell.h"
#import "BaseUITableView.h"

#import "MKOrderCellModel.h"

#define listRows 5

@interface MKGoodsManageController ()

@end

@implementation MKGoodsManageController
{
    UIButton *addButn;
    
    NSInteger page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(ws)
    
    _manageTable.reloadMessage =^(UITableView *tableView){
        [ws tableViewReload:(BaseUITableView *)tableView];
    };
    
    _manageTable.loadMoreMessage =^(UITableView *tableView){
        [ws tableViewLoadMore:(BaseUITableView *)tableView];
    };
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_manageTable.mj_header beginRefreshing];
}

- (void)setTopView{
    [super setTopView];
    self.topTitle = @"商品管理";
    [self.topView.rightButton setImage:[[UIImage imageNamed:@"comManSearch"] imageByScalingToSize:CGSizeMake(20, 20)]
                              forState:UIControlStateNormal];
    [self.topView setRightEvent:self action:@selector(goToSearch)];
}

- (void)goToSearch {
    MKSearchGoodsController *controller = [[MKSearchGoodsController alloc] initWithType:1];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)goToNewGoods {
    MKNewGoodsController *controller = [[MKNewGoodsController alloc] initWithTitle:@"新增商品"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)CreatView {
    
    page = 1;
    _manageTable = [[BaseUITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"manageCell" class:[MKGoodsManageCell class]];
    addButn = [[UIButton alloc] init];
    
    [self addSubview:_manageTable];
    [self addSubview:addButn];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [addButn addTarget: self action:@selector(goToNewGoods) forControlEvents:UIControlEventTouchUpInside];
    [addButn setTitle:@" 新增商品" forState:UIControlStateNormal];
    [addButn setImage:[[UIImage imageNamed:@"comManAdd"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)] forState:UIControlStateNormal];
    [addButn setTitleColor:customWhite forState:UIControlStateNormal];
    addButn.backgroundColor = themeGreen;
    addButn.titleLabel.font = FONT(14);
    [addButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(ws.view);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    [_manageTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.topView.mas_bottom);
        make.bottom.mas_equalTo(addButn.mas_top);
        make.left.right.mas_equalTo(ws.view);
    }];
    
    [super updateViewConstraints];
}

- (void)tableViewReload:(BaseUITableView *)tableView {
    
    page = 1;
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@(page) forKey:@"page"];
    [plist setObject:@(listRows) forKey:@"list_rows"];
    [AFNetWorkingUsing httpGet:@"goods" params:plist success:^(id json) {
        NSMutableArray *modelArr = [MKGoodsInfoHttpModel mj_objectWithKeyValues:json].data;
        [tableView.dataArray removeAllObjects];
        for (int count = 0; count < modelArr.count; count ++) {
            [tableView.dataArray addObject:modelArr[count]];
        }
        [self GoodsSorting:tableView.dataArray];
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
 
    } other:^(id json) {
        [tableView.dataArray removeAllObjects];
        [self.hud showTipMessageAutoHide:@"暂无数据"];
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
    }];
    
}

- (void)tableViewLoadMore:(BaseUITableView *)tableView {
    
    page ++;
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@(page) forKey:@"page"];
    [plist setObject:@(listRows) forKey:@"list_rows"];
    [AFNetWorkingUsing httpGet:@"goods" params:plist success:^(id json) {
        NSMutableArray *modelArr = [MKGoodsInfoHttpModel mj_objectWithKeyValues:json].data;
        for (int count = 0; count < modelArr.count; count ++) {
            [tableView.dataArray addObject:modelArr[count]];
        }
        [self GoodsSorting:tableView.dataArray];
        [tableView reloadData];
        [tableView.mj_footer endRefreshing];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [tableView reloadData];
        [tableView.mj_footer endRefreshing];
        [self.hud showTipMessageAutoHide:@"已无新数据"];
    }];
}

//---获得的商品列表是混乱的  要进行ID从大到小排序且下架商品放在最后---

- (void)GoodsSorting:(NSMutableArray *)array {
//    for (int i = 0 ;i < array.count ;i ++ ) {
//        NSLog(@"before:%@",((MKGoodsInfoModel *)array[i]).goodsId);
//    }
    for (int i = 0; i < array.count; i ++) {
        for (int j = 0; j < array.count - 1; j ++) {
            MKGoodsInfoModel *model1 = array[j];
            MKGoodsInfoModel *model2 = array[j + 1];
            if ([model2.goodsId integerValue] > [model1.goodsId integerValue]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
    }
    //将下架的商品移动到列表的最下面
    NSMutableArray *indexArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; i ++) {
        MKGoodsInfoModel *model = array[i];
        if (![model.isSale integerValue]) {
            [indexArray addObject:model];
        }
    }
    for (int i = 0; i < indexArray.count; i ++) {
        MKGoodsInfoModel *model = indexArray[i];
        [array removeObject:model];
        [array addObject:model];
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
