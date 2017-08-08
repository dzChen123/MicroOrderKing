//
//  BaseTabBarController.m
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/9.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController
/**
 *  无中间按钮凸起初始化
 *
 *  @return <#return value description#>
 */
-(instancetype)init
{
    self=[super init];
    if(self)
    {
        _centerChangeFlag=NO;
    }
    return  self;
}

/**
 *  中间按钮凸起初始化
 *
 *  @param centerButtonImage <#centerButtonImage description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithChange:(UIImage *)centerButtonImage
{
    self=[super init];
    if(self)
    {
        _centerChangeFlag=YES;
        _centerButtonImage=centerButtonImage;
//        [self changeTabBar];
    }
    return  self;
}



/**
 *  设置tabBarItem相关
 */
+ (void)initialize
{
    
    
}

#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{
    
    
    
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:Vc];
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;
    
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor blackColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
//    dictSelected[NSForegroundColorAttributeName] =selectedtGreenColor;
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [Vc.tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [Vc.tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
//    Vc.navigationItem.title = title;
    
    [self addChildViewController:nav];
    
}



#pragma mark - ------------------------------------------------------------------
#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(UITabBar *)tabBar
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildVc];
    self.view.backgroundColor=[UIColor clearColor];
    self.view.superview.backgroundColor=[UIColor clearColor];

}

//
//-(void)changeTabBar
//{
//    BaseTabBar  *tabbar = [[BaseTabBar alloc] initWithCenterImage:_centerButtonImage];
//    tabbar.myDelegate = self;
//    //kvc实质是修改了系统的_tabBar
//    [self setValue:tabbar forKeyPath:@"tabBar"];
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
