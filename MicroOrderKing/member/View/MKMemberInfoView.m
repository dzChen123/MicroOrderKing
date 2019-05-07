//
//  MKMemberInfoView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/30.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKMemberInfoView.h"

#import "MKMemberBaseModel.h"

@implementation MKMemberInfoView
{
    UIImageView *avatarIcon;
    UIImageView *phoneIcon;
    UIImageView *locationIcon;
    UILabel *namelLab;
    UILabel *belongLab;
    UILabel *phoneLab;
    MKMemberAddreView *addreView;
    UILabel *markTittle;
    UILabel *markLab;
    UIView *grayView2;

}

- (void)CreatView {
    avatarIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mberManDetName"]];
    phoneIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mberManDetNum"]];
    locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mberManDetShipAdre"]];
    namelLab = [[UILabel alloc] init];
    belongLab = [[UILabel alloc] init];
    phoneLab = [[UILabel alloc] init];
    markTittle = [[UILabel alloc] init];
    markLab = [[UILabel alloc] init];
    addreView = [[MKMemberAddreView alloc] init];
    grayView2 = [[UIView alloc] init];
    
    [self addSubview:grayView2];
    [self addSubview:avatarIcon];
    [self addSubview:phoneIcon];
    [self addSubview:locationIcon];
    [self addSubview:namelLab];
    [self addSubview:belongLab];
    [self addSubview:phoneLab];
    [self addSubview:markTittle];
    [self addSubview:markLab];
    [self addSubview:addreView];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    self.backgroundColor = customWhite;
    
    [avatarIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.top.mas_equalTo(ws).offset(30 * autoSizeScaleH);
        make.width.height.mas_equalTo(15 * autoSizeScaleW);
    }];
    
    namelLab.font = FONT(15);
    namelLab.textColor = [UIColor blackColor];
    [namelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(avatarIcon);
        make.left.mas_equalTo(avatarIcon.mas_right).offset(20 * autoSizeScaleW);
    }];
    
    belongLab.font = FONT(12);
    belongLab.textColor = customWhite;
    belongLab.backgroundColor = [UIColor hexStringToColor:@"#71ADFB"];
    belongLab.layer.cornerRadius = 3.0;
    belongLab.layer.masksToBounds = YES;
    [belongLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(namelLab.mas_right).offset(10 * autoSizeScaleW);
        make.centerY.mas_equalTo(namelLab);
        make.height.mas_equalTo(18 * autoSizeScaleH);
    }];
    
    [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(avatarIcon);
        make.top.mas_equalTo(avatarIcon.mas_bottom).offset(25 * autoSizeScaleH);
        make.width.height.mas_equalTo(17 * autoSizeScaleW);
    }];
    
    phoneLab.font = FONT(14);
    phoneLab.layer.masksToBounds = YES;
    phoneLab.layer.cornerRadius = 3.0;
    phoneLab.textColor = [UIColor hexStringToColor:@"#414141"];
    phoneLab.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(namelLab);
        make.centerY.mas_equalTo(phoneIcon);
        make.height.mas_equalTo(25 * autoSizeScaleH);
    }];
    
    [locationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(avatarIcon);
        make.top.mas_equalTo(phoneIcon.mas_bottom).offset(35 * autoSizeScaleH);
    }];
    
    [addreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLab);
        make.right.mas_equalTo(ws);
        make.top.mas_equalTo(phoneLab.mas_bottom).offset(20 * autoSizeScaleH);
    }];
    
    markTittle.text = @"备注";
    markTittle.font = FONT(13);
    markTittle.textColor = [UIColor hexStringToColor:@"#717171"];
    [markTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(locationIcon);
        make.top.mas_equalTo(addreView.mas_bottom).offset(30 * autoSizeScaleH);
    }];
    
    markLab.numberOfLines = 0;
    markLab.font = FONT(14);
    markLab.textColor = [UIColor hexStringToColor:@"#414141"];
    [markLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(markTittle);
        make.left.mas_equalTo(addreView).offset(10 * autoSizeScaleW);
        make.right.lessThanOrEqualTo(ws).offset(-45 * autoSizeScaleW);
    }];
    
    grayView2.layer.cornerRadius = 5.0;
    grayView2.layer.masksToBounds = YES;
    grayView2.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
    [grayView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addreView);
        make.right.mas_equalTo(markLab).offset(10 * autoSizeScaleW);
        make.top.mas_equalTo(markLab).offset(-10 * autoSizeScaleH);
        make.bottom.mas_equalTo(markLab).offset(10 * autoSizeScaleH);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(grayView2).offset(45 * autoSizeScaleH);
    }];
}

- (void)setData:(id)model {
    MKMemberDetailModel *dataModel = (MKMemberDetailModel *)model;
    namelLab.text = dataModel.name;
    belongLab.text = [NSString stringWithFormat:@" 会员归属:%@ ",dataModel.owner.ownerName];
    phoneLab.text = [NSString stringWithFormat:@" %@ ",dataModel.phoneNum];
    markLab.text = dataModel.remark;
    if (!dataModel.remark.length) {
        grayView2.hidden = YES;
    }
    [addreView setData:dataModel.address];
}

@end

@implementation MKMemberAddreView
{
    UIView *containView;
    UIButton *hideButn;
    
    BOOL isHidden;
    MASConstraint *selfBottomConstraint;
    MASConstraint *bottomConstraint;
    NSMutableArray *itemViewArra;
    MKMemAddreItemView *lastView,*firstView;
}

