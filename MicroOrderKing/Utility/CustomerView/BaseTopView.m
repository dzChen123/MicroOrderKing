//
//  BaseTopView.m
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/9.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "BaseTopView.h"
#import "UIImage+ZYFCategory.h"
#import "ZYFUtilityPch.h"
@implementation BaseTopView
@synthesize titleLabel;
@synthesize leftButton;
@synthesize rightButton;
-(instancetype)init
{
    self=[super init];
    if(self)
    {
        titleLabel=[[UILabel alloc] init];
        leftButton =[[UIButton alloc] init];
        rightButton = [[UIButton alloc] init];
        _leftView =[[UIView alloc] init];
        _rightView =[[UIView alloc] init];
        [self addSubview:_leftView];
        [self addSubview:_rightView];
        [self addSubview:titleLabel];
        [self addSubview:leftButton];
        [self addSubview:rightButton];

        
        self.backgroundColor=[UIColor whiteColor];
        WS(ws);

        _lineView =[[UIView alloc] init];
        _lineView.backgroundColor=VIEWBACKGRAY;
       
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ws);
            make.right.mas_equalTo(ws);
            make.bottom.mas_equalTo(ws);
            make.height.mas_equalTo(0.5f);
        }];
        
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        leftButton.titleEdgeInsets=UIEdgeInsetsMake(0, -64*autoSizeScaleH/2-leftPadding, 0, 0);
        //        rightButton.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, -64*autoSizeScaleH/2-leftPadding);
        leftButton.titleLabel.font=FONT(14);
        rightButton.titleLabel.font=FONT(14);
        leftButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        rightButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
//        _leftView.backgroundColor=[UIColor redColor];
//        _rightView.backgroundColor=[UIColor redColor];
//        leftButton.backgroundColor=[UIColor redColor];
//        rightButton.backgroundColor=[UIColor redColor];
        titleLabel.font=FONT(16);
    }
    return self;
}



+(instancetype)initWithTitle:(NSString *)title andSuperView:(UIView *)superView
{
    BaseTopView *topview=[[BaseTopView alloc ]init];
    topview.titleLabel.text=title;
    topview.titleLabel.textColor=[UIColor blackColor];
    [superView addSubview:topview];
    WeakObj(superView);
    [topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superViewWeak);
        make.right.mas_equalTo(superViewWeak);
        make.top.mas_equalTo(superViewWeak);
        make.height.mas_equalTo(@(64*autoSizeScaleH));
    }];
    [topview.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(topview);
        make.centerY.mas_equalTo(topview).offset(10*autoSizeScaleH);
    }];
    [topview.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topview);
        make.centerY.mas_equalTo(topview.titleLabel);
        make.height.mas_equalTo(topview).offset(-20*autoSizeScaleH);
        make.width.mas_equalTo(topview.mas_height);
    }];
    
    [topview.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topview.leftView).offset(leftPadding);
        make.centerY.mas_equalTo(topview.leftView);
//        make.size.mas_equalTo(CGSizeMake(30*autoSizeScaleW, 30*autoSizeScaleW));
    }];
    
    
    [topview.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topview);
        make.centerY.mas_equalTo(topview.titleLabel);
        make.height.mas_equalTo(topview).offset(-20*autoSizeScaleH);
        make.width.mas_equalTo(topview.mas_height).offset(20);
    }];
    
    [topview.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topview.rightView).offset(rightPadding);
        make.centerY.mas_equalTo(topview.rightView);
//        make.size.mas_equalTo(CGSizeMake(30*autoSizeScaleW, 30*autoSizeScaleW));
    }];
    return topview;
}

/**
 *  附带返回按钮的TopView
 *
 *  @param title     <#title description#>
 *  @param superView <#superView description#>
 *
 *  @return <#return value description#>
 */
+(instancetype)initWithBcakAndTitle:(NSString *)title andSuperView:(UIView *)superView
{
    BaseTopView *topview=[[BaseTopView alloc ]init];
    topview.titleLabel.text=title;
    topview.titleLabel.textColor=[UIColor blackColor];
    [topview.leftButton setImage:[[UIImage imageNamed:topBackImageName] imageByScalingToSize:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    [topview.leftButton addTarget:topview action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [topview.leftView bk_whenTapped:^{
        [topview backClick:topview.leftButton];
    }];
    [superView addSubview:topview];
    WeakObj(superView);
    [topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superViewWeak);
        make.right.mas_equalTo(superViewWeak);
        make.top.mas_equalTo(superViewWeak);
        make.height.mas_equalTo(@(64*autoSizeScaleH));
    }];
    [topview.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(topview);
        make.centerY.mas_equalTo(topview).offset(10*autoSizeScaleH);
    }];
    [topview.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topview);
        make.centerY.mas_equalTo(topview.titleLabel);
        make.height.mas_equalTo(topview).offset(-20*autoSizeScaleH);
        make.width.mas_equalTo(topview.mas_height);
    }];
    
    [topview.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topview.leftView).offset(leftPadding);
        make.centerY.mas_equalTo(topview.leftView);
//        make.size.mas_equalTo(CGSizeMake(30*autoSizeScaleW, 30*autoSizeScaleW));
    }];
    
    
    [topview.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topview);
        make.centerY.mas_equalTo(topview.titleLabel);
        make.height.mas_equalTo(topview).offset(-20*autoSizeScaleH);
        make.width.mas_equalTo(topview.mas_height);
    }];
    
    [topview.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topview.rightView).offset(rightPadding);
        make.centerY.mas_equalTo(topview.rightView);
//        make.size.mas_equalTo(CGSizeMake(30*autoSizeScaleW, 30*autoSizeScaleW));
    }];
    return topview;
}

-(void)backClick:(UIButton *)button
{
  
    UIViewController *controller=[button parentController];
    if(_backOtherEvent)
    {
        _backOtherEvent();
    }
    [controller.navigationController popViewControllerAnimated:YES];
}

-(void)setLeftEvent:(id)target   action:(SEL)action
{
    [self.leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self.leftView addGestureRecognizer:tap];
}

-(void)setRightEvent:(id)target   action:(SEL)action
{
    [self.rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self.rightView addGestureRecognizer:tap];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
