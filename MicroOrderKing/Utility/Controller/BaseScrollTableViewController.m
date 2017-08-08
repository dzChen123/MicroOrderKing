//
//  BaseScrollTableViewController.m
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/11.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "BaseScrollTableViewController.h"
#import "ZYFUtilityPch.h"
@interface BaseScrollTableViewController ()<UIScrollViewDelegate>

@end

@implementation BaseScrollTableViewController
{
    NSInteger tabCount;
    UIView *containView;
    BOOL isScrolling;
}

/**
 *  创建view
 */
-(void)CreatView
{
    WS(ws)
    
//    self.view.backgroundColor=[UIColor greenColor];

    
    _tabScrollerView = [[BaseTabButtonScrollView alloc] init];
    _tabScrollerView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_tabScrollerView];
    [_tabScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view);
        if(self.topView)
        {
            make.top.mas_equalTo(ws.topView.mas_bottom);
        }
        else
        {
            make.top.mas_equalTo(ws.view);
        }
        make.height.mas_equalTo(40*autoSizeScaleH);
        make.right.mas_equalTo(ws.view);
    }];
    
    _tabScrollerView.changeIndexValue=^(NSInteger index)
    {
        [ws changeIndexBlack:index];
    };

    
    UIView *lineView =[[UIView alloc] init];
    lineView.backgroundColor=VIEWBACKGRAY;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view);
        make.right.mas_equalTo(ws.view);
        make.bottom.mas_equalTo(_tabScrollerView);
        make.height.mas_equalTo(0.5f);
    }];
    
    
    
    
    
    _tableViewScrollView= [[UIScrollView alloc] init];
    _tableViewScrollView.backgroundColor=[UIColor clearColor];
    _tableViewScrollView.pagingEnabled=YES;
    _tableViewScrollView.bounces=NO;
    _tableViewScrollView.showsHorizontalScrollIndicator=NO;
    _tableViewScrollView.showsVerticalScrollIndicator=NO;
    _tableViewScrollView.delegate=self;
    [self addSubview:_tableViewScrollView];
    [_tableViewScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view);
        make.width.mas_equalTo(ws.view);
        make.top.mas_equalTo(_tabScrollerView.mas_bottom).offset(0.5f);
        make.bottom.mas_equalTo(ws.view);
    }];
  
    containView = [[UIView alloc] init];
    [_tableViewScrollView addSubview:containView];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_tableViewScrollView);
        make.height.mas_equalTo(_tableViewScrollView);
    }];
}

- (void)changeIndexBlack:(NSInteger)indexValue {
    self.currentIndex=indexValue;
//    self.changeIndex = indexValue;
    [self changeTableViewAndLoadData];
}


/**
 *  设置tab数据
 *
 *  @param tabDataSource <#tabDataSource description#>
 */
-(void)setTabDataSource:(NSMutableArray *)tabDataSource
{
    _tabDataSource=tabDataSource;
    tabCount=_tabDataSource.count;
    _pageArray = [[NSMutableArray alloc] init];
    _dataAllArray = [[NSMutableArray alloc]init];
    [_tabScrollerView setData:tabDataSource];
    for (int i =0 ; i<tabDataSource.count; i++) {
        [_pageArray addObject:@(1)];
        [_dataAllArray addObject:[[NSMutableArray alloc] init]];
    }
    [self TableViewLayout];
  
}



