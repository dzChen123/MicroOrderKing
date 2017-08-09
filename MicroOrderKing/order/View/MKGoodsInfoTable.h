//
//  MKGoodsInfoTable.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseUITableView.h"

@interface MKGoodsInfoTable : BaseUITableView

@property (strong,nonatomic) void (^cellDeleteBlock)();

@end
