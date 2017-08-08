//
//  MKAddAccountController.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseViewController.h"

@interface MKAddAccountController : BaseViewController

- (instancetype)initWithType:(NSInteger)type;

@property (strong,nonatomic) NSString *editId;

@end
