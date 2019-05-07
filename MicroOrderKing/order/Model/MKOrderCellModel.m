//
//  MKOrderCellModel.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/27.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKOrderCellModel.h"

@implementation MKOrderCellModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"totalCost" : @"amount",
             @"orderId" : @"id",
             @"goodsInfoArra" : @"order_goods",
             @"createTime" : @"create_time",
             @"orderSn" : @"order_sn",
             @"conditionType" : @"post_status",
             @"payStatus" : @"pay_status",
             @"totalAmount" : @"total",
             @"deliveryTime" : @"delivery_time",
             @"deliverMethod" : @"shipping_method"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"goodsInfoArra" : @"MKOrderGoodsModel"
             };
}

@end

@implementation MKOrderCellHttpModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"data" : @"MKOrderCellModel"
             };
}

@end


@implementation MKGoodsInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"imgUrl" : @"sm_logo",
             @"goodsName" : @"name",
             @"goodsId" : @"id",
             @"isSale" : @"is_sale"
             };
}


@end

@implementation MKGoodsInfoHttpModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"data" : @"MKGoodsInfoModel"
             };
}

@end

@implementation MKOrderGoodsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"payNumber" : @"pay_number",
             @"goodsId" : @"goods_id",
             @"orderId" : @"order_id",
             };
}

@end

@implementation MKAddGoodsCellModel

@end

@implementation MKAddGoodsCellHttpModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"data" : @"MKAddGoodsCellModel"
             };
}

@end

@implementation MKCountCostCellModel

@end

@implementation MKOrderDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[super mj_replacedKeyFromPropertyName]];
    [dic addEntriesFromDictionary:@{
                                    @"phoneNum" : @"mobile",
                                    @"name" : @"consignee",
                                    @"addressId" : @"address_id",
                                    @"memberId" : @"member_id",
                                    @"shippingMethod" : @"shipping_method"
                                    }];
    return (NSDictionary *)dic;
}

@end

@implementation MKNewGoods


@end