- (void)CreatView {
    containView = [[UIView alloc] init];
    hideButn = [[UIButton alloc] init];
    
    [self addSubview:containView];
    [self addSubview:hideButn];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    isHidden = YES;
    itemViewArra = [[NSMutableArray alloc] init];
    
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws);
    }];
    
    hideButn.hidden = YES;
    [hideButn setImage:[[UIImage imageNamed:@"mberManDetElongation"] imageByScalingToSize:CGSizeMake(17 * autoSizeScaleW, 17 * autoSizeScaleW)] forState:UIControlStateNormal];
    [hideButn addTarget:self action:@selector(hideButnClick) forControlEvents:UIControlEventTouchUpInside];
    [hideButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws).offset(-25 * autoSizeScaleW);
        make.top.mas_equalTo(containView.mas_bottom).offset(20 * autoSizeScaleH);
        make.width.height.mas_equalTo(17 * autoSizeScaleW);
    }];
}

- (void)setData:(NSMutableArray *)dataArr {
    
    WS(ws)
    NSInteger count = dataArr.count;
    for (UIView *subView in containView.subviews) {
        if ([subView isKindOfClass:[MKMemAddreItemView class]]) {
            [subView removeFromSuperview];
        }
    }
    if (!dataArr.count) {
        return;
    }
    hideButn.hidden = NO;
    if (selfBottomConstraint) {
        [selfBottomConstraint uninstall];
    }
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        selfBottomConstraint = count == 1 ? make.bottom.mas_equalTo(containView) : make.bottom.mas_equalTo(hideButn);
    }];
    NSInteger index = 0;
    
    [itemViewArra removeAllObjects];
    
    for (MKMemAddreModel *model in dataArr) {
        MKMemAddreItemView *itemView = [[MKMemAddreItemView alloc] init];
        [itemView setAddre:model.address];
        [containView addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(containView);
            if (!index) {
                make.top.mas_equalTo(containView);
            }else{
                make.top.mas_equalTo(lastView.mas_bottom).offset(10 * autoSizeScaleH);
            }
        }];
        [itemViewArra addObject:itemView];
        if (!index) {
            firstView = itemView;
        }else{
            itemView.alpha = 0;
            itemView.hidden = YES;
        }
        index ++;
        lastView = itemView;
    }
    if (count == 1) {
        hideButn.hidden = YES;
        hideButn.alpha = 0;
        //[hideButn removeFromSuperview];
    }else{
        hideButn.hidden = NO;
        hideButn.alpha = 1;
    }
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        bottomConstraint = make.bottom.mas_equalTo(firstView);
    }];
    
}

- (void)hideButnClick {
    isHidden = !isHidden;
    [hideButn setImage:[[UIImage imageNamed: isHidden ? @"mberManDetElongation" : @"mberManDetShrink"] imageByScalingToSize:CGSizeMake(17 * autoSizeScaleW, 17 * autoSizeScaleW)] forState:UIControlStateNormal];
    [bottomConstraint uninstall];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        bottomConstraint = isHidden ? make.bottom.mas_equalTo(firstView) : make.bottom.mas_equalTo(lastView);
    }];
    UIViewController *controller = [self parentController];
    if (isHidden) {        //隐藏
        [UIView animateWithDuration:.3 animations:^{
            for (int i = 0; i < itemViewArra.count; i ++) {
                if (i) { ((MKMemAddreItemView *)itemViewArra[i]).alpha = 0; }
            }
            [controller.view layoutIfNeeded];
        }completion:^(BOOL finished) {
            for (int i = 0; i < itemViewArra.count; i ++) {
                if (i) { ((MKMemAddreItemView *)itemViewArra[i]).hidden = YES; }
            }
            ((MKMemAddreItemView *)itemViewArra[0]).hidden = NO;
            ((MKMemAddreItemView *)itemViewArra[0]).alpha = 1;
        }];
    }else{          //显示
        for (MKMemAddreItemView *itemView in itemViewArra) {
            itemView.hidden = NO;
        }
        [UIView animateWithDuration:.3 animations:^{
            for (MKMemAddreItemView *itemView in itemViewArra) {
                itemView.alpha = 1;
            }
            [controller.view layoutIfNeeded];
        }];
    }
}

@end

@implementation MKMemAddreItemView
{
    UIView *grayView;
    UILabel *addreLab;
}

- (void)CreatView {
    
    grayView = [[UIView alloc] init];
    addreLab = [[UILabel alloc] init];
    
    [self addSubview:grayView];
    [self addSubview:addreLab];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    grayView.layer.cornerRadius = 5.0;
    grayView.layer.masksToBounds = YES;
    grayView.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(ws);
        make.right.mas_equalTo(addreLab).offset(10 * autoSizeScaleW);
        make.bottom.mas_equalTo(addreLab.mas_bottom).offset(10 * autoSizeScaleH);
    }];

    addreLab.numberOfLines = 0;
    addreLab.font = FONT(14);
    addreLab.textColor = [UIColor hexStringToColor:@"#414141"];
    [addreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(grayView).offset(10 * autoSizeScaleW);
        make.right.lessThanOrEqualTo(ws).offset(-45 * autoSizeScaleW);
        make.top.mas_equalTo(grayView).offset(10 * autoSizeScaleH);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(grayView);
    }];
}

- (void)setAddre:(NSString *)addre {
    addreLab.text = addre;
}


@end
