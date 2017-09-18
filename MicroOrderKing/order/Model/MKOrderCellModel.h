//
//  MKOrderCellModel.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/27.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKHttpModel.h"

@interface MKOrderCellModel : NSObject  //订单管理Cell

@property (assign,nonatomic) BOOL isSelected;
@property (strong,nonatomic) NSString *orderId;
@property (strong,nonatomic) NSString *conditionType;   //0 未发货  1已发货   2收到货并确认付款 3删除订单
@property (strong,nonatomic) NSString *payStatus;       //0 未支付  1已支付
@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *totalAmount;
@property (strong,nonatomic) NSString *totalCost;
@property (strong,nonatomic) NSMutableArray *goodsInfoArra;
@property (strong,nonatomic) NSString *createTime;
@property (strong,nonatomic) NSString *orderSn;

@end

@interface MKOrderCellHttpModel : MKHttpModel

@property (strong,nonatomic) NSMutableArray *data;

@end

@interface MKGoodsInfoModel : NSObject  //商品信息

@property (strong,nonatomic) NSString *imgUrl;
@property (strong,nonatomic) NSString *goodsName;
@property (strong,nonatomic) NSString *price;
@property (strong,nonatomic) NSString *goodsId;
@property (strong,nonatomic) NSString *unit;
@property (strong,nonatomic) NSString *number;  //库存

@end

@interface MKGoodsInfoHttpModel : MKHttpModel   //商品管理界面的

@property (strong,nonatomic) NSMutableArray *data;

@end

@interface MKOrderGoodsModel : NSObject //订单商品信息(单件)

@property (strong,nonatomic) NSString *payNumber;  //买的商品个数
@property (strong,nonatomic) NSString *goodsId;
@property (strong,nonatomic) NSString *orderId;
@property (strong,nonatomic) NSString *price;
@property (strong,nonatomic) MKGoodsInfoModel *goods;

@end

@interface MKAddGoodsCellModel : MKGoodsInfoModel   //添加商品cell

@property (strong,nonatomic) NSString *buyCount;

@end

@interface MKAddGoodsCellHttpModel : MKHttpModel     //添加商品页面

@property (strong,nonatomic) NSMutableArray *data;

@end

@interface MKCountCostCellModel : NSObject  //录入订单

@property (strong,nonatomic) MKAddGoodsCellModel *goodsCellModel;
@property (strong,nonatomic) NSString *totalCost;

@end

@interface MKOrderDetailModel : MKOrderCellModel    //编辑订单 订单详情

@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *phoneNum;
@property(strong,nonatomic) NSString *remark;
@property (strong,nonatomic) NSString *addressId;
@property (strong,nonatomic) NSString *memberId;

@end

@interface MKNewGoods : NSObject

@property(strong,nonatomic) NSString *imageUrl;
@property(strong,nonatomic) NSString *nameStr;
@property(strong,nonatomic) NSString *price;
@property(strong,nonatomic) NSString *unitStr;
@property(strong,nonatomic) NSString *amount;

@end
