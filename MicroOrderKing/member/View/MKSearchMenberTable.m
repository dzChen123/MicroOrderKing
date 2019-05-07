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
#import "MKConfirmView.h"

#import "MKMemberBaseModel.h"

@implementation MKSearchMenberTable
{
    MKConfirmView *confirmView;
    UIView *maskView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60 * autoSizeScaleH;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { return  YES; }

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //BaseViewController *parent = (BaseViewController *)[self parentController];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        [self goToConfirm:indexPath];
    }];
    deleteAction.backgroundColor = [UIColor hexStringToColor:@"#D51A2C"];
    
    return @[deleteAction];
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
    [confirmView setSignStr:@[@"请确定您要删除该会员",@"删除"]];
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
    
    BaseViewController *parent = (BaseViewController *)[self parentController];
    
    MKMemberBaseModel *model = self.dataArray[indexPath.row];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    NSString *deleteUrl = [NSString stringWithFormat:@"member/%@",model.memberId];
    [parent.hud showWait];
    [AFNetWorkingUsing httpDelete:deleteUrl params:plist success:^(id json) {
        [parent.hud hideAnimated:YES];
        //tableView.editing = NO;
        [self setEditing:NO];
        MKMemberBaseModel *baseModel = self.dataArray[indexPath.row];
        [[MKAddressManager sharedAddressManager] needsUpdate:baseModel.memberId];
        [[MKAddressManager sharedAddressManager] saveLocalInfo];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } fail:^(NSError *error) {
        [parent.hud hideAnimated:YES];
        //tableView.editing = NO;
        [self setEditing:NO];
    } other:^(id json) {
        [parent.hud hideAnimated:YES];
        //tableView.editing = NO;
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
