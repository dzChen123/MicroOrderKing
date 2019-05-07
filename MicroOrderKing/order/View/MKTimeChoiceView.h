//
//  MKTimeChoiceView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 2017/9/22.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKTimeChoiceView : BaseView<UIPickerViewDelegate,UIPickerViewDataSource>

- (instancetype)initWithDate:(NSDate *)date isFilter:(BOOL)isFilter;
- (void)setLimitString:(NSString *)dateString;

@property (strong,nonatomic) void (^timeConfirmBlock)(NSDate *date);
@property (assign,nonatomic) NSInteger searchType;  // 0 开始   1结束
@property (assign,nonatomic) BOOL hasFiltered;  //之前是否设置过日期

@end
