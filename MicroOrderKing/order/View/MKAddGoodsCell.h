//
//  MKAddGoodsCell.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MKGoodsInfoView.h"

@interface MKAddGoodsCell : BaseTableViewCell
{
    MKGoodsInfoView *goodsInfoView;
    UIButton *addButn;
    UIButton *subtractButn;
    UILabel *numLab;
    
    MASConstraint *bottomConstraint;
}

@end
