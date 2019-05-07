//
//  AppDelegate.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/25.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "AppDelegate.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>

#import "MKLoginViewController.h"
#import "MKHomePageViewController.h"
#import "BaseNavigationController.h"

#import "BaseTipHud.h"
#import "MKConfirmView.h"
#import "MKVersionModel.h"

//#import <JxbDebugTool/JxbDebugTool.h>

@interface AppDelegate ()

@property (strong,nonatomic) BaseTipHud *hud;
@end

@implementation AppDelegate
{
    MKConfirmView *confirmView;
    UIView *maskView;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *test = @"123";
    
    [IQKeyboardManagerHelper setKeyBoard];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self setRootViewController];
    
    //[[PgyManager sharedPgyManager] startManagerWithAppId:@"1dddd72bfdc0777acd7e51b90cc4d3fc"];
    
    //[ZYFUserDefaults setObject:@(0) key:@"appVersion"];
    if (![ZYFUserDefaults objectForKey:@"appVersion"]) {
        [ZYFUserDefaults setObject:@(1) key:@"appVersion"];
    }
    
    [self checkUpdateVersion];
    
    [self.window makeKeyAndVisible];
    
    
    // Override point for customization after application launch.
    return YES;
}

- (void)setRootViewController {
//    [ZYFUserDefaults setBool:NO key:@"loginFlag"];
    LxDBAnyVar([ZYFUserDefaults boolForKey:@"loginFlag"]);
    LxDBAnyVar([ZYFUserDefaults objectForKey:@"token"]);
    Class controllerClass = [ZYFUserDefaults boolForKey:@"loginFlag"] ? [MKHomePageViewController class] : [MKLoginViewController class];
    self.window.rootViewController = [[BaseNavigationController alloc] initWithRootViewController:[[controllerClass alloc] init]];
}

- (void)checkUpdateVersion {
    
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    
    [plist setObject:@"02" forKey:@"app_id"];
    
    [AFNetWorkingUsing httpGet:@"version" params:plist success:^(id json) {
        
        NSInteger currentVersion = [[ZYFUserDefaults objectForKey:@"appVersion"] integerValue];
        
        MKVersionModel *model = [MKVersionModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
        NSInteger newVersion = [model.version integerValue];
        if (newVersion > currentVersion) {      //升级
            [self goToUpdate:model.updateSign WithUrl:model.updateUrl];
        }
        
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        
    }];

}

- (void)goToUpdate:(NSString *)signStr WithUrl:(NSString *)url{
    
    maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    maskView.alpha = 0;
    [self.window addSubview:maskView];
    [self.window bringSubviewToFront:maskView];
    
    WS(ws)
    [maskView addTapEventWith:self action:@selector(cancel)];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(ws.window);
        make.center.mas_equalTo(ws.window);
    }];
    
    confirmView = [[MKConfirmView alloc] init];
    [self.window addSubview:confirmView];
    confirmView.cancelBlock =^(){
        [ws cancel];
    };
    confirmView.confirmBlock =^(){
        [ws updateWithUrl:url];
    };
    confirmView.alpha = 0;
    [confirmView setSignStr:@[signStr,@"前往更新"]];
    confirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
    [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.window).offset(leftPadding);
        make.right.mas_equalTo(ws.window).offset(rightPadding);
        make.centerY.mas_equalTo(ws.window);
    }];
    [UIView animateWithDuration:.3 animations:^{
        maskView.alpha = 1;
        confirmView.alpha = 1;
        confirmView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)updateWithUrl:(NSString *)url {
    
    [self cancel];
  
    //[[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:url]];
    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:@"itms-apps://itunes.apple.com/app/id1271255987"]];
//    NSLog(@"--updateClicked!--");
}

- (void)cancel {
    
    [UIView animateWithDuration:.2 animations:^{
        maskView.alpha = 0;
        confirmView.alpha = 0;
        confirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
    }completion:^(BOOL finished) {
        maskView.hidden = YES;
        confirmView.hidden = YES;
        [maskView removeFromSuperview];
        [confirmView removeFromSuperview];
    }];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
