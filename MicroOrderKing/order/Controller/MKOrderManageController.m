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
#import "MKFilterView.h"
#import "XHDatePickerView.h"
#import "MKTimeChoiceView.h"

#import "MKOrderCellModel.h"

#import "NSDate+Extension.h"


@interface MKOrderManageController ()

@end

@implementation MKOrderManageController
{
    UIView *maskView;
    UIView *maskView2;      //筛选层的遮盖层
    UIView *maskView3;      //时间选择的遮盖层
    MKConfirmView *confirmView;
    MKScanConfirmView *scanConfirmView;
    MKFilterView *filterView;
    XHDatePickerView *datePickerView;
    MKTimeChoiceView *timeChoiceView;
    UIButton *filterButn;
    
    NSMutableArray *pageArray;
    NSMutableArray *selectIdArray;
    NSString *printString;      //批量打印的IDString
    MASConstraint *filterTopConstraint;
    BOOL isFilter;  //按钮的颜色状态标示
    BOOL isFiltering;   //界面是否处于筛选状态
    NSDate *_startDate;
    NSDate *_endDate;
    NSInteger _payStatus;
    NSInteger _method;
    MASConstraint *timeTopConstraint;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tabScrollerView.backgroundColor = [UIColor yellowColor];
    
    WS(ws)
    
    isFilter = NO;  //是否正在筛选
    isFiltering = NO;
    
    maskView3 = [[UIView alloc] init];
    timeChoiceView = [[MKTimeChoiceView alloc] initWithDate:[NSDate date] isFilter:YES];
    
    [self.view addSubview:maskView3];
    [self.view addSubview:timeChoiceView];
    
    [self.view sendSubviewToBack:maskView3];
    [self.view sendSubviewToBack:timeChoiceView];
    
    maskView3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    maskView3.alpha = 0;
    maskView3.hidden = YES;
    [maskView3 addTapEventWith:self action:@selector(timeCancel)];
    [maskView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(ws.view);
        make.center.mas_equalTo(ws.view);
    }];
    
    [timeChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.view);
        timeTopConstraint = make.top.mas_equalTo(ws.view.mas_bottom);
    }];
    
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
    
    timeChoiceView.timeConfirmBlock = ^(NSDate *date) {
        [ws timeConfirm:date];
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
    
    filterButn = [[UIButton alloc] init];
    [self.topView addSubview:filterButn];
    [filterButn setImage:[[UIImage imageNamed:@"filterNomal"] imageByScalingToSize:CGSizeMake(17, 17)] forState:UIControlStateNormal];
    [filterButn addTarget:self action:@selector(filterButnClick) forControlEvents:UIControlEventTouchUpInside];
    WS(ws)
    
    [filterButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws.topView.rightView.mas_left).offset(20 * autoSizeScaleW);
        make.bottom.mas_equalTo(ws.topView);
        make.width.height.mas_equalTo(40 * autoSizeScaleH);
    }];
    
    maskView2 = [[UIView alloc] init];
    maskView2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    maskView2.alpha = 0;
    maskView2.hidden = YES;
    [self addSubview:maskView2];
    [self.view sendSubviewToBack:maskView2];
    [maskView2 addTapEventWith:self action:@selector(cancelFilter)];
    [maskView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.topView.mas_bottom);
        make.left.right.bottom.mas_equalTo(ws.view);
    }];
    
    filterView = [[MKFilterView alloc] init];
    [self.view addSubview:filterView];
    [self.view sendSubviewToBack:filterView];
    filterView.hidden = YES;
    filterView.timeView.timeButnBlock = ^(NSInteger index) {
        [ws timeChooseBlock:index];
    };
    filterView.filterCancelBlock = ^{
        [ws cancelFilter];
    };
    filterView.filterCanfirmBlock = ^(NSInteger payStatus,NSInteger method){
        [ws confirmFilterWithPayStatus:payStatus andMethod:method];
    };
    
    [filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        filterTopConstraint = make.top.mas_equalTo(ws.view).offset(-330 * autoSizeScaleH);
        make.left.right.mas_equalTo(ws.view);
    }];
}

- (void)goToSearch {
    MKSearchGoodsController *controller = [[MKSearchGoodsController alloc] initWithType:0];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)filterButnClick {
    isFilter = !isFilter;
    if (isFilter) {
        [self goToFilter];
    } else {
        [self cancelFilter];
    }
}

- (void)timeConfirm:(NSDate *)date {
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateStr = [formatter stringFromDate:date];
    
    if (!timeChoiceView.searchType) {
        _startDate = date;
    }else{
        _endDate = date;
    }
    
    [filterView.timeView setTimeContentWithStart:[self transformIntoString:_startDate]
                                             End:[self transformIntoString:_endDate]];
//    deliverTime = dateStr;
//    [otherView setDateStr:dateStr];
    
    [self timeCancel];
}

