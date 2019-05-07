//
//  MKGoodsInfoView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/27.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKGoodsInfoView.h"

#import "MKOrderCellModel.h"

@implementation MKGoodsInfoView
{
    UIImageView *goodsPic;
    UILabel *nameLab;
    UILabel *priceLab;
    UILabel *numLab;
    UIView *lineView;
    
    NSInteger _type;  //type为0时是库存   type为1时是订单
}

- (instancetype)initWithType:(NSInteger)type {
    _type = type;
    self = [super init];
    return self;
}

- (void)CreatView {
    goodsPic = [[UIImageView alloc] init];
    nameLab = [[UILabel alloc] init];
    priceLab = [[UILabel alloc] init];
    numLab = [[UILabel alloc] init];
    lineView = [[UIView alloc] init];
    
    [self addSubview:goodsPic];
    [self addSubview:nameLab];
    [self addSubview:priceLab];
    [self addSubview:numLab];
    [self addSubview:lineView];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    self.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
    
    //goodsPic.backgroundColor = [UIColor lightGrayColor];
    [goodsPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.top.mas_equalTo(ws).offset(15 * autoSizeScaleH);
        make.width.height.mas_equalTo(70 * autoSizeScaleW);
    }];
    
    nameLab.font = FONT(14);
    nameLab.textColor = [UIColor hexStringToColor:@"#1E1E1E"];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(goodsPic.mas_right).offset(10 * autoSizeScaleW);
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.top.mas_equalTo(goodsPic).offset(5 * autoSizeScaleH);
    }];
    
    if (_type != 1) {
        numLab.font = FONT(12);
        numLab.textColor = [UIColor hexStringToColor:@"#7B7B7B"];
    }
    
    if (_type > 1) {
        
        nameLab.numberOfLines = 2;
        
        [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(nameLab);
            make.bottom.mas_equalTo(goodsPic);
        }];
        
        lineView.backgroundColor = VIEWBACKGRAY;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(numLab.mas_right).offset(10 * autoSizeScaleW);
            make.centerY.mas_equalTo(numLab);
            make.size.mas_equalTo(CGSizeMake(1, 10 * autoSizeScaleH));
        }];
        
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineView.mas_right).offset(10 * autoSizeScaleW);
            make.bottom.mas_equalTo(numLab);
        }];
    }else{
        
        [lineView removeFromSuperview];
        
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(nameLab);
            make.bottom.mas_equalTo(goodsPic);
        }];
        
        if (!_type) {
            priceLab.font = FONT(12);
            priceLab.textColor = [UIColor hexStringToColor:@"#7B7B7B"];
            
            [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(nameLab);
                make.top.mas_equalTo(nameLab.mas_bottom).offset(10 * autoSizeScaleH);
            }];
        }else{
            
            nameLab.numberOfLines = 2;
            
            [numLab removeFromSuperview];
        }
    }
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(goodsPic).offset(15 * autoSizeScaleH);
    }];
}

- (void)setDataWithModel:(id)model {
    
    MKGoodsInfoModel *goodsModel = [[MKGoodsInfoModel alloc] init];
    NSString *priceStr,*numberStr,*unitStr;
    if (!_type) {
        MKAddGoodsCellModel *dataModel = (MKAddGoodsCellModel *)model;
        numberStr = dataModel.number;
        priceStr = dataModel.price;
        unitStr = dataModel.unit;
        nameLab.text = dataModel.goodsName;
        goodsModel.imgUrl = dataModel.imgUrl;
    }else if(_type == 1){
        MKOrderGoodsModel *dataModel = (MKOrderGoodsModel *)model;
        goodsModel = dataModel.goods;
        numberStr = dataModel.payNumber;
        //priceStr = goodsModel.price;
        priceStr = dataModel.price;
        unitStr = goodsModel.unit;
        nameLab.text = goodsModel.goodsName;
    }else{
        goodsModel = (MKGoodsInfoModel *)model;
        numberStr = goodsModel.number;
        priceStr = goodsModel.price;
        unitStr = goodsModel.unit;
        nameLab.text = goodsModel.goodsName;
    }
    if (goodsModel.imgUrl) {

        NSString *urlStr;

        urlStr = [goodsModel.imgUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
//        NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
//        
//        NSArray *parts = [goodsModel.imgUrl componentsSeparatedByCharactersInSet:whitespaces];
//        NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
//        urlStr = [filteredArray componentsJoinedByString:@""];
        
        //LxDBAnyVar(urlStr);
        
        //NSURL *url = [[NSURL alloc] initWithString:@"http://ouaqk5p3u.bkt.clouddn.com/2017-09-14-09:46:50-nkqqftslocamz.png?imageView2/1/w/100/h/100"];
        NSURL *url = [[NSURL alloc] initWithString:urlStr];
        [goodsPic sd_setImageWithURL:url];
        
    }
    if (!_type) {       //添加商品
        numLab.text = [NSString stringWithFormat:@"库存(%@): %@",unitStr,numberStr];
        priceLab.text = [NSString stringWithFormat:@"单价(元): ¥%@",priceStr];
    }else if(_type == 1) {      //订单
        NSString *resultStr = [NSString stringWithFormat:@"¥ %@ x%@",priceStr,numberStr];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:resultStr];
        [attr addAttribute:NSFontAttributeName
                     value:FONT(14)
                     range:NSMakeRange(0, priceStr.length + 2)];
        [attr addAttribute:NSForegroundColorAttributeName
                     value:[UIColor hexStringToColor:@"#1E1E1E"]
                     range:NSMakeRange(0, priceStr.length + 2)];
        [attr addAttribute:NSForegroundColorAttributeName
                     value:[UIColor hexStringToColor:@"#7B7B7B"]
                     range:NSMakeRange(2 + priceStr.length, numberStr.length + 2)];
        [attr addAttribute:NSFontAttributeName
                     value:FONT(12)
                     range:NSMakeRange(2 + priceStr.length, numberStr.length + 2)];
        priceLab.attributedText = attr;
    }else {     //商品管理
        numLab.text = [NSString stringWithFormat:@"库存(%@): %@",unitStr,numberStr];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单价(元): ¥%@",priceStr]];
        [attr addAttribute:NSFontAttributeName
                     value:FONT(12)
                     range:NSMakeRange(0, attr.length)];
        [attr addAttribute:NSForegroundColorAttributeName
                     value:[UIColor hexStringToColor:@"#7B7B7B"]
                     range:NSMakeRange(0, 6)];
        [attr addAttribute:NSForegroundColorAttributeName
                     value:[UIColor hexStringToColor:@"#C98993"]
                     range:NSMakeRange(7, priceStr.length + 1)];
        priceLab.attributedText = attr;
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
