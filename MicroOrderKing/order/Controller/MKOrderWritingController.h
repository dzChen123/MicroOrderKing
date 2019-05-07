//
//  MKOrderWritingController.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseScrollViewController.h"

#import "MKGoodsInfoTable.h"

@interface MKOrderWritingController : BaseScrollViewController

- (instancetype)initWithType:(NSInteger)type;
- (void)cellDeleteUpdate;

@property (strong,nonatomic) NSMutableArray *tableViewData;
@property (assign,nonatomic) BOOL isOrdered;    //有没有添加过商品
@property (strong,nonatomic) MKGoodsInfoTable *infoTable;
@property (strong,nonatomic) NSString *orderId;
@property (strong,nonatomic) NSString *phoneNum;

@end
