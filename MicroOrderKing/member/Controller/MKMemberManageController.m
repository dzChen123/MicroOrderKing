//
//  MKMemberManageController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/30.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKMemberManageController.h"
#import "MKAddMemberController.h"
#import "MKMemberDetailController.h"
#import "MKSearchGoodsController.h"
#import "MKHomePageViewController.h"

#import "MKMemManageCell.h"
#import "MKMemManageTable.h"

#import "MKMemberBaseModel.h"

@interface MKMemberManageController ()<UISearchBarDelegate>

@end

@implementation MKMemberManageController
{
    UISearchBar *searcherBar;
    UIView *maskView;   //遮盖在searchBar上
    MKMemManageTable *memberTable;
    BOOL isSearched;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    isSearched = NO;
    
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
    searcherBar = [[UISearchBar alloc] init];
    memberTable = [[MKMemManageTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"memberCell" class:[MKMemManageCell class]];
    maskView = [[UIView alloc] init];
    
    [self addSubview:searcherBar];
    [self addSubview:memberTable];
    [self addSubview:maskView];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    searcherBar.placeholder = @"搜索";
    searcherBar.searchBarStyle = UISearchBarStyleMinimal;
    UITextField *searchField = [searcherBar valueForKey:@"_searchField"];
    [searchField setValue:FONT(12) forKeyPath:@"_placeholderLabel.font"];
    searchField.font = FONT(12);
    searchField.backgroundColor = VIEWBACKGRAY;
    searcherBar.delegate = self;
    [searcherBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.topView.mas_bottom);
        make.left.right.mas_equalTo(ws.view);
        make.height.mas_equalTo(40 * autoSizeScaleH);
    }];
    
    memberTable.sectionIndexBackgroundColor = [UIColor clearColor];
    memberTable.sectionIndexColor = [UIColor hexStringToColor:@"#A5A5A5"];
    [memberTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(searcherBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(ws.view);
    }];
    
    maskView.backgroundColor = [UIColor clearColor];
    [maskView addTapEventWith:self action:@selector(goToSearch)];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(searcherBar);
        make.center.mas_equalTo(searcherBar);
    }];
    
    [super updateViewConstraints];
}

- (void)goToSearch{
    MKSearchGoodsController *controller = [[MKSearchGoodsController alloc] initWithType:2];
    [self.navigationController pushViewController:controller animated:YES];
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
        NSMutableArray *memberDicArra = [[NSMutableArray alloc] init];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSInteger index = [indexes indexOfObject:key];
            NSMutableArray *dataArra = tableView.dataArray[index];
            NSArray *datas = [MKMemberBaseModel mj_objectArrayWithKeyValuesArray:obj];
            [memberDicArra addObject:obj];
            [dataArra removeAllObjects];
            for (int count = 0; count < datas.count; count ++) {
                [dataArra addObject:datas[count]];
            }
        }];
        [ZYFUserDefaults setObject:memberDicArra key:@"memberDics"];
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [tableView.mj_header endRefreshing];
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:@"暂无数据"];
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

    MKAddMemberController *controller = [[MKAddMemberController alloc] initWithTitle:@"新增会员"];
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
