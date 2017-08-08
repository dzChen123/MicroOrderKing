//
//  BaseScrollTableViewController.h
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/11.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTabButtonScrollView.h"
#import "BaseUITableView.h"
@interface BaseScrollTableViewController : BaseViewController
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSMutableArray *tabDataSource;
@property (nonatomic,strong) NSMutableArray *pageArray;
@property (nonatomic,strong) NSMutableArray *dataAllArray;
@property (nonatomic,strong) NSMutableArray *tableViewArray;
@property (nonatomic,strong) UIScrollView *tableViewScrollView;
@property (nonatomic,strong) BaseTabButtonScrollView *tabScrollerView;
- (void)setData;
- (void)TableViewLayout;
- (void)changeTableViewAndLoadData;
@property (nonatomic,strong) void (^cellSelcet)(UITableView *tableView,NSIndexPath *indexPath);

@property (assign,nonatomic) NSInteger changeIndex;

@end
