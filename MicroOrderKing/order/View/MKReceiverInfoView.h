//
//  MKReceiverInfoView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKReceiverInfoView : BaseView<UITextViewDelegate,UITextFieldDelegate>

- (void)setReceiverInfo:(NSString *)name Phone:(NSString *)phone Address:(NSString *)address;
- (void)setInfoPhoneNum:(NSString *)phoneNum;
- (NSArray *)getReceiverInfo;

@end
