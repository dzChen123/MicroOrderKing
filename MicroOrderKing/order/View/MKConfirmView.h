//
//  MKConfirmView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/3.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKConfirmView : BaseView

@property (strong,nonatomic) void (^cancelBlock)();
@property (strong,nonatomic) void (^confirmBlock)();

- (void)setSignStr:(NSArray *)signArra;

@end
