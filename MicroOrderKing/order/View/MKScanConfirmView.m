//
//  MKScanConfirmView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/9/4.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKScanConfirmView.h"

@implementation MKScanConfirmView
{
    MKPrintTypeView *deliverItem;
    MKPrintTypeView *electricItem;
    UIButton *cancelButn;
    UIButton *confirmButn;
}

- (void)CreatView {
    
    deliverItem = [[MKPrintTypeView alloc] initWithTitle:@"快递单打印"];
    electricItem = [[MKPrintTypeView alloc] initWithTitle:@"电子面单打印"];
    cancelButn = [[UIButton alloc] init];
    confirmButn = [[UIButton alloc] init];
    
    [self addSubview:deliverItem];
    [self addSubview:electricItem];
    [self addSubview:cancelButn];
    [self addSubview:confirmButn];
    
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    self.type = 2;  //2  快递单打印   1  电子
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 6.0;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor hexStringToColor:@"#F3F4F6"];
    
    deliverItem.isSelected = YES;
    deliverItem.hideLineView = NO;
    deliverItem.tag = 30;
    deliverItem.typeButnClickBlock =^(MKPrintTypeView *view){
        [ws typeClickBlock:view];
    };
    [deliverItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws);
    }];
    
    electricItem.isSelected = NO;
    electricItem.hideLineView = YES;
    electricItem.tag = 31;
    electricItem.typeButnClickBlock =^(MKPrintTypeView *view){
        [ws typeClickBlock:view];
    };
    [electricItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws);
        make.top.mas_equalTo(deliverItem.mas_bottom);
    }];
    
    cancelButn.backgroundColor = [UIColor clearColor];
    [cancelButn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelButn setTitleColor:wordSixColor forState:UIControlStateNormal];
    cancelButn.titleLabel.font = FONT(14);
    [cancelButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws);
        make.top.mas_equalTo(electricItem.mas_bottom);
        make.width.mas_equalTo(ws).multipliedBy(.5);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    confirmButn.backgroundColor = themeGreen;
    [confirmButn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmButn setTitleColor:customWhite forState:UIControlStateNormal];
    confirmButn.titleLabel.font = FONT(14);
    [confirmButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws);
        make.size.centerY.mas_equalTo(cancelButn);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(cancelButn);
    }];
    
    [super SettingViewAttributes];
}

- (void)cancelClick {
    if (_cancelBlock) {
        _cancelBlock();
    }
}

- (void)confirmClick {
    if (_confirmBlock) {
        _confirmBlock();
    }
}

- (void)typeClickBlock:(MKPrintTypeView *)sender {
    
    if (!electricItem.isSelected && !deliverItem.isSelected) {
        _type = 0;
    }else{
        if (sender.tag == 30) {
            _type = 2;
            electricItem.isSelected = NO;
        } else {
            _type = 1;
            deliverItem.isSelected = NO;
        }
    }
    
}

@end

@implementation MKPrintTypeView
{
    UILabel *titleLab;
    UIButton *clickButn;
    UIImageView *checkView;
    UIView *lineView;
    
    NSString *_title;
}

- (instancetype)initWithTitle:(NSString *)title {
    
    _title = title;
    self = [super init];
    return self;
    
}

- (void)CreatView {

    titleLab = [[UILabel alloc] init];
    checkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"enorderNote2"]];
    lineView = [[UIView alloc] init];
    clickButn = [[UIButton alloc] init];
    
    [self addSubview:titleLab];
    [self addSubview:checkView];
    [self addSubview:lineView];
    [self addSubview:clickButn];
    
}

- (void)SettingViewAttributes {

    WS(ws)
    
    self.backgroundColor = customWhite;

    titleLab.text = _title;
    titleLab.font = FONT(14);
    titleLab.textColor = wordThreeColor;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.centerY.mas_equalTo(ws);
    }];
    
    [checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws).offset(-20 * autoSizeScaleW);
        make.centerY.mas_equalTo(ws);
        make.width.height.mas_equalTo(18 * autoSizeScaleW);
    }];
    
    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(ws);
        make.height.mas_equalTo(1);
    }];
    
    [clickButn addTarget:self action:@selector(butnClick) forControlEvents:UIControlEventTouchUpInside];
    [clickButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(ws);
        make.center.mas_equalTo(ws);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60 * autoSizeScaleH);
    }];
    
}

- (void)setHideLineView:(BOOL)hideLineView {

    lineView.hidden = hideLineView;
    _hideLineView = hideLineView;
}

- (void)setIsSelected:(BOOL)isSelected {
    
    checkView.hidden = !isSelected;
    _isSelected = isSelected;
}

- (void)butnClick {
    
    self.isSelected = !self.isSelected;
    if (_typeButnClickBlock) {
        _typeButnClickBlock(self);
    }
    
}

@end
