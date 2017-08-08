//
//  MKAddGoodsController.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseViewController.h"

#import "BaseUITableView.h"

@interface MKAddGoodsController : BaseViewController

@property (strong,nonatomic) BaseUITableView *goodsTable;
@property (assign,nonatomic) NSInteger totalCount;
@property (strong,nonatomic) NSMutableArray *tableViewData;

@end
