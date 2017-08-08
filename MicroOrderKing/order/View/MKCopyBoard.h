//
//  MKCopyBoard.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKCopyBoard : BaseView<UITextViewDelegate>

@property (strong,nonatomic) void (^fillClickBlock)(NSString *phoneNum);

@end
