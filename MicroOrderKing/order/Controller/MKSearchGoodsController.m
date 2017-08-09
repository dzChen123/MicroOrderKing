//
//  MKSearchGoodsController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKSearchGoodsController.h"
#import "MKSearResultController.h"

#import "MKSearchTable.h"

#define orderHistory @"orderHistory"
#define goodsHistory @"goodsHistory"
#define memberHistory @"memberHistory"

@interface MKSearchGoodsController ()<UISearchBarDelegate>

@end

@implementation MKSearchGoodsController
{
    UISearchBar *searcherBar;
    MKSearchTable *searchTable;
    UIButton *clearButn;
    
    MASConstraint *heightConstraint;
    NSInteger _type;
    NSMutableArray *historyData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(ws)
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.view).offset(24 * autoSizeScaleH);
        make.left.right.bottom.mas_equalTo(ws.view);
    }];
    
    [searchTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.containerView);
        make.top.mas_equalTo(searcherBar.mas_bottom);
        heightConstraint = make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    searchTable.mj_header = nil;
    searchTable.mj_footer = nil;
    searchTable.cellSelcet =^(UITableView *tablView,NSIndexPath *indexPath){
        [ws goToSearch:(BaseUITableView *)tablView indexPath:indexPath];
    };
    // Do any additional setup after loading the view.
}

- (void)setTopView {
    
    [super setTopView];
    self.topView.hidden = YES;
}

- (instancetype)initWithType:(NSInteger)type {
    if (self == [super init]) {
        _type = type;
    }
    return self;
}

- (void)CreatView {
    searcherBar = [[UISearchBar alloc] init];
    searchTable = [[MKSearchTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"searchCell" class:[MKsearchCell class]];
    clearButn = [[UIButton alloc] init];
    
    [self addSubview:searcherBar];
    [self addSubview:searchTable];
    [self addSubview:clearButn];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    MASAttachKeys(self.containerView,self.topView,searchTable,clearButn);
    
    self.view.backgroundColor = customWhite;
    
    
//    UIImageView *barImageView = [[[searchBar.subviews firstObject] subviews] firstObject];
//    barImageView.layer.borderColor = customWhite.CGColor;
//    barImageView.layer.borderWidth = 1;
//    searchBar.barTintColor = customWhite;
    searcherBar.placeholder = @"搜索";
    searcherBar.showsCancelButton = YES;
    searcherBar.delegate = self;
    searcherBar.searchBarStyle = UISearchBarStyleMinimal;
    UITextField *searchField = [searcherBar valueForKey:@"_searchField"];
    searchField.backgroundColor = VIEWBACKGRAY;
    if (SCREEN_WIDTH == 320) {
        searcherBar.placeholder = @"搜索                                            ";
    }else if (SCREEN_WIDTH == 375 ){
        searcherBar.placeholder = @"搜索                                                         ";
    }else if (SCREEN_WIDTH == 414 ){
        searcherBar.placeholder = @"搜索                                                                   ";
    }
    [searcherBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws.containerView);
        make.height.mas_equalTo(45 * autoSizeScaleW);
    }];
    
    [clearButn setImage:[[UIImage imageNamed:@"searchPageEmplcon"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)] forState:UIControlStateNormal];
    [clearButn addTarget:self action:@selector(clearHistoryData) forControlEvents:UIControlEventTouchUpInside];
    [clearButn setTitle:@" 清空历史记录" forState:UIControlStateNormal];
    [clearButn setTitleColor:[UIColor hexStringToColor:@"#A3A3A3"] forState:UIControlStateNormal];
    clearButn.titleLabel.font = FONT(14);
    clearButn.layer.masksToBounds = YES;
    clearButn.layer.cornerRadius = 3.0;
    clearButn.layer.borderWidth = 1.0;
    clearButn.layer.borderColor = [UIColor hexStringToColor:@"#F7F7F7"].CGColor;
    [clearButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.containerView);
        make.top.mas_equalTo(searchTable.mas_bottom).offset(15 * autoSizeScaleH);
        make.size.mas_equalTo(CGSizeMake(130 * autoSizeScaleW, 40 * autoSizeScaleH));
    }];
    
    [self setBottomView:clearButn withHeight:.1f];
    
    [super updateViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self reloadHistoryData];
}

- (void)reloadHistoryData{
    
    historyData = [[NSMutableArray alloc] init];
    
    [searchTable.dataArray removeAllObjects];
    for (NSString *data in [self getUserSerchHistoryWithType:_type]) {
        [historyData addObject:data];
        [searchTable.dataArray addObject:data];
    }
    
    CGFloat height = (45 + 45 * searchTable.dataArray.count) * autoSizeScaleH;
    
    [heightConstraint uninstall];
    [searchTable mas_makeConstraints:^(MASConstraintMaker *make) {
        heightConstraint = make.height.mas_equalTo(height);
    }];
    
    [self.view layoutIfNeeded];
    
    if (!historyData.count) {
        clearButn.hidden = YES;
    }else{
        clearButn.hidden = NO;
    }
    
    [searchTable reloadData];
    
}

- (void)clearHistoryData {
    
    [historyData removeAllObjects];
    
    [searchTable.dataArray removeAllObjects];
    
    CGFloat height = 45 * autoSizeScaleH;
    
    [heightConstraint uninstall];
    [searchTable mas_makeConstraints:^(MASConstraintMaker *make) {
        heightConstraint = make.height.mas_equalTo(height);
    }];
    
    clearButn.hidden = YES;
    
    [searchTable reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *regex = @"\\s*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:searchBar.text]) {
        NSString *searchText = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        MKSearResultController *controller = [[MKSearResultController alloc] initWithType:_type];
        controller.searchContent = searchText;
        if (![historyData containsObject:searchText]) {
             [historyData addObject:searchText];
        }
        [self setUserSearchHistoryWithType:_type array:historyData];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self.hud showTipMessageAutoHide:@"请不要输入空的内容"];
    }
}

- (void)goToSearch:(BaseUITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSString *searchText = tableView.dataArray[indexPath.row];
    MKSearResultController *controller = [[MKSearResultController alloc] initWithType:_type];
    controller.searchContent = searchText;
    [self.navigationController pushViewController:controller animated:YES];
}

- (NSMutableArray *)getUserSerchHistoryWithType:(NSInteger)type {
    NSMutableArray *historyDataArray;
    NSString *key;
    switch (type) {
        case 0:
            key = orderHistory;
            break;
        case 1:
            key = goodsHistory;
            break;
        case 2:
            key = memberHistory;
            break;
        default:
            break;
    }
    historyDataArray = [ZYFUserDefaults objectForKey:key];
    if (!historyDataArray) {
        historyDataArray = [[NSMutableArray alloc] init];
    }
    return historyDataArray;
}

- (void)setUserSearchHistoryWithType:(NSInteger)type array:(NSMutableArray *)arr {
    NSString *key;
    switch (type) {
        case 0:
            key = orderHistory;
            break;
        case 1:
            key = goodsHistory;
            break;
        case 2:
            key = memberHistory;
            break;
        default:
            break;
    }
    [ZYFUserDefaults setObject:arr key:key];
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
