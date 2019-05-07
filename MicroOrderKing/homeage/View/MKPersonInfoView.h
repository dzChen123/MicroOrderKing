//
//  MKPersonInfoView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/1.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKPersonInfoView : BaseView

- (void)setData:(id)model;

@end

@interface MKChangePasdView : BaseView

- (instancetype)initWithTitle:(NSString *)titleStr AndImage:(NSString *)imageName;

@end
