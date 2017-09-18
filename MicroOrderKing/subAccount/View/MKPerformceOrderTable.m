//
//  MKPerformceOrderTable.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/8.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "UITableView+FDTemplateLayoutCell.h"

#import "MKPerformceOrderTable.h"
#import "MKOrderManageCell.h"

#import "MKOrderCellModel.h"

#define deliverCellid @"orderDeliver"
#define confirmCellid @"orderConfirm"
#define historyCellid @"orderHistory"

@implementation MKPerformceOrderTable

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKOrderCellModel *model = self.dataArray[indexPath.row];
    NSString *cellid;
    switch ([model.conditionType integerValue]) {
        case 0:
            cellid = deliverCellid;
            break;
        case 1:
            cellid = confirmCellid;
            break;
        case 2:
            cellid = historyCellid;
            break;
        default:
            cellid = historyCellid;
            break;
    }
    MKOrderManageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setData:model];
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKOrderCellModel *model = self.dataArray[indexPath.row];
    NSString *cellid;
    switch ([model.conditionType integerValue]) {
        case 0:
            cellid = deliverCellid;
            break;
        case 1:
            cellid = confirmCellid;
            break;
        case 2:
            cellid = historyCellid;
            break;
        default:
            cellid = historyCellid;
            break;
    }
    CGFloat height =[tableView fd_heightForCellWithIdentifier:cellid cacheByIndexPath:indexPath configuration:^(BaseTableViewCell *cell) {
        
        [cell setData:self.dataArray[indexPath.row]];
        
    }];
    return height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
