//
//  MKTradesDetailController.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseViewController.h"

@interface MKTradesDetailController : BaseViewController

@property (strong,nonatomic) NSString *totalCost;
@property (strong,nonatomic) NSString *totalCount;
@property (strong,nonatomic) NSString *userId;

- (void)reloadTableView;

@end
