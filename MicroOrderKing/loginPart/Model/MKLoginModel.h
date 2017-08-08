//
//  MKLoginModel.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/2.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKHttpModel.h"

@interface MKLoginModel : NSObject

@property (strong,nonatomic) NSString *token;
@property (strong,nonatomic) NSString *parent_id;

@end

@interface MKHttpLoginModel : MKHttpModel

@property (strong,nonatomic) MKLoginModel *data;

@end


