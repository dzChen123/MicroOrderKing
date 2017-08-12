//
//  MKOrderDetailController.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseViewController.h"

@interface MKOrderDetailController : BaseViewController

@property (strong,nonatomic) NSString *orderId;
@property (strong,nonatomic) NSString *postStatus;
@property (assign,nonatomic) BOOL isUpdate;

- (void)loadData;

@end
