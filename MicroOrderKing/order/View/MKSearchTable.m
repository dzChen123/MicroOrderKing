//
//  MKSearchTable.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKSearchTable.h"

@implementation MKSearchTable

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  45 * autoSizeScaleH;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    UILabel *tittleLab = [[UILabel alloc] init];
    UIView *lineView = [[UIView alloc] init];
    
    [headerView addSubview:tittleLab];
    [headerView addSubview:lineView];
    
    tittleLab.text = @"历史搜索";
    tittleLab.textColor = [UIColor blackColor];
    tittleLab.font = FONT(15);
    [tittleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView).offset(leftPadding);
        make.centerY.mas_equalTo(headerView);
    }];
    
    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tittleLab);
        make.bottom.right.mas_equalTo(headerView);
        make.height.mas_equalTo(1);
    }];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45 * autoSizeScaleH;
}

@end

@implementation MKsearchCell
{
    UILabel *tittleLab;
    UIView *lineView;
}

- (void)createView {
    tittleLab = [[UILabel alloc] init];
    lineView = [[UIView alloc] init];
    
    [self.contentView addSubview:tittleLab];
    [self.contentView addSubview:lineView];
}

- (void)setttingViewAtuoLayout {
    
    WS(ws)
    
    tittleLab.font = FONT(14);
    tittleLab.textColor = [UIColor hexStringToColor:@"#676767"];
    [tittleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.contentView).offset(leftPadding);
        make.right.lessThanOrEqualTo(ws.contentView).offset(rightPadding);
        make.centerY.mas_equalTo(ws.contentView);
    }];
    
    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tittleLab);
        make.right.bottom.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)setData:(id)model {
    NSString *tittle = (NSString *)model;
    tittleLab.text = tittle;
}


@end
