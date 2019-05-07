//
//  MKDeliverChoiceView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 2017/9/22.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKDeliverChoiceView : BaseView

- (instancetype)initWithChoice:(NSInteger)choice;

@property (strong,nonatomic) void (^deliverItemBlock)(NSString *deliver);

@end
