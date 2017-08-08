//
//  MKAddreManageController.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/5.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseViewController.h"

#import "MKAddreManageTable.h"

@interface MKAddreManageController : BaseViewController

@property (strong,nonatomic) NSString *memberId;
@property (strong,nonatomic) MKAddreManageTable *addreManageTable;

@end