- (void)timeChooseBlock:(NSInteger)index {
    
    WS(ws)
    
    timeChoiceView.searchType = index;
    
    if (_startDate != nil && index == 1) {
        [timeChoiceView setLimitString:[self transformIntoString:_startDate]];
    }
    
    if (_endDate != nil && index == 0) {
        [timeChoiceView setLimitString:[self transformIntoString:_endDate]];
    }
    
    [timeTopConstraint uninstall];
    [timeChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        timeTopConstraint = make.top.mas_equalTo(ws.view.mas_bottom).offset(-225 * autoSizeScaleH);
    }];
    
    maskView3.hidden = NO;
    timeChoiceView.hidden = NO;
    [self.view bringSubviewToFront:maskView3];
    [self.view bringSubviewToFront:timeChoiceView];
    
    [UIView animateWithDuration:.3 animations:^{
        maskView3.alpha = 1;
        [self.view layoutIfNeeded];
    }];
    
//    datePickerView = [[XHDatePickerView alloc] initWithCurrentDate:[NSDate date] CompleteBlock:^(NSDate *startDate, NSDate *endDate) {
//        
//        if (startDate) {
//            _startDate = startDate;
//        }
//        if (endDate) {
//            if (_startDate) {
//                if (![self checkIsSameDay:endDate WithEnd:_startDate]) {
//                    if ([endDate compare:_startDate] == NSOrderedAscending) {
//                        [self.hud showTipMessageAutoHide:@"结束日期不能小于开始日期"];
//                        return ;
//                    }
//                }
//            }
//            _endDate = endDate;
//        }
//        if (startDate) {
//            if (_endDate) {
//                if (![self checkIsSameDay:startDate WithEnd:_endDate]) {
//                    if ([_endDate compare:startDate] == NSOrderedAscending) {
//                        [self.hud showTipMessageAutoHide:@"开始日期不能大于结束日期"];
//                        return ;
//                    }
//                }
//            }
//            _endDate = endDate;
//        }
//        if (startDate && endDate) {
//            if (![self checkIsSameDay:startDate WithEnd:endDate]) {
//                if ([endDate compare:startDate] == NSOrderedAscending) {
//                    [self.hud showTipMessageAutoHide:@"开始日期不能大于结束日期"];
//                    return ;
//                }
//            }
//        }
//        
//        [filterView.timeView setTimeContentWithStart:[self transformIntoString:startDate]
//                                                 End:[self transformIntoString:endDate]];
//        
//    }];
//    
//    datePickerView.datePickerStyle = DateStyleShowYearMonthDay;
//    datePickerView.dateType = DateTypeStartDate;
//    datePickerView.minLimitDate = [self transformIntoDate:@"2005-01-01 00:00"];
//    datePickerView.maxLimitDate = [self transformIntoDate:@"2200-01-01 00:00"];
//    [datePickerView show];
//    [datePickerView setSegmenSelectIndex:index];
//    [datePickerView getNowDate:[self setSelectDate:index] animated:YES];
}

- (void)timeCancel {
    
    WS(ws)
    
    [timeTopConstraint uninstall];
    [timeChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        timeTopConstraint = make.top.mas_equalTo(ws.view.mas_bottom);
    }];
    
    [UIView animateWithDuration:.3 animations:^{
        maskView3.alpha = 0;
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        maskView3.hidden = YES;
        timeChoiceView.hidden = YES;
        [self.view sendSubviewToBack:maskView3];
    }];
}

- (BOOL)checkIsSameDay:(NSDate *)start WithEnd:(NSDate *)end {
    NSString *startStr = [self transformIntoString:start];
    NSString *endStr = [self transformIntoString:end];
    return [startStr isEqualToString:endStr];
}

- (NSString *)transformIntoString:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter stringFromDate:date];
}

- (NSDate *)transformIntoDate:(NSString *)dateStr {     //字符转化为时间的误差修正
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate *date =[dateFormat dateFromString:dateStr];
    
    return date;
}

- (NSDate *)setSelectDate:(NSInteger)selectIndex {  //如果是开始日期的话  是当天的最开始时间 如果是结束日期的话 就是现在时间
    
    NSDate *now1 = [NSDate dateWithTimeIntervalSinceNow:0];
    //NSString *string = [now1 stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSLog(@"%@",string);
    
    NSString *dateStr = [now1 stringWithFormat:@"yyyy-MM-dd"];
    
    NSDate *now2 = [self transformIntoDate:[NSString stringWithFormat:@"%@ %@",dateStr,@"00:00:01"]];
    
    if (!selectIndex) {
        return !_startDate ? now2 : _startDate;
    } else {
        return !_endDate ? now1 : _endDate;
    }
    
}

