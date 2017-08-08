//
//  MKMemberBaseModel.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/4.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKHttpModel.h"

@interface MKMemberBaseModel : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *initial;
@property (strong,nonatomic) NSString *phoneNum;
@property (strong,nonatomic) NSString *remark;
@property (strong,nonatomic) NSString *memberId;

@end

@interface MKMemAddreModel : NSObject

@property (strong,nonatomic) NSString *memberId;
@property (strong,nonatomic) NSString *ownerId;
@property (strong,nonatomic) NSString *addreId;
@property (strong,nonatomic) NSString *address;

@end

@interface MKMemOwnerModel : NSObject

@property (strong,nonatomic) NSString *ownerId;
@property (strong,nonatomic) NSString *ownerName;

@end

@interface MKMemberDetailModel : MKMemberBaseModel

@property (strong,nonatomic) NSString *userId;
@property (strong,nonatomic) NSString *orderCount;
@property (strong,nonatomic) NSString *sum;
@property (strong,nonatomic) NSString *lastTime;
@property (strong,nonatomic) MKMemOwnerModel *owner;
@property (strong,nonatomic) NSMutableArray *address;

@end



