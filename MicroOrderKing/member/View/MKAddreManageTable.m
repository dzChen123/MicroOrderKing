//
//  MKAddreManageTable.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/6.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAddreManageTable.h"
#import "MKAddreMangeCell.h"


@implementation MKAddreManageTable

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150 * autoSizeScaleH;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
