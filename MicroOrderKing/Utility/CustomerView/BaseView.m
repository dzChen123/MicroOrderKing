//
//  BaseView.m
//  Trucking
//
//  Created by 周逸帆 on 16/10/8.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "BaseView.h"
@implementation BaseView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self CreatView];
        [self SettingViewAttributes];
        
    }
    return self;
}


- (void)CreatView{

}

- (void)SettingViewAttributes{

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
