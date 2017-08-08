//
//  BaseTabBarController.h
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/9.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseTabBarController : UITabBarController
@property (nonatomic,assign) BOOL centerChangeFlag;//是否为中间凸起
@property (nonatomic,strong) UIImage* centerButtonImage;
- (void)setUpAllChildVc;
-(instancetype)initWithChange:(UIImage *)centerButtonImage;
- (void)tabBarPlusBtnClick:(UITabBar *)tabBar;
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title;
@end
