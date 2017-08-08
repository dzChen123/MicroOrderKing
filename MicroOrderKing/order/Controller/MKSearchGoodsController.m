//
//  MKSearchGoodsController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKSearchGoodsController.h"

#import "MKSearchTable.h"

@interface MKSearchGoodsController ()

@end

@implementation MKSearchGoodsController
{
    UISearchBar *searchBar;
    MKSearchTable *searchTable;
    UIButton *clearButn;
    
    MASConstraint *heightConstraint;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)setTopView {
    
    [super setTopView];
    
    self.topView.hidden = YES;
}

- (void)CreatView {
    searchBar = [[UISearchBar alloc] init];
    searchTable = [[MKSearchTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"searchCell" class:[MKsearchCell class]];
    clearButn = [[UIButton alloc] init];
    
    [self addSubview:searchBar];
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
    searchBar.placeholder = @"搜索";
    searchBar.showsCancelButton = YES;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = VIEWBACKGRAY;
    if (SCREEN_WIDTH == 320) {
        searchBar.placeholder = @"搜索                                            ";
    }else if (SCREEN_WIDTH == 375 ){
        searchBar.placeholder = @"搜索                                                         ";
    }else if (SCREEN_WIDTH == 414 ){
        searchBar.placeholder = @"搜索                                                                   ";
    }
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws.containerView);
        make.height.mas_equalTo(45 * autoSizeScaleW);
    }];
    
    [clearButn setImage:[[UIImage imageNamed:@"searchPageEmplcon"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)] forState:UIControlStateNormal];
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
    
    WS(ws)
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.view).offset(24 * autoSizeScaleH);
        make.left.right.bottom.mas_equalTo(ws.view);
    }];
    
    [searchTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.containerView);
        make.top.mas_equalTo(searchBar.mas_bottom);
        heightConstraint = make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    

    [self reloadData];
    
}

- (void)reloadData{
    
    [searchTable.dataArray removeAllObjects];
    [searchTable.dataArray addObject:@"苹果"];
    [searchTable.dataArray addObject:@"苹果"];
    [searchTable.dataArray addObject:@"苹果"];
    
    CGFloat height = (45 + 45 * searchTable.dataArray.count) * autoSizeScaleH;
    
    [heightConstraint uninstall];
    [searchTable mas_makeConstraints:^(MASConstraintMaker *make) {
        heightConstraint = make.height.mas_equalTo(height);
    }];
    
    [searchTable reloadData];
    
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