-(void)TableViewLayout
{
    WS(ws)
    if(tabCount>3)
    {
        UIView *lastView;
        for (int i =0; i<3; i++) {
            BaseUITableView *tableView =(BaseUITableView*)_tableViewArray[i];
            tableView.reloadMessage=^(UITableView *tableView)
            {
                [ws tableViewReload:tableView];
            };
            tableView.loadMoreMessage=^(UITableView *tableView)
            {
                [ws tableViewLoadMore:tableView];
            };
            tableView.cellSelcet=^(UITableView *tableView,NSIndexPath *indexPath)
            {
                if(ws.cellSelcet)
                {
                    ws.cellSelcet(tableView,indexPath);
                }
            };
            [containView addSubview:tableView];
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(i*SCREEN_WIDTH);
                make.width.mas_equalTo(SCREEN_WIDTH);
                make.top.mas_equalTo(containView);
                make.bottom.mas_equalTo(ws.view);
            }];
            lastView=tableView;
        }
        [containView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(lastView);
        }];
    }
    else
    {
        UIView *lastView;
        for (int i =0; i<tabCount; i++) {
           BaseUITableView *tableView =(BaseUITableView*)_tableViewArray[i];
            tableView.reloadMessage=^(UITableView *tableView)
            {
                [ws tableViewReload:tableView];
            };
            tableView.loadMoreMessage=^(UITableView *tableView)
            {
                [ws tableViewLoadMore:tableView];
            };
            tableView.cellSelcet=^(UITableView *tableView,NSIndexPath *indexPath)
            {
                if(ws.cellSelcet)
                {
                    ws.cellSelcet(tableView,indexPath);
                }
            };
            [containView addSubview:tableView];
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(i*SCREEN_WIDTH);
                make.width.mas_equalTo(SCREEN_WIDTH);
                make.top.mas_equalTo(containView);
                make.bottom.mas_equalTo(ws.view);
            }];
            lastView=tableView;
        }
        [containView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(lastView);
        }];
    }
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setData];


    //    _currentIndex=0;
}

-(void)setData
{
    
}

- (void)viewWillAppear:(BOOL)animated{

}


-(void)viewDidAppear:(BOOL)animated
{
//    _currentIndex = _changeIndex;
    _tabScrollerView.index = _currentIndex;
    isScrolling = false;
    [self changeTableViewAndLoadData];
    
//    self.tableViewScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
}

/**
 *  下拉刷新
 *
 *  @param tableView <#tableView description#>
 */
-(void)tableViewReload:(UITableView *)tableView
{
    [tableView reloadData];
    [tableView.mj_header endRefreshing];
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


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
     isScrolling=true;
}


//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//    isScrolling=true;
//}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"x:%f",scrollView.contentOffset.x);
    if (scrollView != self.tableViewScrollView) {
        return;
    }
    //tableView继承scrollView，如果没有上面的判断下拉tableView的时候默认scrollView.contentOffset.x == 0也就是认为向右滑动
    if (scrollView.contentOffset.x == 0) {//右滑（看上一张）
        if(_currentIndex>0)
        _currentIndex--;
//        NSLog(@"%d",_currentIndex);
    }
    if (scrollView.contentOffset.x == SCREEN_WIDTH * 2){//左滑（看下一张）
        if(_currentIndex<tabCount-1)
        _currentIndex++;
//        NSLog(@"%d",_currentIndex);
    }
    if(tabCount<=2)
    {
        if (scrollView.contentOffset.x == SCREEN_WIDTH){//左滑（看下一张）
             if(_currentIndex<tabCount-1)
            _currentIndex++;
//            NSLog(@"%d",_currentIndex);
        }
    }
    
    if(tabCount>2)
    {
        //在最左边往左滑看下一张
        if (_currentIndex == 0 && scrollView.contentOffset.x >= SCREEN_WIDTH*0.75f&&scrollView.contentOffset.x <= SCREEN_WIDTH*1.25f)
        {
             if(_currentIndex<tabCount-1)
            _currentIndex++;
//            NSLog(@"%d",_currentIndex);
        }
        
        //在最右边往右滑看上一张
        if(_currentIndex == self.dataAllArray.count-1 && scrollView.contentOffset.x >= SCREEN_WIDTH*0.75f&&scrollView.contentOffset.x <= SCREEN_WIDTH*1.25f){
             if(_currentIndex>0)
            _currentIndex--;
//            NSLog(@"%d",_currentIndex);
        }
    }


}

//滚动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:self.tableViewScrollView]) {
        if (_currentIndex<0) {
            _currentIndex=0;
        }
        if (_currentIndex>self.dataAllArray.count-1) {
            _currentIndex=self.dataAllArray.count-1;
        }
        _tabScrollerView.index = _currentIndex;
//        _changeIndex = _currentIndex;
    }
    isScrolling=false;
    [self indexForEnable:_currentIndex];
    
    [self changeTableViewAndLoadData];
    
}

