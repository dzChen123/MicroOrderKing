//
//  MKAddreMatchModel.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/7.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKAddreMatchModel : NSObject

@property (assign,nonatomic) BOOL needsUpdate;      //本地数据更新标识
@property (strong,nonatomic) NSString *matchId;
@property (strong,nonatomic) NSString *mobile;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSMutableArray *address;

@end

@interface MKAddreMatchItemModel : NSObject

@property (strong,nonatomic) NSString *itemId;
@property (strong,nonatomic) NSString *memberId;
@property (strong,nonatomic) NSString *address;

@end
