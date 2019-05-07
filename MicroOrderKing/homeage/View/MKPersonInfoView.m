//
//  MKPersonInfoView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/1.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKContactController.h"

#import "MKPersonInfoView.h"

#import "MKPersonModel.h"

@implementation MKPersonInfoView
{
    UIImageView *phoneIcon;
    UIImageView *avatarIcon;
    UILabel *phoneLab;
    UILabel *accountLab;
    UILabel *nameLab;
    UIView *lineView;
    UILabel *timeLab;
    UIButton *conditionButn;
}

- (void)CreatView {
    phoneIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personPhone"]];
    avatarIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personName"]];
    phoneLab = [[UILabel alloc] init];
    accountLab = [[UILabel alloc] init];
    nameLab = [[UILabel alloc] init];
    lineView = [[UIView alloc] init];
    timeLab = [[UILabel alloc] init];
    conditionButn = [[UIButton alloc] init];
    
    [self addSubview:phoneIcon];
    [self addSubview:avatarIcon];
    [self addSubview:phoneLab];
    [self addSubview:accountLab];
    [self addSubview:nameLab];
    [self addSubview:lineView];
    [self addSubview:timeLab];
    [self addSubview:conditionButn];
}

- (void)setBgColorAndRadius {
    self.backgroundColor = themeGreen;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 6.0;
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    [self setBgColorAndRadius];
    
    [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.top.mas_equalTo(ws).offset(25 * autoSizeScaleH);
        make.width.height.mas_equalTo(17 * autoSizeScaleW);
    }];
    
    phoneLab.textColor = customWhite;
    phoneLab.font = FONT(16);
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneIcon.mas_right).offset(5 * autoSizeScaleW);
        make.centerY.mas_equalTo(phoneIcon);
    }];
    
    accountLab.textColor = [UIColor hexStringToColor:@"#A1E0B7"];
    accountLab.text = @"账号";
    accountLab.font = FONT(12);
    accountLab.layer.masksToBounds = YES;
    accountLab.layer.cornerRadius = 3.0;
    accountLab.layer.borderColor = [UIColor hexStringToColor:@"#39B162"].CGColor;
    accountLab.layer.borderWidth = 1.0;
    accountLab.textAlignment = NSTextAlignmentCenter;
    [accountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLab.mas_right).offset(12 * autoSizeScaleW);
        make.centerY.mas_equalTo(phoneLab);
        make.size.mas_equalTo(CGSizeMake(42 * autoSizeScaleW, 17 * autoSizeScaleH));
    }];
    
    [avatarIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(phoneIcon);
        make.top.mas_equalTo(phoneIcon.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    nameLab.textColor = customWhite;
    nameLab.font = FONT(14);
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLab);
        make.centerY.mas_equalTo(avatarIcon);
    }];
    
    lineView.backgroundColor = [UIColor hexStringToColor:@"#39B162"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws);
        make.top.mas_equalTo(avatarIcon.mas_bottom).offset(15 * autoSizeScaleH);
        make.height.mas_equalTo(1);
    }];
    
    timeLab.textColor = customWhite;
    timeLab.font = FONT(14);
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneIcon);
        make.top.mas_equalTo(lineView).offset(15 * autoSizeScaleH);
    }];
    
    [conditionButn addTarget:self action:@selector(goToContact) forControlEvents:UIControlEventTouchUpInside];
    [conditionButn setTitleColor:[UIColor hexStringToColor:@"#A1E0B7"] forState:UIControlStateNormal];
    conditionButn.backgroundColor = [UIColor hexStringToColor:@"#39B162"];
    conditionButn.titleLabel.font = FONT(12);
    conditionButn.layer.masksToBounds = YES;
    conditionButn.layer.cornerRadius = 3.0;
    [conditionButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws);
        make.bottom.mas_equalTo(ws).offset(-10 * autoSizeScaleH);
        make.size.mas_equalTo(CGSizeMake(65 * autoSizeScaleW, 25 * autoSizeScaleH));
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(timeLab).offset(15 * autoSizeScaleH);
    }];
    
}

- (void)goToContact {
    UIViewController *parent = [self parentController];
    MKContactController *controller = [[MKContactController alloc] initWithTitle:@"联系客服"];
    [parent.navigationController pushViewController:controller animated:YES];
}

