//
//  MKNewGoodsInfoView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//
#import "BaseViewController.h"

#import "MKNewGoodsInfoView.h"

#import "MKOrderCellModel.h"

#define holderColor [UIColor hexStringToColor:@"#DBDADB"]

@implementation MKNewGoodsInfoView
{
    UILabel *goodsTittle;
    UITextView *goodsName;
    UIView *lineview1;
    UILabel *priceTittle;
    UILabel *RMBLab;
    UITextField *priceField;
    UILabel *yuanLab;
    UIView *lineView2;
    UILabel *unitTittle;
    UITextField *unitField;
    UIView *lineView3;
    UILabel *stockTittle;
    UITextField *stockField;
    
    NSString *placeHolder;
    NSString *name;
}

- (void)CreatView {
    goodsTittle = [[UILabel alloc] init];
    goodsName = [[UITextView alloc] init];
    lineview1 = [[UIView alloc] init];
    priceTittle = [[UILabel alloc] init];
    RMBLab = [[UILabel alloc] init];
    priceField = [[UITextField alloc] init];
    yuanLab = [[UILabel alloc] init];
    lineView2 = [[UIView alloc] init];
    unitTittle = [[UILabel alloc] init];
    unitField = [[UITextField alloc] init];
    lineView3 = [[UIView alloc] init];
    stockTittle = [[UILabel alloc] init];
    stockField = [[UITextField alloc] init];
    
    [self addSubview:goodsTittle];
    [self addSubview:goodsName];
    [self addSubview:lineview1];
    [self addSubview:priceTittle];
    [self addSubview:RMBLab];
    [self addSubview:priceField];
    [self addSubview:yuanLab];
    [self addSubview:lineView2];
    [self addSubview:unitTittle];
    [self addSubview:unitField];
    [self addSubview:lineView3];
    [self addSubview:stockTittle];
    [self addSubview:stockField];
}

