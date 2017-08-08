//
//  MKSectionView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/27.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKOrderManageController.h"
#import "MKAccountManageController.h"
#import "MKOrderWritingController.h"
#import "MKMemberManageController.h"
#import "MKGoodsManageController.h"
#import "MKAddAccountController.h"

#import "MKAddMemberController.h"
#import "MKEditAddreController.h"
#import "MKAddreManageController.h"
#import "MKEditMemberController.h"

#import "MKSectionView.h"

@implementation MKSectionView
{
    NSMutableArray *itemArra;
}

- (instancetype)init {
    if (self == [super init]) {
        [self setData];
    }
    return self;
}

- (void)setData{
    NSMutableArray *dataArra = [[NSMutableArray alloc] initWithObjects: @[@"homeEntryOrder",@"录入订单"],
                                                                        @[@"homeOrderManage",@"订单管理"],
                                                                        @[@"homeEnterMenber",@"录入会员"],
                                                                        @[@"homeMember",@"会员管理"],
                                                                        @[@"homeCManage",@"商品管理"],
                                                                        @[@"homeSubAccount",@"子账户管理"],nil];
    for (int i = 0; i < dataArra.count; i ++) {
        [((MKSectionItemView *)itemArra[i]) setData:dataArra[i]];
    }
}


- (void)CreatView {
    itemArra = [[NSMutableArray alloc] init];

    for (int i = 0; i < 6; i ++) {
        MKSectionItemView *item = [[MKSectionItemView alloc] init];
        item.tag = 11 + i;
        [self addSubview:item];
        [item addTapEventWith:self action:@selector(sectionItemClick:)];
        [itemArra addObject:item];
    }

}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    [itemArra[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(ws);
        make.width.mas_equalTo(ws).multipliedBy(.5);
    }];
    
    [itemArra[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerY.mas_equalTo(itemArra[0]);
        make.right.mas_equalTo(ws);
    }];
    
    [itemArra[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(itemArra[0]);
        make.top.mas_equalTo(((MKSectionItemView *)itemArra[0]).mas_bottom);
    }];
    
    [itemArra[3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerY.mas_equalTo(itemArra[2]);
        make.right.mas_equalTo(ws);
    }];
    
    [itemArra[4] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.mas_equalTo(itemArra[0]);
        make.top.mas_equalTo(((MKSectionItemView *)itemArra[2]).mas_bottom);
    }];
    
    [itemArra[5] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerY.mas_equalTo(itemArra[4]);
        make.right.mas_equalTo(ws);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(itemArra[5]);
    }];
}

- (void)sectionItemClick:(UITapGestureRecognizer *)recognizer {
    UIViewController *parent = [self parentController];
    UIViewController *pushedController;
    switch (recognizer.view.tag) {
        case 11:
            pushedController = [[MKOrderWritingController alloc] initWithType:0];
            break;
        case 12:
            pushedController = [[MKOrderManageController alloc] initWithTitle:@"商品管理"];
            ((MKOrderManageController *)pushedController).currentIndex = 0;
            break;
        case 13:
            pushedController = [[MKAddMemberController alloc] initWithTitle:@"录入会员"];
            break;
        case 14:
            pushedController = [[MKMemberManageController alloc] initWithTitle:@"会员管理"];
            break;
        case 15:
            pushedController = [[MKGoodsManageController alloc] initWithTitle:@"商品管理"];
            break;
        case 16:
            pushedController = [[MKAccountManageController alloc] initWithTitle:@"子账户管理"];
            break;
            
        default:
            break;
    }
    [parent.navigationController pushViewController:pushedController animated:YES];
}

@end


@implementation MKSectionItemView
{
    UIImageView *sectionIcon;
    UILabel *sectionName;
}


- (void)CreatView {
    sectionIcon = [[UIImageView alloc] init];
    sectionName = [[UILabel alloc] init];
    
    [self addSubview:sectionIcon];
    [self addSubview:sectionName];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    self.backgroundColor = customWhite;
    
    [sectionIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws).offset(20 * autoSizeScaleH);
        make.centerX.mas_equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(63 * autoSizeScaleW, 38 * autoSizeScaleW));
    }];
    
    sectionName.textColor = [UIColor hexStringToColor:@"#222222"];
    sectionName.font = FONT(12);
    [sectionName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sectionIcon.mas_bottom).offset(10 * autoSizeScaleH);
        make.centerX.mas_equalTo(sectionIcon);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(sectionName).offset(15 * autoSizeScaleH);
    }];
    
}

- (void)setData:(NSArray *)dataArra {
    sectionIcon.image = [UIImage imageNamed:dataArra[0]];
    sectionName.text = dataArra[1];
}

@end
