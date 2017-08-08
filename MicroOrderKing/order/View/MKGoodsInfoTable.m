//
//  MKGoodsInfoTable.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAddGoodsController.h"

#import "MKGoodsInfoTable.h"

@implementation MKGoodsInfoTable

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 190 * autoSizeScaleH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 45 * autoSizeScaleH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 45 * autoSizeScaleH;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { return  YES; }

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了删除");
    }];
    deleteAction.backgroundColor = [UIColor hexStringToColor:@"#D51A2C"];
    
    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    editingStyle = UITableViewCellEditingStyleNone;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    UIView *headerView = [[UIView alloc] init];
    UILabel *tittleLab = [[UILabel alloc] init];
    
    [headerView addSubview:tittleLab];
    
    tittleLab.text = @"商品信息";
    tittleLab.textColor = [UIColor hexStringToColor:@"#A7A8AA"];
    tittleLab.font = FONT(14);
    [tittleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView).offset(leftPadding);
        make.centerY.mas_equalTo(headerView);
    }];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footerView = [[UIView alloc] init];
    UIButton *bottomButn = [[UIButton alloc] init];
    
    [footerView addSubview:bottomButn];
    
    [bottomButn setTitle:@" 添加商品" forState:UIControlStateNormal];
    [bottomButn addTarget:self action:@selector(gotoAddGoods) forControlEvents:UIControlEventTouchUpInside];
    [bottomButn setTitleColor:[UIColor hexStringToColor:@"#7A7A7A"] forState:UIControlStateNormal];
    [bottomButn setImage:[[UIImage imageNamed:@"enorderAddComman"] imageByScalingToSize:CGSizeMake(12 * autoSizeScaleW, 12 * autoSizeScaleW)] forState:UIControlStateNormal];
    bottomButn.titleLabel.font = FONT(16);
    bottomButn.backgroundColor = customWhite;
    [bottomButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(footerView);
        make.center.mas_equalTo(footerView);
    }];
    
    return footerView;
}

- (void)gotoAddGoods{
   
    UIViewController *parent = [self parentController];
    MKAddGoodsController *controller = [[MKAddGoodsController alloc] init];
    controller.tableViewData = self.dataArray;
    [parent.navigationController pushViewController:controller animated:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
