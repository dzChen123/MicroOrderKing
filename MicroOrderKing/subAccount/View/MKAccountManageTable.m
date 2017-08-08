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

#import "MKAccountBaseModel.h"

@implementation MKAccountManageTable

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { return  YES; }

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKAccountBaseModel *model = self.dataArray[indexPath.row];
    BaseViewController *parent = (BaseViewController *)[self parentController];
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        tableView.editing = NO;
        MKAddAccountController *controller = [[MKAddAccountController alloc] initWithTitle:@"子账户编辑"];
        controller.editId = model.accountId;
        [parent.navigationController pushViewController:controller animated:YES];
        }];
    editAction.backgroundColor = [UIColor hexStringToColor:@"#BBBBBB"];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
        NSString *deleteUrl = [NSString stringWithFormat:@"subaccount/%@",model.accountId];
        [parent.hud showWait];
        [AFNetWorkingUsing httpDelete:deleteUrl params:plist success:^(id json) {
            [parent.hud hideAnimated:YES];
            tableView.editing = NO;
            [self.dataArray removeObjectAtIndex:indexPath.row];
            if (self.dataArray.count) {
                [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            }else{
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        } fail:^(NSError *error) {
            [parent.hud hideAnimated:YES];
            tableView.editing = NO;
        } other:^(id json) {
            [parent.hud hideAnimated:YES];
            tableView.editing = NO;
            [parent.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
        }];
    }];
    deleteAction.backgroundColor = [UIColor hexStringToColor:@"#D51A2C"];
    
    return @[deleteAction,editAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    editingStyle = UITableViewCellEditingStyleNone;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
