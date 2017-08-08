//
//  MKEditAddreController.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/5.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseViewController.h"

@interface MKEditAddreController : BaseViewController

@property (strong,nonatomic) NSString *addreId;
@property (strong,nonatomic) NSString *memberId;

- (instancetype)initWithType:(NSInteger)type;

@end
