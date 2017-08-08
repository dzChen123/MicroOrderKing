//
//  MKAddreChoiceView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/5.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

#import "MKAddreMatchModel.h"

@interface MKAddreChoiceView : BaseView

@property (strong,nonatomic) void (^cancelClickBock)();
@property (strong,nonatomic) void (^confirmClickBock)(MKAddreMatchModel *model,NSInteger index);

- (void)setData:(id)model;

@end

@interface MKAddreItemView : BaseView

@property (assign,nonatomic) BOOL isSelected;
@property (strong,nonatomic) void (^checkClickBlock)();

- (void)setData:(id)model WithUserName:(NSString *)name Phone:(NSString *)phone;
- (void)setSelected:(BOOL)selected;

@end
