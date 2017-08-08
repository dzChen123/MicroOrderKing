//
//  MKEditMemberController.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/6.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseViewController.h"

@interface MKEditMemberController : BaseViewController

@property(strong,nonatomic) NSString *memberId;

@end

@interface MKEditAddreView : BaseView

@property (strong,nonatomic) NSString *addreId;

- (void)setData:(id)model;

@end
