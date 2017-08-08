//
//  MKMemberInfoView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/30.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKMemberInfoView : BaseView

- (void)setData:(id)model;

@end

@interface MKMemberAddreView : BaseView

- (void)setData:(NSMutableArray *)dataArr;

@end

@interface MKMemAddreItemView : BaseView

- (void)setAddre:(NSString *)addre;

@end
