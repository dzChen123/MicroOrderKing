//
//  BaseViewController.h
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/9.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTopView.h"
#import "UIView+ZYFUIViewCategory.h"
#import "Container.h"
#import "ZYFUtilityPch.h"
//#import "BaseViewModel.h"
#import "BaseTipHud.h"
@interface BaseViewController : UIViewController
@property (nonatomic, strong)IQKeyboardReturnKeyHandler   *returnKeyHandler;
@property (nonatomic,strong) NSString *topTitle;
@property (nonatomic,assign) BOOL showTopViewFlag;
@property (nonatomic,strong) BaseTopView *topView;
@property (nonatomic,strong) BaseTipHud *hud;
-(void)addSubview:(UIView *)view;
-(instancetype)initWithTitle:(NSString *)topTitle;
-(void)CreatView;
-(void)setTopView;
-(void)setNav;
-(void)setTopTitle:(NSString *)topTitle;
@end
