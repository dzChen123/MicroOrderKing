//
//  BaseScrollViewController.m
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/13.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "BaseScrollViewController.h"

@implementation BaseScrollViewController

- (void)viewDidLoad {
//    [super viewDidLoad];
    WS(ws)
    _scrollView=[[UIScrollView alloc] init];
    _scrollView.delegate=self;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.bounces=NO;

    //将view改为IQKeyBord容器
//    _containerView=[[UIView alloc] init];
    

//    self.view=[[Container alloc] init];
    self.view.backgroundColor=VIEWBACKGRAY;
    [self.view addSubview:_scrollView];
    self.automaticallyAdjustsScrollViewInsets=NO;

    [self setNav];
    [self setTopView];
    _containerView=[[Container alloc] init];
    _scrollView.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_containerView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.topView.mas_bottom);
        make.left.mas_equalTo(ws.view);
        make.right.mas_equalTo(ws.view);
        if(self.hidesBottomBarWhenPushed&&self.tabBarController)
        {
            make.bottom.mas_equalTo(ws.view);
        }
        else
        {
            make.bottom.mas_equalTo(ws.view).offset(-self.tabBarController.tabBar.frame.size.height);
        }
    }];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_scrollView);
        make.width.mas_equalTo(_scrollView);
    }];
    [self setNav];
    [self setTopView];
    [self CreatView];
}




-(void)addSubview:(UIView *)view
{
    [_containerView addSubview:view];
}

/**
 *  使用此方法设定containerView滚动下边界
 *
 *  @param view <#view description#>
 */
-(void)setBottomView:(UIView *)view
{
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view).offset(10);
    }];
}

-(void)updateBottomView:(UIView *)view
{
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view).offset(10);
    }];
}

- (void)setBottomView:(UIView *)view withHeight:(CGFloat)height {
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view).offset(height);
    }];
}

- (void)updateBottomView:(UIView *)view withHeight:(CGFloat)height {
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view).offset(height);
    }];
}

@end