- (void)setData:(id)model {
    MKPersonModel *dataModel = (MKPersonModel *)model;
    phoneLab.text = dataModel.phoneNum;
    nameLab.text = dataModel.name;
    
    if ([self checkIsExpire:dataModel.timeStr]) {   //过期
        NSString *timeStr = dataModel.timeStr;
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"VIP已过期: %@",timeStr]];
        [attr addAttribute:NSForegroundColorAttributeName
                     value:[UIColor hexStringToColor:@"#A1E0B7"]
                     range:NSMakeRange(attr.length - timeStr.length, timeStr.length)];
        [attr addAttribute:NSStrikethroughStyleAttributeName
                     value:@(NSUnderlineStyleSingle)
                     range:NSMakeRange(attr.length - timeStr.length, timeStr.length)];
        timeLab.attributedText = attr;
        [conditionButn setTitle:@"重新开通" forState:UIControlStateNormal];
    }else{
        if (![dataModel.isTry integerValue]) {   //vip
            timeLab.text = [NSString stringWithFormat:@"VIP到期时间: %@",dataModel.timeStr];
            [conditionButn setTitle:@"续费 " forState:UIControlStateNormal];
            [conditionButn setImage:[[UIImage imageNamed:@"personNarrow"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)] forState:UIControlStateNormal];
            CGSize contentSize = [@"续费 " sizeWithAttributes:@{NSFontAttributeName: FONT(12)}];
            [conditionButn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15 * autoSizeScaleW, 0, 15 * autoSizeScaleW)];
            [conditionButn setImageEdgeInsets:UIEdgeInsetsMake(0, contentSize.width, 0, -contentSize.width)];
        } else {    //试用
            timeLab.text = [NSString stringWithFormat:@"试用到期时间: %@",dataModel.timeStr];
            [conditionButn setTitle:@"开通VIP" forState:UIControlStateNormal];
        }
    }

//    switch (dataModel.conditionType) {
//        case 0:     //使用VIP
//            timeLab.text = [NSString stringWithFormat:@"VIP到期时间: %@",dataModel.timeStr];
//            [conditionButn setTitle:@"续费 " forState:UIControlStateNormal];
//            [conditionButn setImage:[[UIImage imageNamed:@"personNarrow"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)] forState:UIControlStateNormal];
//            CGSize contentSize = [@"续费 " sizeWithAttributes:@{NSFontAttributeName: FONT(12)}];
//            [conditionButn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15 * autoSizeScaleW, 0, 15 * autoSizeScaleW)];
//            [conditionButn setImageEdgeInsets:UIEdgeInsetsMake(0, contentSize.width, 0, -contentSize.width)];
//            break;
//        case 1:     //VIP试用
//            timeLab.text = [NSString stringWithFormat:@"试用到期时间: %@",dataModel.timeStr];
//            [conditionButn setTitle:@"开通VIP" forState:UIControlStateNormal];
//            break;
//        case 2:
//        {
//            NSString *timeStr = dataModel.timeStr;
//            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"VIP已过期: %@",timeStr]];
//            [attr addAttribute:NSForegroundColorAttributeName
//                         value:[UIColor hexStringToColor:@"#A1E0B7"]
//                         range:NSMakeRange(attr.length - timeStr.length, timeStr.length)];
//            [attr addAttribute:NSStrikethroughStyleAttributeName
//                         value:@(NSUnderlineStyleSingle)
//                         range:NSMakeRange(attr.length - timeStr.length, timeStr.length)];
//            timeLab.attributedText = attr;
//            [conditionButn setTitle:@"重新开通" forState:UIControlStateNormal];
//
//        }
//            break;
//            
//        default:
//            break;
//    }
}

- (BOOL)checkIsExpire:(NSString *)dateStr {
    NSInteger expire = [[dateStr stringByReplacingOccurrencesOfString:@"-" withString:@""] integerValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *currentDate = [NSDate date];
    NSString *currentTime = [formatter stringFromDate:currentDate];
    NSInteger current = [[currentTime stringByReplacingOccurrencesOfString:@"-" withString:@""] integerValue];
    
    return current >= expire;
}


@end

@implementation MKChangePasdView
{
    UIImageView *iconView;
    UILabel *tittleLab;
    UIImageView *arrow;
    
    NSString *iconName;
    NSString *title;
}

- (instancetype)initWithTitle:(NSString *)titleStr AndImage:(NSString *)imageName {
    
    iconName = imageName;
    title = titleStr;
    
    self = [super init];
    
    return self;
    
}

- (void)CreatView {
    iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"subactArrow"]];
    tittleLab = [[UILabel alloc] init];

    [self addSubview:iconView];
    [self addSubview:arrow];
    [self addSubview:tittleLab];
}

- (void)SettingViewAttributes {

    WS(ws)
    
    self.backgroundColor = customWhite;
//    self.layer.cornerRadius = 5.0;
//    self.layer.masksToBounds = YES;
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.centerY.mas_equalTo(ws);
        make.width.height.mas_equalTo(15 * autoSizeScaleH);
    }];
    
    tittleLab.text = title;
    tittleLab.font = FONT(14);
    tittleLab.textColor = [UIColor hexStringToColor:@"#494949"];
    [tittleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(12 * autoSizeScaleW);
        make.centerY.mas_equalTo(ws);
    }];
    
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.centerY.mas_equalTo(ws);
        make.width.height.mas_equalTo(14 * autoSizeScaleW);
    }];
}


@end
