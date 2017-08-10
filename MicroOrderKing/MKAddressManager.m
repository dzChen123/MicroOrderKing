//
//  MKAddressManager.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/10.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAddressManager.h"

#import "MKAddreMatchModel.h"

@implementation MKAddressManager

+ (MKAddressManager *)sharedAddressManager {
    static MKAddressManager *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[MKAddressManager alloc] init];
    });
    return manager;
}

- (void)allNeedsUpdate {
    for (MKAddreMatchModel *model in self.memberArray) {
        model.needsUpdate = YES;
    }
}

- (MKAddreMatchModel *)getAddreModelWithPhone:(NSString *)mobile {
    for (MKAddreMatchModel *model in self.memberArray) {
        if ([model.mobile isEqualToString:mobile]) {
            return model;
        }
    }
    return nil;
}

- (void)updadteLocalInfo:(MKAddreMatchModel *)model {
    for (MKAddreMatchModel *oldModel in self.memberArray) {
        if ([oldModel.matchId isEqualToString:model.matchId]) {
            NSInteger index = [self.memberArray indexOfObject:oldModel];
            [self.memberArray replaceObjectAtIndex:index withObject:model];
            return;
        }
    }
}

- (void)needsUpdate:(NSString *)memberId {
    for (MKAddreMatchModel *model in self.memberArray) {
        if ([memberId isEqualToString:model.matchId]) {
            model.needsUpdate = YES;
            break;
        }
    }
}

- (void)saveLocalInfo {
    NSMutableArray *dataArra = [[NSMutableArray alloc] init];
    for (MKAddreMatchModel *model in self.memberArray) {
        NSDictionary *dic = [model mj_keyValues];
        [dataArra addObject:dic];
    }
    [ZYFUserDefaults setObject:dataArra key:@"memberDatas"];
}

- (NSMutableArray *)memberArray {
    if (!_memberArray) {
        NSMutableArray *dataArra = [ZYFUserDefaults objectForKey:@"memberDatas"];
        _memberArray = [[NSMutableArray alloc] init];
        if (dataArra != nil && !dataArra.count) {
            for (NSDictionary *dic in dataArra) {
                MKAddreMatchModel *model = [MKAddreMatchModel mj_objectWithKeyValues:dic];
                [_memberArray addObject:model];
            }
        }
    }
    return _memberArray;
}

@end
