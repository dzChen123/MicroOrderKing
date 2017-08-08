//
//  IQKeyboardManagerHelper.m
//  Trucking
//
//  Created by 周逸帆 on 16/10/8.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "IQKeyboardManagerHelper.h"

@implementation IQKeyboardManagerHelper

//设置键盘
+(void)setKeyBoard{
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}


@end
