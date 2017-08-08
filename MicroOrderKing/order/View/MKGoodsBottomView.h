//
//  MKGoodsBottomView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKGoodsBottomView : BaseView

@property (strong,nonatomic) void (^clearClickBlock)();
@property (strong,nonatomic) void (^confirmClickBlock)();

- (void)setSelecNum:(NSInteger)num;

@end
