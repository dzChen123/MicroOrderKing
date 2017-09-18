//
//  MKOrderGoodsView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKOrderWritingController.h"
#import "MKOrderDetailController.h"
#import "MKScanViewController.h"

#import "MKOrderGoodsView.h"
#import "MKGoodsInfoView.h"
#import "MKConfirmView.h"
#import "MKScanConfirmView.h"

#import "MKOrderCellModel.h"

#define grayColor69 [UIColor hexStringToColor:@"#696969"]

@implementation MKOrderGoodsView
{
    UIView *goodsContainerView;
    UILabel *totalLab;
    UIView *grayView;
    
    NSString *orderId;
    MASConstraint *bottomConstraint;
}

- (void)CreatView {
    goodsContainerView = [[UIView alloc] init];
    totalLab = [[UILabel alloc] init];
    grayView = [[UIView alloc] init];
    
    [self addSubview:goodsContainerView];
    [self addSubview:totalLab];
    [self addSubview:grayView];

}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    self.backgroundColor = customWhite;
    
    [goodsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws).offset(15 * autoSizeScaleH);
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.right.mas_equalTo(ws).offset(rightPadding);
    }];
    
    [totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(goodsContainerView);
        make.top.mas_equalTo(goodsContainerView.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    grayView.backgroundColor = VIEWBACKGRAY;
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws);
        make.top.mas_equalTo(totalLab.mas_bottom).offset(15 * autoSizeScaleH);
        make.height.mas_equalTo(15 * autoSizeScaleH);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(grayView);
    }];
}

- (void)setData:(id)model {
    MKOrderDetailModel *dataModel = (MKOrderDetailModel *)model;
    orderId = dataModel.orderId;
    NSInteger totalCount = 0;
    for (MKOrderGoodsModel *item in dataModel.goodsInfoArra) {
        totalCount += [item.payNumber integerValue];
    }
    NSString *resultStr = [NSString stringWithFormat:@"共%@件商品 合计(元):¥ %@",[NSString stringWithFormat:@"%ld",totalCount],dataModel.totalCost];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:resultStr];
    [attr addAttribute:NSFontAttributeName
                 value:FONT(12)
                 range:NSMakeRange(0, resultStr.length - dataModel.totalCost.length)];
    [attr addAttribute:NSForegroundColorAttributeName
                 value:grayColor69
                 range:NSMakeRange(0, resultStr.length - dataModel.totalCost.length)];
    [attr addAttribute:NSFontAttributeName
                 value:FONT(18)
                 range:NSMakeRange(resultStr.length - dataModel.totalCost.length, dataModel.totalCost.length)];
    [attr addAttribute:NSForegroundColorAttributeName
                 value:[UIColor hexStringToColor:@"#D28382"]
                 range:NSMakeRange(resultStr.length - dataModel.totalCost.length, dataModel.totalCost.length)];
    
    totalLab.attributedText = attr;
    
    [self loadGoodsViewsWithData:dataModel.goodsInfoArra];
}

- (void)loadGoodsViewsWithData:(NSMutableArray *)dataArra {
    MKGoodsInfoView *lastView;
    for (UIView *view in goodsContainerView.subviews) {
        if ([view isKindOfClass:[MKGoodsInfoView class]]) {
            [view removeFromSuperview];
        }
    }
    for (int index = 0; index < dataArra.count; index ++) {
        MKGoodsInfoModel *model = dataArra[index];
        MKGoodsInfoView *infoView = [[MKGoodsInfoView alloc] initWithType:1];
        [infoView setDataWithModel:model];
        [goodsContainerView addSubview:infoView];
        infoView.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
        [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!index) {
                make.top.mas_equalTo(goodsContainerView);
            }else{
                make.top.mas_equalTo(lastView.mas_bottom).offset(10 * autoSizeScaleH);
            }
            make.left.right.mas_equalTo(goodsContainerView);
        }];
        lastView = infoView;
    }
    if (bottomConstraint) {
        [bottomConstraint uninstall];
    }
    [goodsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        bottomConstraint = make.bottom.mas_equalTo(lastView);
    }];
    
    UIViewController *parent = [self parentController];
    [parent.view layoutIfNeeded];
    
}



@end

@implementation MKOrderBottomView
{
    UIButton *editButn;
    UIButton *confirmButn;
    UIButton *deleteButn;
    UIButton *printButn;
    
    UIView *maskView;
    MKConfirmView *confirmView;
    MKScanConfirmView *scanConfirmView;
    NSString *orderId;
    NSString *senderTittle;
}

