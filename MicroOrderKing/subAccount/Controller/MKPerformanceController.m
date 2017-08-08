//
//  MKPerformanceController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKPerformanceController.h"

#import "MKMemberCell.h"
#import "MKOrderManageCell.h"

#import "MKOrderCellModel.h"
#import "MKAccountBaseModel.h"

@interface MKPerformanceController ()

@end

@implementation MKPerformanceController
{
    NSMutableArray *pageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)tabScrollViewSetting {
    
    self.tableViewArray = [[NSMutableArray alloc] initWithObjects:
                           [[BaseUITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"memberCell" class:[MKMemberCell class]],
                           [[BaseUITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"orderHistory" class:[MKOrderManageCell class]], nil];
    [self setTabDataSource:[[NSMutableArray alloc] initWithObjects:@"会员数",@"订单数", nil]];
    [self.tabScrollerView SetButnNormalColor:[UIColor hexStringToColor:@"#666666"] andSelectedColor:themeGreen];
    [self.tabScrollerView SetButnFont:FONT(14)];
    [self.tabScrollerView SetSlideViewBackgroundColor:themeGreen];
}

- (void)setData {
    
    pageArray = [[NSMutableArray alloc] initWithObjects:@(1),@(1), nil];
    
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
    NSInteger page = [pageArray[refreshIndex] integerValue];
    page = 1;
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:_userId forKey:@"single"];
    [AFNetWorkingUsing httpGet:@"member" params:plist success:^(id json) {
        
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:@"没有了"];
    }];
}

- (void)menberDataReload {

}

/**
 *  上拉加载
 *
 *  @param tableView <#tableView description#>
 */
-(void)tableViewLoadMore:(UITableView *)tableView
{
    [tableView reloadData];
    [tableView.mj_footer endRefreshing];
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
