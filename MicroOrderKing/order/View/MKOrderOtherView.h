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
@property (strong,nonatomic) void (^deleteButnBlock)();
@property (strong,nonatomic) void (^deliverChoiceBlock)();
@property (strong,nonatomic) void (^timeChoiceBlock)();

- (instancetype)initWithType:(NSInteger)type;
- (NSArray *)getOrderOtherInfo;
- (void)setOrderOtherInfo:(NSString *)remarkStr IsPaid:(BOOL)isPaid;
- (void)setDeliverStr:(NSString *)deliver;
- (void)setDateStr:(NSString *)date;


@end

@interface MKOrderOptionView : BaseView     //最下方的选择控件

@property (strong,nonatomic) NSString *title;

- (instancetype)initWithTitle:(NSString *)title AndContent:(NSString *)content;

@end
