//
//  MKAddGoodsCell.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAddGoodsController.h"
#import "BaseViewController.h"

#import "MKAddGoodsCell.h"
#import "MKGoodsInfoView.h"

#import "MKOrderCellModel.h"

@implementation MKAddGoodsCell
{
    UIView *lineView;
    
    NSInteger _maxCount;
    NSInteger _buyCount;
    NSString *goodsId;
    
    BOOL countFlag;
    BOOL overFlag;
}

- (void)createView {
    goodsInfoView = [[MKGoodsInfoView alloc] initWithType:0];
    addButn = [[UIButton alloc] init];
    subtractButn = [[UIButton alloc] init];
    numLab = [[UILabel alloc] init];
    lineView = [[UIView alloc] init];
    
    [self.contentView addSubview:goodsInfoView];
    [self.contentView addSubview:addButn];
    [self.contentView addSubview:subtractButn];
    [self.contentView addSubview:numLab];
    [self.contentView addSubview:lineView];
}

- (void)setttingViewAtuoLayout {
    
    WS(ws)
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = customWhite;
    
    goodsInfoView.backgroundColor = customWhite;
    [goodsInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.contentView).offset(5 * autoSizeScaleW);
        make.right.top.mas_equalTo(ws.contentView);
    }];
    
    addButn.tag = 3;
    [addButn addTarget:self action:@selector(addSubtractButnClick:) forControlEvents:UIControlEventTouchUpInside];
    [addButn setImage:[[UIImage imageNamed:@"enorderAdd"] imageByScalingToSize:CGSizeMake(25 * autoSizeScaleW, 25 * autoSizeScaleW)] forState:UIControlStateNormal];
    [addButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(goodsInfoView.mas_bottom);
        make.right.mas_equalTo(ws.contentView).offset(rightPadding);
        make.width.height.mas_equalTo(25 * autoSizeScaleW);
    }];
    
    numLab.font = FONT(12);
    numLab.textColor = [UIColor hexStringToColor:@"#8C8C8C"];
    [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(addButn.mas_left).offset(-20 * autoSizeScaleW);
        make.centerY.mas_equalTo(addButn);
    }];
    
    subtractButn.tag = 4;
    [subtractButn addTarget:self action:@selector(addSubtractButnClick:) forControlEvents:UIControlEventTouchUpInside];
    [subtractButn setImage:[[UIImage imageNamed:@"enorderLess"] imageByScalingToSize:CGSizeMake(25 * autoSizeScaleW, 25 * autoSizeScaleW)] forState:UIControlStateNormal];
    [subtractButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerY.mas_equalTo(addButn);
        make.right.mas_equalTo(numLab.mas_left).offset(-20 * autoSizeScaleW);
        bottomConstraint = make.bottom.mas_equalTo(ws.contentView).offset(-10 * autoSizeScaleH);
    }];
    
    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(1);
    }];
    
}

- (void)setData:(id)model {
    MKAddGoodsCellModel *cellModel = (MKAddGoodsCellModel *)model;
    goodsId = cellModel.goodsId;
    _buyCount = [cellModel.buyCount integerValue];
    _maxCount = [cellModel.number integerValue];
    numLab.text = cellModel.buyCount;
    [goodsInfoView setDataWithModel:cellModel];
}

- (void)addSubtractButnClick:(UIButton *)sender {
    UIViewController *parent = [self parentController];
    [self showTip:sender];
    if ([parent isKindOfClass:[MKAddGoodsController class]]) {
        MKAddGoodsController *controller = (MKAddGoodsController *)parent;
        for (MKAddGoodsCellModel *model in controller.goodsTable.dataArray) {
            if ([model.goodsId isEqualToString:goodsId]) {
                model.buyCount  =[NSString stringWithFormat:@"%ld",(long)_buyCount];
                break;
            }
        }
        [controller setBottomCount];
    } else {
        
    }
    
    
}

- (void)showTip:(UIButton *)sender {
    BaseViewController *parent = (BaseViewController *)[self parentController];
    overFlag = NO;
    if (sender.tag == 3 ) {
        if (_buyCount + 1 > _maxCount) {
            [parent.hud showTipMessageAutoHide:@"购买数量已达最大了哦"];
            overFlag = YES;
            return;
        }
        countFlag = YES;
        _buyCount ++;
    }else{
        if (_buyCount - 1 < 0) {
            [parent.hud showTipMessageAutoHide:@"已经是0件了，不用再点了～"];
            overFlag = YES;
            return;
        }
        countFlag = YES;
        _buyCount --;
    }
    numLab.text = [NSString stringWithFormat:@"%ld",(long)_buyCount];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
