//
//  MKSearchMenberTable.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/9.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseViewController.h"

#import "MKAddressManager.h"

#import "MKSearchMenberTable.h"

#import "MKMemberBaseModel.h"

@implementation MKSearchMenberTable


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60 * autoSizeScaleH;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { return  YES; }

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseViewController *parent = (BaseViewController *)[self parentController];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        MKMemberBaseModel *model = self.dataArray[indexPath.row];
        NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
        NSString *deleteUrl = [NSString stringWithFormat:@"member/%@",model.memberId];
        [parent.hud showWait];
        [AFNetWorkingUsing httpDelete:deleteUrl params:plist success:^(id json) {
            [parent.hud hideAnimated:YES];
            tableView.editing = NO;
            MKMemberBaseModel *baseModel = self.dataArray[indexPath.row];
            [[MKAddressManager sharedAddressManager] needsUpdate:baseModel.memberId];
            [[MKAddressManager sharedAddressManager] saveLocalInfo];
            [self.dataArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    
    return @[deleteAction];
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
