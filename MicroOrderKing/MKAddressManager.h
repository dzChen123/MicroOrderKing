//
//  MKAddressManager.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/10.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKAddreMatchModel.h"

@interface MKAddressManager : NSObject

@property(strong,nonatomic) NSMutableArray *memberArray;

+ (MKAddressManager *)sharedAddressManager;

- (void)allNeedsUpdate;

- (MKAddreMatchModel *)getAddreModelWithPhone:(NSString *)mobile;

- (void)updadteLocalInfo:(MKAddreMatchModel *)model;

- (void)needsUpdate:(NSString *)memberId;

- (void)saveLocalInfo;

@end
