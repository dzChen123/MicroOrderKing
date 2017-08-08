//
//  BaseScrollViewController.h
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/13.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "BaseViewController.h"
#import "ZYFUtilityPch.h"
#import "Container.h"
@interface BaseScrollViewController : BaseViewController<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) Container *containerView;

-(void)setBottomView:(UIView *)view;
-(void)updateBottomView:(UIView *)view;
- (void)setBottomView:(UIView *)view withHeight:(CGFloat)height;
- (void)updateBottomView:(UIView *)view withHeight:(CGFloat)height;

@end
