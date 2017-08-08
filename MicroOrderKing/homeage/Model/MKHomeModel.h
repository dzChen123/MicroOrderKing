//
//  MKHomeModel.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/3.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKHttpModel.h"

@interface MKHomeModel : NSObject

@property (assign,nonatomic) NSInteger today_count;
@property (assign,nonatomic) NSInteger week_count;
@property (assign,nonatomic) NSInteger month_count;
@property (assign,nonatomic) NSInteger today_sum;
@property (assign,nonatomic) NSInteger week_sum;
@property (assign,nonatomic) NSInteger month_sum;
@property (assign,nonatomic) NSInteger shipping_count;
@property (assign,nonatomic) NSInteger confirm_count;


@end

@interface MKHomeHttpModel : MKHttpModel

@property(strong,nonatomic) MKHomeModel *data;

@end
