//
//  BaseTipHud.m
//  Trucking
//
//  Created by 周逸帆 on 16/10/8.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "BaseTipHud.h"
static MBProgressHUD *hud;
@implementation BaseTipHud





/**
 * 创建网络请求管理类单例对象
 */
+ (MBProgressHUD *)sharedMBProgressHUD {
     if(hud)
     {
         [hud removeFromSuperview];
         hud=nil;
     }
    UIView *view =[[UIApplication sharedApplication].delegate window];
    hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    return hud;
}


+(void)showTipMessage:(NSString *)message
{
    MBProgressHUD *hud=[self sharedMBProgressHUD];
    hud.label.text=message;
    hud.mode=MBProgressHUDModeText;
    [hud showAnimated:YES];
}

-(void)showTipMessage:(NSString *)message
{
    self.label.text=message;
    self.mode=MBProgressHUDModeText;
    [self showAnimated:YES];
}


-(void)showTipMessageAutoHide:(NSString *)message
{
    self.label.text=message;
    self.mode=MBProgressHUDModeText;
    [self showAnimated:YES];
    [self hideAnimated:YES afterDelay:1];
}

-(void)showTipMessage:(NSString *)message afterDelay:(NSTimeInterval)time
{
    self.label.text=message;
    self.mode=MBProgressHUDModeText;
    [self showAnimated:YES];
    [self hideAnimated:YES afterDelay:time];
}


-(void)showWait
{
    self.label.text=@"";
    self.mode=MBProgressHUDModeIndeterminate;
    [self showAnimated:YES];
}

-(void)showWaitHudWithMessage:(NSString *)message
{
    self.label.text=message;
    self.mode=MBProgressHUDModeCustomView;
    [self showAnimated:YES];
}

+(void)showWait
{
    MBProgressHUD *hud=[self sharedMBProgressHUD];
    hud.label.text=@"";
    hud.mode=MBProgressHUDModeIndeterminate;
    [hud showAnimated:YES];
}

+(void)showWaitHudWithMessage:(NSString *)message
{
    MBProgressHUD *hud=[self sharedMBProgressHUD];
    hud.label.text=message;
    hud.mode=MBProgressHUDModeCustomView;
    [hud showAnimated:YES];
}

-(void)shwoError:(NSError *)error
{
    
    [self showTipMessage:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"customErrorInfoKey"]]];
//    [self showTipMessage: [NSString stringWithFormat:@"发生错误:%@",error.localizedDescription
//                           ]];
    [self hideAnimated:YES afterDelay:1];
   
}

+ (void)hide{
    
}

+ (void)hideAfterDelay:(NSTimeInterval)time{

}

@end
