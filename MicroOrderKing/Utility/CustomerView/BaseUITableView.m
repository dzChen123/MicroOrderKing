//
//  BaseUITableView.m
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/9.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "BaseUITableView.h"
#import "UITableView+FDTemplateLayoutCell.h"
@implementation BaseUITableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style cellIdentifier:(NSString *)cellIdentifier   class:(Class)cellClass
{
    self=[super initWithFrame:frame style:style];
    if(self)
    {
        _cellIdentifier=cellIdentifier;
        if(_cellIdentifier)
        {
            [self registerClass:cellClass forCellReuseIdentifier:_cellIdentifier];
        }
        else
        {
            [self registerClass:cellClass forCellReuseIdentifier:@"defaultCell"];
        }

        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewReload)];
        header.lastUpdatedTimeLabel.hidden = YES;
        MJRefreshBackNormalFooter *footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewLoadMore)];

        self.mj_header=header;
        self.mj_footer=footer;
        self.delegate=self;
        self.dataSource=self;
        self.showsVerticalScrollIndicator=NO;
        self.showsHorizontalScrollIndicator=NO;
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, 0.01f)];
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.backgroundColor=[UIColor clearColor];
        _dataArray=[[NSMutableArray alloc] init];
//        self.fd_debugLogEnabled = YES;
    }
    return self;
}






-(void)setCellIdentifier:(NSString *)cellIdentifier
{
    _cellIdentifier=cellIdentifier;
    if(_cellIdentifier)
    {
        
        [self registerClass:[BaseTableViewCell class] forCellReuseIdentifier:_cellIdentifier];
    }
    else
    {
        [self registerClass:[BaseTableViewCell class] forCellReuseIdentifier:@"defaultCell"];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _dataArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BaseTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:_cellIdentifier forIndexPath:indexPath];
    cell.imageLoadedEvent=^()
    {
        if([tableView cellForRowAtIndexPath:indexPath])
        {
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    };
    cell.cellDelete=_cellDelete;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setData:_dataArray[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_cellHeight)
    {
        return _cellHeight(tableView,indexPath);
    }
    CGFloat height =[tableView fd_heightForCellWithIdentifier:_cellIdentifier cacheByIndexPath:indexPath configuration:^(BaseTableViewCell *cell) {
        
        [cell setData:_dataArray[indexPath.row]];

    }];
    return height;
}

-(void)tableViewReload
{
    WS(ws)
    if(_reloadMessage)
    {
        _reloadMessage(ws);
    }
}

-(void)tableViewLoadMore
{
    WS(ws)
    if(_loadMoreMessage)
    {
        _loadMoreMessage(ws);
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_cellSelcet) {
        _cellSelcet(tableView,indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