- (void)CreatView {
    editButn = [[UIButton alloc] init];
    confirmButn = [[UIButton alloc] init];
    deleteButn = [[UIButton alloc] init];
    printButn = [[UIButton alloc] init];
    
    [self addSubview:editButn];
    [self addSubview:confirmButn];
    [self addSubview:deleteButn];
    [self addSubview:printButn];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    self.backgroundColor = customWhite;
    
    [printButn setTitle:@"打印订单" forState:UIControlStateNormal];
    [printButn setTitleColor:grayColor69 forState:UIControlStateNormal];
    [printButn addTarget:self action:@selector(goToScan) forControlEvents:UIControlEventTouchUpInside];
    printButn.titleLabel.font = FONT(14);
    printButn.layer.borderColor = [UIColor hexStringToColor:@"#F0F0F0"].CGColor;
    printButn.layer.borderWidth = 1.0;
    printButn.layer.masksToBounds = YES;
    printButn.layer.cornerRadius = 5.0;
    [printButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws).offset(-10 * autoSizeScaleW);
        make.centerY.mas_equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(75 * autoSizeScaleW, 30 * autoSizeScaleH));
    }];
    
    [confirmButn setTitle:@"确认发货" forState:UIControlStateNormal];
    [confirmButn setTitleColor:grayColor69 forState:UIControlStateNormal];
    [confirmButn addTarget:self action:@selector(goToConfirm:) forControlEvents:UIControlEventTouchUpInside];
    confirmButn.titleLabel.font = FONT(14);
    confirmButn.layer.borderColor = [UIColor hexStringToColor:@"#F0F0F0"].CGColor;
    confirmButn.layer.borderWidth = 1.0;
    confirmButn.layer.masksToBounds = YES;
    confirmButn.layer.cornerRadius = 5.0;
    [confirmButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(deleteButn.mas_left).offset(-10 * autoSizeScaleW);
        make.size.centerY.mas_equalTo(printButn);
    }];
    
    [editButn setTitle:@"编辑订单" forState:UIControlStateNormal];
    [editButn addTarget:self action:@selector(goToEdit) forControlEvents:UIControlEventTouchUpInside];
    [editButn setTitleColor:grayColor69 forState:UIControlStateNormal];
    editButn.titleLabel.font = FONT(14);
    editButn.layer.borderColor = [UIColor hexStringToColor:@"#F0F0F0"].CGColor;
    editButn.layer.borderWidth = 1.0;
    editButn.layer.masksToBounds = YES;
    editButn.layer.cornerRadius = 5.0;
    [editButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(confirmButn.mas_left).offset(-10 * autoSizeScaleW);
        make.size.centerY.mas_equalTo(confirmButn);
    }];
    
    [deleteButn setTitle:@"导出订单" forState:UIControlStateNormal];
    [deleteButn setTitleColor:grayColor69 forState:UIControlStateNormal];
    [deleteButn addTarget:self action:@selector(goToOutput) forControlEvents:UIControlEventTouchUpInside];
    deleteButn.titleLabel.font = FONT(14);
    deleteButn.layer.borderColor = [UIColor hexStringToColor:@"#F0F0F0"].CGColor;
    deleteButn.layer.borderWidth = 1.0;
    deleteButn.layer.masksToBounds = YES;
    deleteButn.layer.cornerRadius = 5.0;
    [deleteButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(printButn.mas_left).offset(-10 * autoSizeScaleW);
        make.size.centerY.mas_equalTo(confirmButn);
    }];
}

- (void)goToEdit {
    UIViewController *parent = [self parentController];
    MKOrderWritingController *controller = [[MKOrderWritingController alloc] initWithType:1];
    controller.orderId = orderId;
    [parent.navigationController pushViewController:controller animated:YES];
}

- (void)goToOutput {
    
    UIViewController *parent = [self parentController];
    
    MKScanViewController *controller = [[MKScanViewController alloc] initWithTitle:@"打码扫印"];
    controller.printStr = orderId;
    controller.printType = 10;
    [parent.navigationController pushViewController:controller animated:YES];
}

