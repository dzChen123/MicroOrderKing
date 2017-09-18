//
//  MKGoodsInfoCell.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKOrderWritingController.h"

#import "MKGoodsInfoCell.h"

#import "MKOrderCellModel.h"

@implementation MKGoodsInfoCell
{

    UIView *lineView;
    UILabel *totalPriceLab;
    UIView *lineView2;
    
    NSInteger _buyCount;
    NSInteger _maxCount;
    NSString *goodsId;
    NSString *price;
}

- (void)createView {
    [super createView];
    
    lineView = [[UIView alloc] init];
    totalPriceLab = [[UILabel alloc] init];
    lineView2 = [[UIView alloc] init];
    
    [self.contentView addSubview:lineView];
    [self.contentView addSubview:totalPriceLab];
    [self.contentView addSubview:lineView2];
}

- (void)setttingViewAtuoLayout {
    
    WS(ws)
    
    [super setttingViewAtuoLayout];
    
    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.contentView).offset(leftPadding);
        make.right.mas_equalTo(ws.contentView).offset(rightPadding);
        make.top.mas_equalTo(subtractButn.mas_bottom).offset(10 * autoSizeScaleH);
        make.height.mas_equalTo(1);
    }];
    
    [bottomConstraint uninstall];
    [totalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws.contentView).offset(rightPadding);
        make.top.mas_equalTo(lineView).offset(15 * autoSizeScaleH);
//        make.bottom.mas_equalTo(ws.contentView).offset(-15  * autoSizeScaleH);
    }];
    
    lineView2.backgroundColor = VIEWBACKGRAY;
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.height.mas_equalTo(lineView);
        make.left.right.bottom.mas_equalTo(ws.contentView);
    }];
}

- (void)setData:(id)model {
    
    MKCountCostCellModel *cellModel = (MKCountCostCellModel *)model;
    
    [super setData:cellModel.goodsCellModel];
    
    _buyCount = [cellModel.goodsCellModel.buyCount integerValue];
    _maxCount = [cellModel.goodsCellModel.number integerValue];
    goodsId = cellModel.goodsCellModel.goodsId;
    price = cellModel.goodsCellModel.price;
    
    NSString *totalCostStr = cellModel.totalCost;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"小计(元): ¥%@",totalCostStr]];
    [attr addAttribute:NSFontAttributeName
                 value:FONT(10)
                 range:NSMakeRange(0, attr.length - totalCostStr.length)];
    [attr addAttribute:NSForegroundColorAttributeName
                 value:[UIColor hexStringToColor:@"#7B7B7B"]
                 range:NSMakeRange(0, attr.length - totalCostStr.length)];
    [attr addAttribute:NSFontAttributeName
                 value:FONT(16)
                 range:NSMakeRange(attr.length - totalCostStr.length, totalCostStr.length)];
    [attr addAttribute:NSForegroundColorAttributeName
                 value:[UIColor hexStringToColor:@"#ff7878"]
                 range:NSMakeRange(attr.length - totalCostStr.length - 1, totalCostStr.length + 1)];
    totalPriceLab.attributedText = attr;
    
}

- (void)addSubtractButnClick:(UIButton *)sender {
    UIViewController *parent = [self parentController];
    [self showTip:sender];
    numLab.text = [NSString stringWithFormat:@"%ld",(long)_buyCount];
    NSString *totalCostStr = [NSString stringWithFormat:@"%ld",(_buyCount * [price integerValue])];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"小计(元): ¥%@",totalCostStr]];
    [attr addAttribute:NSFontAttributeName
                 value:FONT(10)
                 range:NSMakeRange(0, attr.length - totalCostStr.length)];
    [attr addAttribute:NSForegroundColorAttributeName
                 value:[UIColor hexStringToColor:@"#7B7B7B"]
                 range:NSMakeRange(0, attr.length - totalCostStr.length - 1)];
    [attr addAttribute:NSFontAttributeName
                 value:FONT(16)
                 range:NSMakeRange(attr.length - totalCostStr.length, totalCostStr.length)];
    [attr addAttribute:NSForegroundColorAttributeName
                 value:[UIColor hexStringToColor:@"#ff7878"]
                 range:NSMakeRange(attr.length - totalCostStr.length - 1, totalCostStr.length + 1)];
    totalPriceLab.attributedText = attr;
    if ([parent isKindOfClass:[MKOrderWritingController class]]) {
        MKOrderWritingController *controller = (MKOrderWritingController *)parent;
        for (MKCountCostCellModel *model in controller.infoTable.dataArray) {
            if ([model.goodsCellModel.goodsId isEqualToString:goodsId]) {
                model.goodsCellModel.buyCount  =[NSString stringWithFormat:@"%ld",(long)_buyCount];
                model.totalCost = totalCostStr;
                break;
            }
        }
    } else {
        
    }
}

- (void)showTip:(UIButton *)sender {
    BaseViewController *parent = (BaseViewController *)[self parentController];
    
    if (sender.tag == 3 ) {
        if (_buyCount + 1 > _maxCount) {
            [parent.hud showTipMessageAutoHide:@"购买数量已达最大了哦"];
            return;
        }
        _buyCount ++;
    }else{
        if (_buyCount - 1 < 0) {
            [parent.hud showTipMessageAutoHide:@"已经是0件了，不用再点了～"];
            return;
        }
        _buyCount --;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
