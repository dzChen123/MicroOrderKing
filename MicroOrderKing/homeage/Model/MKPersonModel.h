//
//  MKPersonModel.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/1.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKHttpModel.h"


@interface MKPersonModel : NSObject

@property (strong,nonatomic) NSString *phoneNum;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *timeStr;
@property (strong,nonatomic) NSString *isTry;

@end

@interface MKPersonHttpModel : MKHttpModel

@property (strong,nonatomic) MKPersonModel *data;

@end


