//
//  MKOrderOtherView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKOrderOtherView : BaseView<UITextViewDelegate>

@property (strong,nonatomic) void (^confirmButnBlock)();

- (instancetype)initWithType:(NSInteger)type;
- (NSArray *)getOrderOtherInfo;
- (void)setOrderOtherInfo:(NSString *)remarkStr IsPaid:(BOOL)isPaid;


@end
