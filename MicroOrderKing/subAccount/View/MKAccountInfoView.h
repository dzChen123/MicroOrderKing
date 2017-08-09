//
//  MKAccountInfoView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKAccountInfoView : BaseView

- (void)setDataWithModel:(id)model;

@end

@interface MKAccountRecordView : BaseView

- (void)setMemberNum:(NSString *)member andOrderNum:(NSString *)order;
- (void)setUserId:(NSString *)userId;

@end
