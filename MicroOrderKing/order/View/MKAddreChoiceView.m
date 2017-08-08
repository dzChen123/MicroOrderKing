//
//  MKAddreChoiceView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/5.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAddreChoiceView.h"

#import "MKAddreMatchModel.h"

#define word89Color [UIColor hexStringToColor:@"#898989"]

@implementation MKAddreChoiceView
{
    UILabel *titleLab;
    UIButton *closeButn;
    UIScrollView *srcollerView;
    UIView *containView;
    UIButton *cancelbutn;
    UIButton *confirmButn;
    
    NSMutableArray *addreViewArra;
    NSInteger selectIndex;
    MKAddreMatchModel *dataModel;
}

- (void)CreatView {
    titleLab = [[UILabel alloc] init];
    closeButn = [[UIButton alloc] init];
    srcollerView = [[UIScrollView alloc] init];
    containView = [[UIView alloc] init];
    cancelbutn = [[UIButton alloc] init];
    confirmButn = [[UIButton alloc] init];
    
    [self addSubview:titleLab];
    [self addSubview:closeButn];
    [self addSubview:srcollerView];
    [srcollerView addSubview:containView];
    [self addSubview:cancelbutn];
    [self addSubview:confirmButn];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    addreViewArra = [[NSMutableArray alloc] init];
    self.backgroundColor = customWhite;
    self.layer.cornerRadius = 6.0;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    
    titleLab.text = @"选择地址";
    titleLab.textColor = [UIColor hexStringToColor:@"#191919"];
    titleLab.font = FONTBOLD(16);
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws);
        make.top.mas_equalTo(ws).offset(15 * autoSizeScaleH);
    }];
    
    [closeButn setImage:[[UIImage imageNamed:@"enorderOppClose"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)] forState:UIControlStateNormal];
    [closeButn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [closeButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.top.mas_equalTo(titleLab);
    }];
    
    srcollerView.bounces = NO;
    [srcollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(srcollerView);
        make.width.mas_equalTo(srcollerView);
    }];
    
    cancelbutn.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
    [cancelbutn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbutn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelbutn setTitleColor:[UIColor hexStringToColor:@"#989898"] forState:UIControlStateNormal];
    cancelbutn.titleLabel.font = FONT(14);
    [cancelbutn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws);
        make.top.mas_equalTo(srcollerView.mas_bottom);
        make.width.mas_equalTo(ws).multipliedBy(.5);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    confirmButn.backgroundColor = themeGreen;
    [confirmButn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmButn setTitleColor:customWhite forState:UIControlStateNormal];
    confirmButn.titleLabel.font = FONT(14);
    [confirmButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws);
        make.size.centerY.mas_equalTo(cancelbutn);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(cancelbutn);
    }];
    
}

- (void)setData:(id)model{
    selectIndex = 0;
    dataModel = (MKAddreMatchModel *)model;
    MKAddreItemView *lastView;
    for (int index = 0;index < dataModel.address.count;index ++) {
        MKAddreMatchItemModel *item = dataModel.address[index];
        MKAddreItemView *itemView = [[MKAddreItemView alloc] init];
        [addreViewArra addObject:item];
        [itemView setData:item WithUserName:dataModel.name Phone:dataModel.mobile];
        [containView addSubview:itemView];
        if (!index) {
            [itemView setSelected:YES];
        }
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(containView);
            if (!index) {
                make.top.mas_equalTo(containView);
            }else{
                make.top.mas_equalTo(lastView.mas_bottom);
            }
        }];
        lastView = itemView;
    }
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lastView);
    }];
    [srcollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (dataModel.address.count < 4) {
            make.height.equalTo(containView.mas_height);
            //make.bottom.mas_equalTo(containView);
        }else{
            make.height.mas_equalTo(300 * autoSizeScaleH);
        }
    }];
    
}

- (void)checkButnClickBlock:(UIButton *)sender {
    selectIndex = [addreViewArra indexOfObject:sender.superview];
    for (int index = 0; index < addreViewArra.count; index ++) {
        MKAddreItemView *itemView = addreViewArra[index];
        [itemView setSelected:index == selectIndex ? YES : NO];
    }
}

- (void)cancelClick {
    if (_cancelClickBock) {
        _cancelClickBock();
    }
}

- (void)confirmClick {
    if (_confirmClickBock) {
        _confirmClickBock(dataModel,selectIndex);
    }
}


@end

@implementation MKAddreItemView
{
    UILabel *nameLab;
    UILabel *phoneLab;
    UILabel *addreLab;
    UIButton *checkButn;
    UIView *lineView;
    
}

- (void)CreatView {
    nameLab = [[UILabel alloc] init];
    phoneLab = [[UILabel alloc] init];
    addreLab = [[UILabel alloc] init];
    checkButn = [[UIButton alloc] init];
    lineView = [[UIView alloc] init];
    
    [self addSubview:nameLab];
    [self addSubview:phoneLab];
    [self addSubview:addreLab];
    [self addSubview:checkButn];
    [self addSubview:lineView];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    _isSelected = NO;
    self.backgroundColor = customWhite;
    
    nameLab.textColor = word89Color;
    nameLab.font = FONT(14);
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.top.mas_equalTo(ws).offset(15 * autoSizeScaleH);
    }];
    
    phoneLab.textColor = word89Color;
    phoneLab.font = FONT(14);
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws).offset(-50 * autoSizeScaleH);
        make.centerY.mas_equalTo(nameLab);
    }];
    
    addreLab.numberOfLines = 0;
    addreLab.font = FONT(14);
    addreLab.textColor = word89Color;
    [addreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.right.lessThanOrEqualTo(ws).offset(-50 * autoSizeScaleW);
        make.top.mas_equalTo(nameLab.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.top.mas_equalTo(addreLab.mas_bottom).offset(15 * autoSizeScaleH);
        make.height.mas_equalTo(1);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lineView);
    }];
    
    [checkButn setImage:[[UIImage imageNamed:@"moreAdresNodef"] imageByScalingToSize:CGSizeMake(20 * autoSizeScaleW, 20 * autoSizeScaleW)] forState:UIControlStateNormal];
    [checkButn addTarget:self action:@selector(checkButnClick) forControlEvents:UIControlEventTouchUpInside];
    [checkButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(ws);
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.width.height.mas_equalTo(20 * autoSizeScaleW);
    }];
}

- (void)checkButnClick{
    _isSelected = !_isSelected;
    [checkButn setImage:[[UIImage imageNamed:_isSelected ? @"moreAdresDef" : @"moreAdresNodef"] imageByScalingToSize:CGSizeMake(20 * autoSizeScaleW, 20 * autoSizeScaleW)] forState:UIControlStateNormal];
    if (_checkClickBlock) {
        _checkClickBlock();
    }
}

- (void)setSelected:(BOOL)selected {
    _isSelected = selected;
    [checkButn setImage:[[UIImage imageNamed:_isSelected ? @"moreAdresDef" : @"moreAdresNodef"] imageByScalingToSize:CGSizeMake(20 * autoSizeScaleW, 20 * autoSizeScaleW)] forState:UIControlStateNormal];
}

- (void)setData:(id)model WithUserName:(NSString *)name Phone:(NSString *)phone {
    MKAddreMatchItemModel *dataModel = (MKAddreMatchItemModel *)model;
    nameLab.text = name;
    phoneLab.text = phone;
    addreLab.text = dataModel.address;
}


@end
