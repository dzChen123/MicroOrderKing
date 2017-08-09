//
//  MKSearResultController.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/9.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseUITableView.h"


@interface MKSearResultController : BaseViewController

@property (strong,nonatomic) NSString *searchContent;
@property (strong,nonatomic) BaseUITableView *resultTable;

- (instancetype)initWithType:(NSInteger)type;
- (void)reloadTableView;


@end