- (void)SettingViewAttributes {

    WS(ws)
    
    name = @"";
    self.backgroundColor = customWhite;
    
    goodsTittle.text = @"* 商品名称";
    goodsTittle.font = FONT(14);
    goodsTittle.textColor = [UIColor hexStringToColor:@"#979797"];
    [goodsTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.top.mas_equalTo(ws).offset(15 * autoSizeScaleH);
    }];
    
    placeHolder = @"请输入名称";
    goodsName.font = FONT(14);
    goodsName.textColor = holderColor;
    goodsName.text = placeHolder;
    goodsName.delegate = self;
    [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(90 * autoSizeScaleW);
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.top.mas_equalTo(goodsTittle).offset(-7 * autoSizeScaleH);
        make.height.mas_equalTo(50 * autoSizeScaleH);
    }];
    
    lineview1.backgroundColor = VIEWBACKGRAY;
    [lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(goodsName);
        make.right.mas_equalTo(ws);
        make.top.mas_equalTo(goodsName.mas_bottom).offset(20 * autoSizeScaleH);
        make.height.mas_equalTo(1);
    }];
    
    priceTittle.text = @"* 单价";
    priceTittle.font = FONT(14);
    priceTittle.textColor = [UIColor hexStringToColor:@"#979797"];
    [priceTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(goodsTittle);
        make.top.mas_equalTo(lineview1).offset(15 * autoSizeScaleH);
    }];
    
    RMBLab.text = @"¥";
    RMBLab.font = FONT(14);
    RMBLab.textColor = [UIColor hexStringToColor:@"#3B3B3B"];
    [RMBLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(goodsName);
        make.top.mas_equalTo(priceTittle);
    }];
    
    yuanLab.text = @"元";
    yuanLab.font = FONT(14);
    [yuanLab sizeToFit];
    yuanLab.textColor = [UIColor hexStringToColor:@"#3B3B3B"];
    [yuanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.top.mas_equalTo(RMBLab.mas_bottom).offset(25 * autoSizeScaleH);
        make.width.mas_equalTo(15 * autoSizeScaleW);
    }];
    
    priceField.textColor = [UIColor hexStringToColor:@"#35B067"];
    priceField.font = FONT(20);
    priceField.placeholder = @"请输入单价";
    priceField.delegate = self;
    priceField.tag = 100;
    [priceField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RMBLab);
        make.right.mas_equalTo(yuanLab.mas_left).offset(-10 * autoSizeScaleW);
        make.height.mas_equalTo(30 * autoSizeScaleH);
        make.bottom.mas_equalTo(yuanLab);
    }];
    
    lineView2.backgroundColor = VIEWBACKGRAY;
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.mas_equalTo(lineview1);
        make.top.mas_equalTo(yuanLab.mas_bottom).offset(15 * autoSizeScaleH);
    }];

    unitTittle.text = @"* 单位";
    unitTittle.font = FONT(14);
    unitTittle.textColor = [UIColor hexStringToColor:@"#979797"];
    [unitTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(priceTittle);
        make.top.mas_equalTo(lineView2).offset(20 * autoSizeScaleH);
    }];
    
    unitField.font = FONT(14);
    unitField.placeholder = @"商品单位（例：件、个、盒、箱）";
    unitField.textColor = [UIColor hexStringToColor:@"#3D3D3D"];
    [unitField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(goodsName);
        make.height.mas_equalTo(30 * autoSizeScaleH);
        make.centerY.mas_equalTo(unitTittle);
    }];

    lineView3.backgroundColor = VIEWBACKGRAY;
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.mas_equalTo(lineView2);
        make.top.mas_equalTo(unitField.mas_bottom).offset(15 * autoSizeScaleH);
    }];


    stockTittle.text = @"* 库存";
    stockTittle.font = FONT(14);
    stockTittle.textColor = [UIColor hexStringToColor:@"#979797"];
    [stockTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(unitTittle);
        make.top.mas_equalTo(lineView3).offset(20 * autoSizeScaleH);
    }];
    
    stockField.font = FONT(14);
    stockField.placeholder = @"请输入库存数量（例：1000）";
    stockField.delegate = self;
    stockField.tag = 200;
    stockField.textColor = [UIColor hexStringToColor:@"#3D3D3D"];
    [stockField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.mas_equalTo(unitField);
        make.centerY.mas_equalTo(stockTittle);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(stockField.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
}

- (void)setData:(id)model {
    MKGoodsInfoModel *data = (MKGoodsInfoModel *)model;
    
    name = data.goodsName;
    goodsName.text = data.goodsName;
    goodsName.textColor = wordThreeColor;
    
    priceField.text = data.price;
    unitField.text = data.unit;
    stockField.text = data.number;
}

- (NSArray *)getGoodsInfo {
    return @[name,priceField.text,unitField.text,stockField.text];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:placeHolder]) {
        textView.text = @"";
        textView.textColor = wordThreeColor;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(textView.text.length < 1) {
        textView.text = placeHolder;
        textView.textColor = holderColor;
    }
    else if (textView.text.length > 15) {
        textView.text = placeHolder;
        textView.textColor = holderColor;
        BaseViewController *controller = (BaseViewController *)[self parentController];
        [controller.hud showTipMessageAutoHide:@"商品名称长度不得大于15"];
    }
    else{
        name = textView.text;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string textField:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    BaseViewController *controller = (BaseViewController *)[self parentController];
    if (textField.tag == 100) {
        NSString *priceStr = textField.text;
        if ([self isPureInt:priceStr] == NO && [self isPureFloat:priceStr] == NO ) {
            textField.text = @"";
            [controller.hud showTipMessageAutoHide:@"请输入合法数字"];
        }
        NSArray *array = [priceStr componentsSeparatedByString:@"."];
        NSString *intPart = !array.count ? priceStr : array[0];
        if ([intPart integerValue] > 99999999) {
            textField.text = @"";
            [controller.hud showTipMessageAutoHide:@"目前允许单价不得大于100000000元"];
        }
    }
    else if (textField.tag == 200) {
        NSString *priceStr = textField.text;
        if (![self isPureInt:priceStr]) {
            textField.text = @"";
            [controller.hud showTipMessageAutoHide:@"库存只能输入整数"];
        }
        if ([priceStr integerValue] > 999999) {
            textField.text = @"";
            [controller.hud showTipMessageAutoHide:@"目前库存数量不得大于999999"];
        }
    }
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：

- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)validateNumber:(NSString*)number textField:(UITextField *)textField {
    BOOL res = YES;
    NSCharacterSet* tmpSet;
    if (textField.tag == 100) {
        tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    } else {
        tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

@end

@implementation MKGoodsPicView
{
    UIImageView *picView;
}

- (void)CreatView {
    
    picView = [[UIImageView alloc] init];
    
    [self addSubview:picView];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    self.backgroundColor = customWhite;
    
    picView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectGoodsPic)];
    [picView addGestureRecognizer:tap];
    [picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws);
        make.top.mas_equalTo(ws).offset(15 * autoSizeScaleH);
        make.width.height.mas_equalTo(100 * autoSizeScaleH);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(picView).offset(15 * autoSizeScaleH);
    }];
}

- (void)setImage:(UIImage *)image {
    picView.image = image;
}

- (void)setImageWithURL:(NSString *)url {
    [picView sd_setImageWithURL:[[NSURL alloc] initWithString:url]];
}

- (void)selectGoodsPic {
    if (_uploadEventBlock) {
        _uploadEventBlock();
    }
}


@end
