//
//  MKAccountBaseModel.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKHttpModel.h"

@interface MKAccountBaseModel : NSObject

@property (strong,nonatomic) NSString *accountId;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *phoneNum;
@property (strong,nonatomic) NSString *conditionType;


@end

@interface MKAccountHttpBaseModel : MKHttpModel

@property (strong,nonatomic) NSMutableArray *data;

@end

@interface MKAccountDetailModel : MKAccountBaseModel

@property (strong,nonatomic) NSString *timeStr;
@property (strong,nonatomic) NSString *memberNum;
@property (strong,nonatomic) NSString *orderNum;

@end

@interface MKAccountHttpDetailModel : MKHttpModel

@property (strong,nonatomic) MKAccountDetailModel *data;

@end
