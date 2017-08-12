//
//  MKOrderManageCell.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/27.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MKOrderManageCell : BaseTableViewCell

@property (strong,nonatomic) void (^clickButnClickBlock)(BOOL isSelect,NSString *orderId);

@end
