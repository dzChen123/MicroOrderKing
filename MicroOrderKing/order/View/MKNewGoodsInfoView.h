//
//  MKNewGoodsInfoView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKNewGoodsInfoView : BaseView<UITextViewDelegate>

- (void)setData:(id)model;
- (NSArray *)getGoodsInfo;

@end

@interface MKGoodsPicView : BaseView

- (void)setImage:(UIImage *)image;

@end
