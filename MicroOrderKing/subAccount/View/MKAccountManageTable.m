//
//  MKAccountManageTable.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAddAccountController.h"

#import "MKAccountManageTable.h"
#import "MKAccountManageCell.h"
#import "MKConfirmView.h"

#import "MKAccountBaseModel.h"

@implementation MKAccountManageTable
{
    MKConfirmView *confirmView;
    UIView *maskView;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { return  YES; }

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKAccountBaseModel *model = self.dataArray[indexPath.row];
    BaseViewController *parent = (BaseViewController *)[self parentController];
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        tableView.editing = NO;
        MKAddAccountController *controller = [[MKAddAccountController alloc] initWithTitle:@"分账号编辑"];
        controller.editId = model.accountId;
        [parent.navigationController pushViewController:controller animated:YES];
        }];
    editAction.backgroundColor = [UIColor hexStringToColor:@"#BBBBBB"];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self goToConfirm:indexPath];
        
    }];
    deleteAction.backgroundColor = [UIColor hexStringToColor:@"#D51A2C"];
    
    return @[deleteAction,editAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    editingStyle = UITableViewCellEditingStyleNone;
}

- (void)goToConfirm:(NSIndexPath *)indexPath {
    UIViewController *parent = [self parentController];
    
    maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    maskView.alpha = 0;
    [parent.view addSubview:maskView];
    [parent.view bringSubviewToFront:maskView];
    
    WS(ws)
    WeakObj(parent)
    
    [maskView addTapEventWith:self action:@selector(cancelConfirm)];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(parentWeak.view);
        make.center.mas_equalTo(parentWeak.view);
    }];
    confirmView = [[MKConfirmView alloc] init];
    [confirmView setSignStr:@[@"请确定您要删除该分账号",@"删除"]];
    confirmView.confirmBlock = ^{
        [ws confirm:indexPath];
    };
    
    [parent.view addSubview:confirmView];
    confirmView.cancelBlock =^(){
        [ws cancelConfirm];
    };
    confirmView.alpha = 0;
    confirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
    [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentWeak.view).offset(leftPadding);
        make.right.mas_equalTo(parentWeak.view).offset(rightPadding);
        make.centerY.mas_equalTo(parentWeak.view);
    }];
    [UIView animateWithDuration:.3 animations:^{
        maskView.alpha = 1;
        confirmView.alpha = 1;
        confirmView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)cancelConfirm {
    [self setEditing:NO];
    [UIView animateWithDuration:.2 animations:^{
        maskView.alpha = 0;
        confirmView.alpha = 0;
        confirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
    }completion:^(BOOL finished) {
        maskView.hidden = YES;
        confirmView.hidden = YES;
        [maskView removeFromSuperview];
        [confirmView removeFromSuperview];
    }];
}

- (void)confirm:(NSIndexPath *)indexPath {
    [self cancelConfirm];
    MKAccountBaseModel *model = self.dataArray[indexPath.row];
    BaseViewController *parent = (BaseViewController *)[self parentController];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    NSString *deleteUrl = [NSString stringWithFormat:@"subaccount/%@",model.accountId];
    [parent.hud showWait];
    [AFNetWorkingUsing httpDelete:deleteUrl params:plist success:^(id json) {
        [parent.hud hideAnimated:YES];
        [self setEditing:NO];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        if (!self.dataArray.count) {
            [self deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        }else{
            [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    } fail:^(NSError *error) {
        [parent.hud hideAnimated:YES];
        [self setEditing:NO];
    } other:^(id json) {
        [parent.hud hideAnimated:YES];
        [self setEditing:NO];
        [parent.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