- (void)goToConfirm:(UIButton *)sender {
    UIViewController *parent = [self parentController];
    senderTittle = sender.titleLabel.text;
    NSArray *signArrays = @[
                            @[@"请确定您已准备好货物并准备发货",@"确认发货"],
                            @[@"是否确认发货",@"交易成功"],
                            @[@"请确定您要删除这笔订单",@"删除订单"]
                            ];
    maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    maskView.alpha = 0;
    [parent.view addSubview:maskView];
    [parent.view bringSubviewToFront:maskView];
    WS(ws)
    WeakObj(parent)
    [maskView addTapEventWith:self action:@selector(cancelConfirm)];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(parentWeak.view);
        make.center.mas_equalTo(parentWeak.view);
    }];
    confirmView = [[MKConfirmView alloc] init];
    if ([senderTittle isEqualToString:@"确认发货"]) {
         [confirmView setSignStr:signArrays[0]];
    }else if([senderTittle isEqualToString:@"删除订单"]){
         [confirmView setSignStr:signArrays[2]];
    }else{
         [confirmView setSignStr:signArrays[1]];
    }
    [parent.view addSubview:confirmView];
    confirmView.cancelBlock =^(){
        [ws cancelConfirm];
    };
    confirmView.confirmBlock =^(){
        [ws confirm];
    };
    confirmView.alpha = 0;
    confirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
    [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentWeak.view).offset(leftPadding);
        make.right.mas_equalTo(parentWeak.view).offset(rightPadding);
        make.centerY.mas_equalTo(parentWeak.view);
    }];
    [UIView animateWithDuration:.3 animations:^{
        maskView.alpha = 1;
        confirmView.alpha = 1;
        confirmView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)goToScan {

    UIViewController *parent = [self parentController];
    
    maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    maskView.alpha = 0;
    [parent.view addSubview:maskView];
    [parent.view bringSubviewToFront:maskView];
    WS(ws)
    WeakObj(parent)
    [maskView addTapEventWith:self action:@selector(cancelConfirm)];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(parentWeak.view);
        make.center.mas_equalTo(parentWeak.view);
    }];
    
    scanConfirmView = [[MKScanConfirmView alloc] init];
    [parent.view addSubview:scanConfirmView];
    [parent.view bringSubviewToFront:scanConfirmView];
    scanConfirmView.cancelBlock =^(){
        [ws cancelConfirm];
    };
    scanConfirmView.confirmBlock =^(){
        [ws scanConfirm];
    };
    scanConfirmView.alpha = 0;
    scanConfirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
    [scanConfirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentWeak.view).offset(leftPadding);
        make.right.mas_equalTo(parentWeak.view).offset(rightPadding);
        make.centerY.mas_equalTo(parentWeak.view);
    }];
    [UIView animateWithDuration:.3 animations:^{
        maskView.alpha = 1;
        scanConfirmView.alpha = 1;
        scanConfirmView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)cancelConfirm {
    
    [UIView animateWithDuration:.2 animations:^{
        maskView.alpha = 0;
        confirmView.alpha = 0;
        confirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
        scanConfirmView.alpha = 0;
        scanConfirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
    }completion:^(BOOL finished) {
        maskView.hidden = YES;
        confirmView.hidden = YES;
        [maskView removeFromSuperview];
        [confirmView removeFromSuperview];
        [scanConfirmView removeFromSuperview];
    }];
}

- (void)scanConfirm {

    BaseViewController *parent = (BaseViewController *)[self parentController];
    
    if (!scanConfirmView.type) {
        [parent.hud showTipMessageAutoHide:@"请先选择打印类型"];
        return;
    }
    
    [self cancelConfirm];
    
    MKScanViewController *controller = [[MKScanViewController alloc] initWithTitle:@"打码扫印"];
    controller.printStr = orderId;
    controller.printType = scanConfirmView.type;
    [parent.navigationController pushViewController:controller animated:YES];
    
}

- (void)confirm {
    BaseViewController *controller = (BaseViewController *)[self parentController];
    MKOrderDetailController *detailController;
    if ([controller isKindOfClass:[MKOrderDetailController class]]) {
        detailController = (MKOrderDetailController *)controller;
    }
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    if ([senderTittle isEqualToString:@"确认发货"]) {
        [plist setObject:@"1" forKey:@"post_status"];
    }else if([senderTittle isEqualToString:@"删除订单"]){
        [plist setObject:@"3" forKey:@"post_status"];
    }else{
        [plist setObject:@"2" forKey:@"post_status"];
    }
    [AFNetWorkingUsing httpPut:[NSString stringWithFormat:@"order/%@/change",orderId] params:plist success:^(id json) {
        if (detailController) {
            detailController.isUpdate = YES;
        }
        [controller.hud showTipMessageAutoHide:@"订单状态已更新"];
        if (detailController) {
            [detailController loadData];
        }
        if ([senderTittle isEqualToString:@"删除订单"]) {
            [controller.navigationController popViewControllerAnimated:YES];
        }
        [self cancelConfirm];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [controller.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)setData:(id)model {
    MKOrderDetailModel *dataModel = (MKOrderDetailModel *)model;
    
    orderId = dataModel.orderId;
    
    if ([dataModel.conditionType integerValue] == 1) {
        deleteButn.hidden = YES;
        editButn.hidden = YES;
        [confirmButn setTitle:@"交易完成" forState:UIControlStateNormal];
    }
}

@end
