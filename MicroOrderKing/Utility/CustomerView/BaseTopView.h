//
//  BaseTopView.h
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/9.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTopView : UIView
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;
@property (nonatomic,strong) UIView *lineView;
+(instancetype)initWithBcakAndTitle:(NSString *)title andSuperView:(UIView *)superView;
+(instancetype)initWithTitle:(NSString *)title andSuperView:(UIView *)superView;
-(void)setRightEvent:(id)target   action:(SEL)action;
-(void)setLeftEvent:(id)target   action:(SEL)action;
@property (nonatomic,strong) void(^backOtherEvent)();
@end
