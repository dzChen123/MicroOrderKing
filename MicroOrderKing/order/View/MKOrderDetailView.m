//
//  MKOrderDetailView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKOrderDetailController.h"

#import "MKOrderDetailView.h"

#import "MKOrderCellModel.h"

@implementation MKOrderDetailView
{
    UILabel *orderIdTittle;
    UILabel *orderIdLab;
    UILabel *conditionLab;
    UILabel *timeTittle;
    UILabel *timeLab;
    UILabel *receiverTittle;
    UILabel *nameLab;
    UILabel *phoneLab;
    UILabel *addreTittle;
    UILabel *addreLab;
    UILabel *markTittle;
    UILabel *markLab;
    UIView *lineView;

}

- (void)CreatView {
    orderIdTittle = [[UILabel alloc] init];
    orderIdLab = [[UILabel alloc] init];
    conditionLab = [[UILabel alloc] init];
    timeTittle = [[UILabel alloc] init];
    timeLab = [[UILabel alloc] init];
    receiverTittle = [[UILabel alloc] init];
    nameLab = [[UILabel alloc] init];
    phoneLab = [[UILabel alloc] init];
    addreTittle = [[UILabel alloc] init];
    addreLab = [[UILabel alloc] init];
    markTittle = [[UILabel alloc] init];
    markLab = [[UILabel alloc] init];
    lineView = [[UIView alloc] init];
    
    [self addSubview:orderIdTittle];
    [self addSubview:orderIdLab];
    [self addSubview:conditionLab];
    [self addSubview:timeTittle];
    [self addSubview:timeLab];
    [self addSubview:receiverTittle];
    [self addSubview:nameLab];
    [self addSubview:phoneLab];
    [self addSubview:addreTittle];
    [self addSubview:addreLab];
    [self addSubview:markTittle];
    [self addSubview:markLab];
    [self addSubview:lineView];
}

- (void)SettingViewAttributes {
    
    WS(ws)

    self.backgroundColor = customWhite;
    
    [self setLabelAttributesWithTittle:@"订单编号" andLab:orderIdTittle];
    [orderIdTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.top.mas_equalTo(ws).offset(20 * autoSizeScaleH);
    }];
    
    [self setLabelAttributesWithTittle:@"" andLab:orderIdLab];
    [orderIdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(85 * autoSizeScaleW);
        make.centerY.mas_equalTo(orderIdTittle);
    }];
    
    conditionLab.font = FONT(12);
    conditionLab.textColor = customWhite;
    conditionLab.layer.masksToBounds = YES;
    conditionLab.layer.cornerRadius = 3.0;
    [conditionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.centerY.mas_equalTo(orderIdTittle);
        make.height.mas_equalTo(20 * autoSizeScaleH);
    }];
    
    [self setLabelAttributesWithTittle:@"创建时间" andLab:timeTittle];
    [timeTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderIdTittle);
        make.top.mas_equalTo(orderIdTittle.mas_bottom).offset(20 * autoSizeScaleH);
    }];
    
    [self setLabelAttributesWithTittle:@"" andLab:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderIdLab);
        make.centerY.mas_equalTo(timeTittle);
    }];
    
    [self setLabelAttributesWithTittle:@"收货人" andLab:receiverTittle];
    [receiverTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeTittle);
        make.top.mas_equalTo(timeTittle.mas_bottom).offset(20 * autoSizeScaleH);
    }];
    
    [self setLabelAttributesWithTittle:@"" andLab:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeLab);
        make.centerY.mas_equalTo(receiverTittle);
    }];
    
    [self setLabelAttributesWithTittle:@"" andLab:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(conditionLab);
        make.centerY.mas_equalTo(receiverTittle);
    }];

    [self setLabelAttributesWithTittle:@"收获地址" andLab:addreTittle];
    [addreTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(receiverTittle);
        make.top.mas_equalTo(receiverTittle.mas_bottom).offset(20 * autoSizeScaleH);
    }];
    
    addreLab.numberOfLines = 0;
    [self setLabelAttributesWithTittle:@"" andLab:addreLab];
    [addreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab);
        make.right.lessThanOrEqualTo(conditionLab);
        make.top.mas_equalTo(addreTittle);
    }];

    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addreTittle);
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.top.mas_equalTo(addreLab.mas_bottom).offset(20 * autoSizeScaleH);
        make.height.mas_equalTo(1);
    }];
    
    [self setLabelAttributesWithTittle:@"备注" andLab:markTittle];
    [markTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView);
        make.top.mas_equalTo(lineView.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    markLab.numberOfLines = 0;
    [self setLabelAttributesWithTittle:@"" andLab:markLab];
    [markLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab);
        make.right.lessThanOrEqualTo(ws).offset(rightPadding);
        make.top.mas_equalTo(markTittle);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(markLab.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
}

- (void)setData:(id)model {
    
    MKOrderDetailModel *dataModel = (MKOrderDetailModel *)model;
    orderIdLab.text = dataModel.orderSn;
    timeLab.text = dataModel.createTime;
    nameLab.text = dataModel.name;
    addreLab.text = dataModel.address;
    markLab.text = dataModel.remark;
    if (!dataModel.remark.length) {
        WS(ws)
        
        [ws mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(markTittle.mas_bottom).offset(15 * autoSizeScaleH);
        }];
    }
    if (!dataModel.address.length) {

        [lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(addreTittle.mas_bottom).offset(20 * autoSizeScaleH);
        }];
    }
    phoneLab.text = dataModel.phoneNum;
    

    switch ([dataModel.conditionType integerValue]) {
        case 0:
        {
            conditionLab.text = @" 未付款 ";
            conditionLab.backgroundColor = [UIColor hexStringToColor:@"#FB737C"];
        }
            break;
        case 1:
        {
            conditionLab.text = @" 已付款 ";
            conditionLab.backgroundColor = [UIColor hexStringToColor:@"#77AEFF"];
        }
            break;
        case 2:
        {
            conditionLab.text = @" 已完成 ";
            conditionLab.backgroundColor = [UIColor hexStringToColor:@"#37BF76"];
        }
            break;
        default:
            break;
    }
    if ([dataModel.conditionType integerValue] < [dataModel.payStatus integerValue]) {
        conditionLab.text = @" 已付款 ";
        conditionLab.backgroundColor = [UIColor hexStringToColor:@"#77AEFF"];
    }
}

- (void)setLabelAttributesWithTittle:(NSString *)tittle andLab:(UILabel *)lab {
    if (tittle.length) {
        lab.text = tittle;
    }
    lab.font = FONT(14);
    lab.textColor = [UIColor hexStringToColor:@"#A2A2A2"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
