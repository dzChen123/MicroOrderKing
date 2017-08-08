//
//  MKTradesInfoView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/26.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKTradesInfoView : BaseView

- (void)setUpdateModel:(id)model;

@end

@interface MKTradesItemView : BaseView

- (instancetype)initWithTitles:(NSArray *)tittleArra andIconName:(NSString *)iconName isNeedLine:(BOOL)isNeed;
- (void)setUpdateData:(NSArray *)arra;
- (void)setUpdateDataToday:(NSInteger)today Week:(NSInteger)week Month:(NSInteger)month;

@end

@interface MKToDoItemView : BaseView

- (void)setUpdateData:(NSArray *)data;
- (void)setUpdataDeliver:(NSInteger)deliver Confirm:(NSInteger)confirm;
- (void)setDelieryNum:(NSString *)deliveryNum;
- (void)setConfirmNum:(NSString *)confirmNum;

@end
