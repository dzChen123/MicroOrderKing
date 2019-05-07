//
//  MKFilterView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 2017/9/23.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKFilterTimeView : BaseView      //时间选择的部分

@property (strong,nonatomic) void (^timeButnBlock)(NSInteger index);

- (void)setTimeContentWithStart:(NSString *)start End:(NSString *)end;

@end

@interface MKFilterView : BaseView      //真正使用到controller上的东西

@property (strong,nonatomic) MKFilterTimeView *timeView;
@property (strong,nonatomic) void (^filterCancelBlock)();
@property (strong,nonatomic) void (^filterCanfirmBlock)(NSInteger payStatus,NSInteger method);

@end

@interface MKFilterItemView : BaseView      //上面的两个部分

@property (assign,nonatomic) NSInteger selectIndex;

- (instancetype)initWithTitle:(NSString *)title AndButnTitles:(NSArray *)butnTitles;

@end