- (void)goToFilter {
    
    WS(ws)
    
    [filterButn setImage:[[UIImage imageNamed:@"filterSelect"] imageByScalingToSize:CGSizeMake(17, 17)] forState:UIControlStateNormal];
    
    [self.view bringSubviewToFront:self.tabScrollerView];
    [self.view bringSubviewToFront:maskView2];
    [self.view bringSubviewToFront:filterView];
    [self.view bringSubviewToFront:self.topView];
    
    [filterTopConstraint uninstall];
    [filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        filterTopConstraint = make.top.mas_equalTo(ws.view).offset(64 * autoSizeScaleH);
    }];
    
    maskView2.hidden = NO;
    filterView.hidden = NO;
    //filterView.alpha = 0;
    [UIView animateWithDuration:.3 animations:^{
        maskView2.alpha = 1;
        //filterView.alpha = 1;
        [self.view layoutIfNeeded];
    }];
}

- (void)confirmFilterWithPayStatus:(NSInteger)payStatus andMethod:(NSInteger)method {
    
//    if (payStatus - 1 == -2) {
//        [self.hud showTipMessageAutoHide:@"请先选择付款状态"];
//        return;
//    }
//    if (method - 1 == -2) {
//        [self.hud showTipMessageAutoHide:@"请先选择配送方式"];
//        return;
//    }
//    if (!_startDate) {
//        [self.hud showTipMessageAutoHide:@"请先选择开始日期"];
//        return;
//    }
//    if (!_endDate) {
//        [self.hud showTipMessageAutoHide:@"请先选择结束日期"];
//        return;
//    }
    
    [self cancelFilter];
    
    isFiltering = YES;
    _payStatus = payStatus - 1;
    _method = method - 1;
    
    for (NSMutableArray *array in self.dataAllArray) {
        [array removeAllObjects];
    }
    BaseUITableView *table = self.tableViewArray[self.currentIndex];
    [table.mj_header beginRefreshing];
}

- (void)cancelFilter {
    
    [filterButn setImage:[[UIImage imageNamed:@"filterNomal"] imageByScalingToSize:CGSizeMake(17, 17)] forState:UIControlStateNormal];
    
    WS(ws)
    [filterTopConstraint uninstall];
    [filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        filterTopConstraint = make.top.mas_equalTo(ws.view).offset(-330 * autoSizeScaleH);
    }];
    
    //[self.view sendSubviewToBack:self.topView];
    
    [UIView animateWithDuration:.2 animations:^{

        maskView2.alpha = 0;
        //filterView.alpha = 0;
        [self.view layoutIfNeeded];
        
    }completion:^(BOOL finished) {

        maskView2.hidden = YES;
        filterView.hidden = YES;
        [self.view sendSubviewToBack:maskView2];
        [self.view sendSubviewToBack:filterView];
        
    }];
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
    if (isFiltering) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        if (_startDate) {
            [plist setObject:[formatter stringFromDate:_startDate] forKey:@"start_time"];
        }
        if (_endDate) {
             [plist setObject:[formatter stringFromDate:_endDate] forKey:@"end_time"];   
        }
        if (_payStatus > -1) {
            [plist setObject:!_payStatus ? @"1" : @"0" forKey:@"pay_status"];
        }
        if (_method > -1) {
            [plist setObject:@(_method) forKey:@"shipping_method"];
        }
    }
    [AFNetWorkingUsing httpGet:@"order" params:plist success:^(id json) {
        NSMutableArray *modelArra = [MKOrderCellHttpModel mj_objectWithKeyValues:json].data;
        [dataArra removeAllObjects];
        for (MKOrderCellModel *model in modelArra) {
            model.isSelected = YES;
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
    [pageArray replaceObjectAtIndex:refreshIndex withObject:@(page)];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@(page) forKey:@"page"];
    [plist setObject:@(refreshIndex) forKey:@"post_status"];
    if (isFiltering) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        if (_startDate) {
            [plist setObject:[formatter stringFromDate:_startDate] forKey:@"start_time"];
        }
        if (_endDate) {
            [plist setObject:[formatter stringFromDate:_endDate] forKey:@"end_time"];
        }
        //[plist setObject:[formatter stringFromDate:_startDate] forKey:@"start_time"];
        //[plist setObject:[formatter stringFromDate:_endDate] forKey:@"end_time"];
        if (_payStatus > -1) {
            [plist setObject:!_payStatus ? @"1" : @"0" forKey:@"pay_status"];
        }
        if (_method > -1) {
            [plist setObject:@(_method) forKey:@"shipping_method"];
        }
    }
    [AFNetWorkingUsing httpGet:@"order" params:plist success:^(id json) {
        NSMutableArray *modelArra = [MKOrderCellHttpModel mj_objectWithKeyValues:json].data;
        for (int count = 0; count < modelArra.count; count ++) {
            MKOrderCellModel *model = modelArra[count];
            model.isSelected = YES;
            [dataArra addObject:model];
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
