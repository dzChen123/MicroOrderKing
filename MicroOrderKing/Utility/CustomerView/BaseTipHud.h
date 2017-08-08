//
//  BaseTipHud.h
//  Trucking
//
//  Created by 周逸帆 on 16/10/8.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
@interface BaseTipHud : MBProgressHUD


+ (MBProgressHUD *)sharedMBProgressHUD;
+(void)showTipMessage:(NSString *)message;
+(void)showWait;
+(void)showWaitHudWithMessage:(NSString *)message;
-(void)showTipMessage:(NSString *)message;
-(void)showTipMessageAutoHide:(NSString *)message;
-(void)showTipMessage:(NSString *)message afterDelay:(NSTimeInterval)time;
-(void)showWait;
-(void)showWaitHudWithMessage:(NSString *)message;
+(void)hide;
+(void)hideAfterDelay:(NSTimeInterval)time;
-(void)shwoError:(NSError *)error;
@end