//确保索引可用
-(NSInteger)indexForEnable:(NSInteger)index{
    if (index < 0 || index == 0) {
        return _currentIndex=0;
    }else if (index > self.dataAllArray.count - 1 || index == self.dataAllArray.count - 1){
        return _currentIndex = self.dataAllArray.count-1;
    }else{
        return _currentIndex==index;
    }
}

/**
 *  修改索引并加载
 */
- (void)changeTableViewAndLoadData{
    
    [self indexForEnable:_currentIndex];
    
    
    //index = 0 情况，只需要刷新左边tableView和中间tableView
    BaseUITableView *_leftTable=_tableViewArray[0];
    BaseUITableView *_midTable=_tableViewArray[1];
    BaseUITableView *_rightTable;
    if(_dataAllArray.count>=3)
    {
      _rightTable =_tableViewArray[2];
    }

    
    
    if(tabCount>2)
    {
        if (_currentIndex == 0) {
            
            _leftTable.dataArray=_dataAllArray[_currentIndex];
            _midTable.dataArray=_dataAllArray[_currentIndex+1];
            [_leftTable reloadData];
            [_midTable reloadData];
            if(_leftTable.dataArray.count==0)
            {
                [_leftTable.mj_header beginRefreshing];
            }
            if(_midTable.dataArray.count==0)
            {
                [_midTable.mj_header beginRefreshing];
            }
            if(!isScrolling)
            {
                 self.tableViewScrollView.contentOffset = CGPointMake(0, 0);
            }
            
           
            //index 是为最后的下标时，刷新右边tableView 和 中间 tableView
        }else if(_currentIndex == _dataAllArray.count - 1){
            
            _rightTable.dataArray=_dataAllArray[_currentIndex];
            _midTable.dataArray=_dataAllArray[_currentIndex-1];
            [_rightTable reloadData];
            [_midTable reloadData];
        
            if(_midTable.dataArray.count==0)
            {
                [_midTable.mj_header beginRefreshing];
            }
            if(_rightTable.dataArray.count==0)
            {
                [_rightTable.mj_header beginRefreshing];
            }
            if(!isScrolling)
            {
                self.tableViewScrollView.contentOffset = CGPointMake(SCREEN_WIDTH*2, 0);
            }
            
            //除了上边两种情况，三个tableView 都要刷新，为了左右移动时都能够显示数据
        }else{
            _leftTable.dataArray=_dataAllArray[_currentIndex-1];
            _rightTable.dataArray=_dataAllArray[_currentIndex+1];
            _midTable.dataArray=_dataAllArray[_currentIndex];
            [_rightTable reloadData];
            [_midTable reloadData];
            [_leftTable reloadData];
            if(_rightTable.dataArray.count==0)
            {
                [_rightTable.mj_header beginRefreshing];
            }
            if(_midTable.dataArray.count==0)
            {
                [_midTable.mj_header beginRefreshing];
            }
            if(_leftTable.dataArray.count==0)
            {
                [_leftTable.mj_header beginRefreshing];
            }
            if(!isScrolling)
            {
                self.tableViewScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
            }
        }
    }
    else
    {
        if(_currentIndex==0)
        {
            _leftTable.dataArray=_dataAllArray[_currentIndex];
            _midTable.dataArray=_dataAllArray[_currentIndex+1];
            if(_leftTable.dataArray.count==0)
            {
                [_leftTable.mj_header beginRefreshing];
            }
            if(_midTable.dataArray.count==0)
            {
                [_midTable.mj_header beginRefreshing];
            }
            [_leftTable reloadData];
            [_midTable reloadData];
            if(!isScrolling)
            {
                self.tableViewScrollView.contentOffset = CGPointMake(0, 0);
                
            }
            
        }
        else
        {
            _leftTable.dataArray=_dataAllArray[_currentIndex-1];
            _midTable.dataArray=_dataAllArray[_currentIndex];
            [_leftTable reloadData];
            [_midTable reloadData];
            if(_leftTable.dataArray.count==0)
            {
                [_leftTable.mj_header beginRefreshing];
            }
            if(_midTable.dataArray.count==0)
            {
                [_midTable.mj_header beginRefreshing];
            }
            if(!isScrolling)
            {
                self.tableViewScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
            }
            
        }
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
