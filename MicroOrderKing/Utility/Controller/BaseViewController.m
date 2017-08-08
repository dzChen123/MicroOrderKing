//
//  BaseViewController.m
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/9.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "BaseViewController.h"



@interface BaseViewController ()

@end

@implementation BaseViewController
{
    
}

-(BaseTipHud *)hud
{
    if(_hud)
    {
        [_hud hideAnimated:YES];
        [_hud removeFromSuperview];
    }
    _hud=[[BaseTipHud alloc] initWithView:self.view];
    [self.view addSubview:_hud];
    return _hud;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(instancetype)initWithTitle:(NSString *)topTitle
{
    self=[self init];
    if(self)
    {
        _topTitle =topTitle;
        _showTopViewFlag=YES;
    }
    return self;
}

-(instancetype)init
{
    self=[super init];
    if(self)
    {
        _showTopViewFlag=YES;
    }
    return self;
}


-(void)setTopTitle:(NSString *)topTitle
{
     _topView.titleLabel.text=topTitle;
    _topTitle=topTitle;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    Container *view =[[Container alloc] initWithFrame:self.view.frame];
    self.view=view;//将view改为IQKeyBord容器
    self.view.backgroundColor=VIEWBACKGRAY;
    [self setNav];
    [self setTopView];
    [self CreatView];
}







/**
 *  设置头部导航条
 */
-(void)setTopView
{
    if(_showTopViewFlag)
    {
       _topView=[BaseTopView initWithBcakAndTitle:_topTitle andSuperView:self.view];
    }
}


/**
 *  隐藏导航条，导航条自己实现
 */
-(void)setNav
{
//    NSLog(@"setnav,controller:%@",self);
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.hidden = YES;
}

/**
 *  视图布置(所有子类继承此方法 并且在此方法内写布局)
 */
-(void)CreatView
{
    
}

/**
 *  增加子视图
 *
 *  @param view <#view description#>
 */
-(void)addSubview:(UIView *)view
{

    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  inject插件设置(Xcode插件)，可无需重新运行进行界面调试
 
 */
-(void)injected{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self viewDidLoad];
    NSLog(@"I've been injected: %@", self);
}


-(void)popToControllerClass:(Class)class
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if([controller isKindOfClass:class])
        {
            [self.navigationController popToViewController:controller animated:YES];
            return ;
        }
    }

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
