//
//  MKMemberManageController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/30.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKMemberManageController.h"
#import "MKAddAccountController.h"
#import "MKMemberDetailController.h"

#import "MKMemManageCell.h"
#import "MKMemManageTable.h"

#import "MKMemberBaseModel.h"

@interface MKMemberManageController ()

@end

@implementation MKMemberManageController
{
    UISearchBar *searchBar;
    MKMemManageTable *memberTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(ws)
    memberTable.cellSelcet =^(UITableView *tableView,NSIndexPath *indexPath){
        [ws cellSelect:(MKMemManageTable *)tableView indexPath:indexPath];
    };
    memberTable.reloadMessage =^(UITableView *tableView) {
        [ws tableViewReload:(MKMemManageTable *)tableView];
    };
    memberTable.mj_footer = nil;
    
    [self setMemberTableDataArras];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [memberTable.mj_header beginRefreshing];
}

- (void)setTopView {
    [super setTopView];
    [self.topView.rightButton setImage:[[UIImage imageNamed:@"mberManAdd"] imageByScalingToSize:CGSizeMake(18 * autoSizeScaleW, 18 * autoSizeScaleW)] forState:UIControlStateNormal];
    [self.topView setRightEvent:self action:@selector(gotoAddMember)];
}

- (void)CreatView {
    searchBar = [[UISearchBar alloc] init];
    memberTable = [[MKMemManageTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"memberCell" class:[MKMemManageCell class]];
    
    [self addSubview:searchBar];
    [self addSubview:memberTable];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    searchBar.placeholder = @"搜索";
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    [searchField setValue:FONT(12) forKeyPath:@"_placeholderLabel.font"];
    searchField.font = FONT(12);
    searchField.backgroundColor = VIEWBACKGRAY;
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.topView.mas_bottom);
        make.left.right.mas_equalTo(ws.view);
        make.height.mas_equalTo(40 * autoSizeScaleH);
    }];
    
    memberTable.sectionIndexBackgroundColor = [UIColor clearColor];
    memberTable.sectionIndexColor = [UIColor hexStringToColor:@"#A5A5A5"];
    [memberTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(searchBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(ws.view);
    }];
    
    [super updateViewConstraints];
}

- (void)setMemberTableDataArras {
    for (int count = 0; count < 27; count ++) {
        NSMutableArray *arra = [[NSMutableArray alloc] init];
        [memberTable.dataArray addObject:arra];
    }
}

- (void)tableViewReload:(MKMemManageTable *)tableView {
    
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:@"member" params:plist success:^(id json) {
        NSMutableDictionary *dic = (NSMutableDictionary *)[json objectForKey:@"data"];
        NSMutableArray *indexes = tableView.indexes;
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSInteger index = [indexes indexOfObject:key];
            NSMutableArray *dataArra = tableView.dataArray[index];
            NSArray *datas = [MKMemberBaseModel mj_objectArrayWithKeyValuesArray:obj];
            [dataArra removeAllObjects];
            for (MKMemberBaseModel *item in datas) {
                [dataArra addObject:item];
            }
        }];
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [tableView.mj_header endRefreshing];
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:@"没有啦"];
        [tableView.mj_header endRefreshing];
    }];
    
}

- (void)cellSelect:(MKMemManageTable *)tableView indexPath:(NSIndexPath *)indexPath {
    NSMutableArray *dataArray = tableView.dataArray[[tableView.sectionArray[indexPath.section] integerValue]];
    MKMemberBaseModel *model = dataArray[indexPath.row];
    MKMemberDetailController *controller = [[MKMemberDetailController alloc] initWithTitle:@"会员详情"];
    controller.memberId = model.memberId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)gotoAddMember {

    MKAddAccountController *controller = [[MKAddAccountController alloc] initWithType:1];
    [self.navigationController pushViewController:controller animated:YES];
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
