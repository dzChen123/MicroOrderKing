//
//  MKScanConfirmView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/9/4.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKScanConfirmView : BaseView

@property (strong,nonatomic) void (^cancelBlock)();
@property (strong,nonatomic) void (^confirmBlock)();

@property (assign,nonatomic) NSInteger type;

@end

@interface MKPrintTypeView : BaseView

@property (strong,nonatomic) void (^typeButnClickBlock)(MKPrintTypeView *sender);
@property (assign,nonatomic) BOOL hideLineView;
@property (assign,nonatomic) BOOL isSelected;

- (instancetype)initWithTitle:(NSString *)title;

@end
