//
//  MKMemManageTable.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/30.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseViewController.h"

#import "MKAddressManager.h"

#import "MKMemManageTable.h"
#import "MKMemManageCell.h"

#import "MKMemberBaseModel.h"

@implementation MKMemManageTable


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return self.indexes;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    [self.sectionArray removeAllObjects];
    for (NSInteger index = 0; index < 27; index ++) {
        if (((NSMutableArray *)self.dataArray[index]).count) {
            [self.sectionArray addObject:@(index)];
            [self.titleArra addObject:self.indexes[index]];
        }
    }
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger index = [self.sectionArray[section] integerValue];
    return ((NSMutableArray *)self.dataArray[index]).count;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    NSInteger count;
    
    if (![self.titleArra containsObject:title]) {
        count = 0;
    }else{
        count = [self.titleArra indexOfObject:title];
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:count] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = [self.sectionArray[indexPath.section] integerValue];
    MKMemberBaseModel *model = ((NSMutableArray *)self.dataArray[index])[indexPath.row];
    MKMemManageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memberCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setData:model];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if([self.indexes count]==0){
        
        return @"";
    }
    NSInteger index = [self.sectionArray[section] integerValue];
    return [self.indexes objectAtIndex:index];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 30 * autoSizeScaleH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 60 * autoSizeScaleH;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { return  YES; }

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseViewController *parent = (BaseViewController *)[self parentController];

    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSInteger index = [self.sectionArray[indexPath.section] integerValue];
        NSMutableArray *dataArra = (NSMutableArray *)self.dataArray[index];
        MKMemberBaseModel *model = dataArra[indexPath.row];
        NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
        NSString *deleteUrl = [NSString stringWithFormat:@"member/%@",model.memberId];
        [parent.hud showWait];
        [AFNetWorkingUsing httpDelete:deleteUrl params:plist success:^(id json) {
            [parent.hud hideAnimated:YES];
            tableView.editing = NO;
            MKMemberBaseModel *baseModel = dataArra[indexPath.row];
            [[MKAddressManager sharedAddressManager] needsUpdate:baseModel.memberId];
            [[MKAddressManager sharedAddressManager] saveLocalInfo];
            [dataArra removeObjectAtIndex:indexPath.row];
            if (!dataArra.count) {
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
    
    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    editingStyle = UITableViewCellEditingStyleNone;
}

- (NSMutableArray *)indexes {
    if (!_indexes) {
        _indexes = [[NSMutableArray alloc] init];
        
        NSLog(@"生成组索引");
        _indexes = [[NSMutableArray alloc]init];
        for(char c = 'A' ; c <= 'Z';c ++){
            [_indexes addObject:[NSString stringWithFormat:@"%c",c]];
        }
        [_indexes addObject:@"#"];
    }
    return _indexes;
}

- (NSMutableArray *)sectionArray {
    if (!_sectionArray) {
        _sectionArray = [[NSMutableArray alloc] init];
    }
    return _sectionArray;
}

- (NSMutableArray *)titleArra {
    if (!_titleArra) {
        _titleArra = [[NSMutableArray alloc] init];
    }
    return _titleArra;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
