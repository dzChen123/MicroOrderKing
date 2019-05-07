//
//  MKOrderManageCell.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/27.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKOrderManageController.h"
#import "MKOrderWritingController.h"
#import "MKPerformanceController.h"
#import "MKTradesDetailController.h"
#import "MKSearResultController.h"
#import "MKScanViewController.h"

#import "MKOrderManageCell.h"
#import "MKGoodsInfoView.h"
#import "MKConfirmView.h"
#import "MKScanConfirmView.h"

#import "MKOrderCellModel.h"

#define grayColor69 [UIColor hexStringToColor:@"#696969"]

@implementation MKOrderManageCell
{
    UIView *grayView;
    UIImageView *orderIDIcon;
    UILabel *orderID;
    UILabel *condition;
    UIView *goodsView;
    UIView *addressView;
    UIImageView *addreIcon;
    UILabel *addreLab;
    UIView *butnView;
    UIButton *printBtn;
    UIButton *editBtn;
    UIButton *confirmBtn;
    UIView *lineView;
    UILabel *sumLab;
    UIButton *clickButn;
    UIButton *printOrderButn;       // 这个才是打印订单
    UIImageView *carIcon;
    UILabel *methodLab;
    UILabel *dateLab;
    UIView *grayView2;
    
    UIView *maskView;
    MKConfirmView *confirmView;
    MKScanConfirmView *scanConfirmView;
    MASConstraint *bottomConstraint;
    NSString *orderId;
    BOOL isSelected;
}

- (void)createView {
    grayView = [[UIView alloc] init];
    orderIDIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"subactNo"]];
    orderID = [[UILabel alloc] init];
    condition = [[UILabel alloc] init];
    goodsView = [[UIView alloc] init];
    addressView = [[UIView alloc] init];
    addreIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mberManDetShipAdre"]];
    addreLab = [[UILabel alloc] init];
    butnView = [[UIView alloc] init];
    printBtn = [[UIButton alloc] init];
    editBtn = [[UIButton alloc] init];
    confirmBtn = [[UIButton alloc] init];
    lineView = [[UIView alloc] init];
    sumLab = [[UILabel alloc] init];
    clickButn = [[UIButton alloc] init];
    printOrderButn = [[UIButton alloc] init];
    carIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deliverMethod"]];
    methodLab = [[UILabel alloc] init];
    dateLab = [[UILabel alloc] init];
    grayView2 = [[UIView alloc] init];
    
    [self.contentView addSubview:grayView];
    [self.contentView addSubview:orderIDIcon];
    [self.contentView addSubview:orderID];
    [self.contentView addSubview:condition];
    [self.contentView addSubview:goodsView];
    [self.contentView addSubview:addressView];
    [addressView addSubview:addreIcon];
    [addressView addSubview:addreLab];
    [self.contentView addSubview:grayView2];
    [grayView2 addSubview:carIcon];
    [grayView2 addSubview:methodLab];
    [grayView2 addSubview:dateLab];
    [self.contentView addSubview:butnView];
    [butnView addSubview:printBtn];
    [butnView addSubview:editBtn];
    [butnView addSubview:confirmBtn];
    [butnView addSubview:printOrderButn];
    [self.contentView addSubview:lineView];
    [self.contentView addSubview:sumLab];
    [self.contentView addSubview:clickButn];
    
}

- (void)setttingViewAtuoLayout {
    
    WS(ws)
    
    self.contentView.backgroundColor = customWhite;
    
    grayView.backgroundColor = VIEWBACKGRAY;
    
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(15 * autoSizeScaleH);
    }];

    
    [orderIDIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.contentView).offset(leftPadding);
        make.top.mas_equalTo(grayView.mas_bottom).offset(15 * autoSizeScaleH);
        make.width.height.mas_equalTo(15 * autoSizeScaleW);
    }];
    
    if ([self.reuseIdentifier isEqualToString:@"orderConfirmCenter"] || [self.reuseIdentifier isEqualToString:@"orderDeliver"]) {
        orderIDIcon.hidden = YES;
        clickButn.hidden = NO;
        //clickButn.backgroundColor = [UIColor yellowColor];
        [clickButn setImage:[[UIImage imageNamed:@"moreAdresNodef"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)] forState:UIControlStateNormal];
        [clickButn addTarget:self action:@selector(clickButnClick) forControlEvents:UIControlEventTouchUpInside];
        [clickButn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(orderIDIcon);
            make.width.height.mas_equalTo(30 * autoSizeScaleW);
        }];
    }else{
        orderIDIcon.hidden = NO;
        clickButn.hidden = YES;
    }

    orderID.font = FONT(14);
    orderID.textColor = [UIColor hexStringToColor:@"#6F6F6F"];
    [orderID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderIDIcon.mas_right).offset(5 * autoSizeScaleW);
        make.centerY.mas_equalTo(orderIDIcon);
    }];
    
    condition.textColor = customWhite;
    condition.font = FONT(12);
    condition.layer.cornerRadius = 3.0;
    condition.layer.masksToBounds = YES;
    [condition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(orderIDIcon);
        make.height.mas_equalTo(18 * autoSizeScaleH);
        make.right.mas_equalTo(ws).offset(rightPadding);
    }];

    [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderIDIcon);
        make.right.mas_equalTo(condition);
        make.top.mas_equalTo(orderIDIcon.mas_bottom).offset(15 * autoSizeScaleH);
        //make.height.mas_equalTo(100);
    }];
    
    [carIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(grayView2).offset(leftPadding);
        make.top.mas_equalTo(grayView2).offset(10 * autoSizeScaleH);
        make.size.mas_equalTo(CGSizeMake(14 * autoSizeScaleW, 13 * autoSizeScaleW));
    }];
    
    methodLab.font = FONT(14);
    methodLab.textColor = grayColor69;
    [methodLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(carIcon.mas_right).offset(8 * autoSizeScaleW);
        make.centerY.mas_equalTo(carIcon);
    }];
    
    dateLab.font = FONT(14);
    dateLab.textColor = grayColor69;
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(grayView2).offset(-15 * autoSizeScaleW);
        make.centerY.mas_equalTo(grayView2);
    }];
    
    grayView2.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
    [grayView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.contentView).offset(leftPadding);
        make.right.mas_equalTo(ws.contentView).offset(rightPadding);
        make.bottom.mas_equalTo(carIcon).offset(10 * autoSizeScaleH);
    }];
    
    if([self.reuseIdentifier isEqualToString:@"orderHistory"]){
        
        [addressView removeFromSuperview];
        [butnView removeFromSuperview];
        [lineView removeFromSuperview];
        
        [grayView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(goodsView.mas_bottom).offset(10 * autoSizeScaleH);
        }];
        
        [sumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(grayView2.mas_bottom).offset(15 * autoSizeScaleH);
        }];
        
    }else{
        addressView.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
        [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ws.contentView).offset(leftPadding);
            make.right.mas_equalTo(ws.contentView).offset(rightPadding);
            make.top.mas_equalTo(goodsView.mas_bottom).offset(10 * autoSizeScaleH);
            make.bottom.mas_equalTo(addreLab.mas_bottom).offset(10 * autoSizeScaleH);
        }];
        
        [addreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(addressView).offset(leftPadding);
            make.top.mas_equalTo(addressView).offset(12 * autoSizeScaleH);
            make.width.height.mas_equalTo(15 * autoSizeScaleW);
        }];
        
        addreLab.font = FONT(14);
        addreLab.textColor = grayColor69;
        addreLab.numberOfLines = 0;
        [addreLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(addreIcon.mas_right).offset(5 * autoSizeScaleW);
            make.right.lessThanOrEqualTo(addressView).offset(-5 * autoSizeScaleW);
            make.top.mas_equalTo(addressView).offset(10 * autoSizeScaleH);
            //make.bottom.mas_equalTo(ws.contentView);
        }];
        
        [grayView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(addressView.mas_bottom).offset(10 * autoSizeScaleH);
        }];
        
        [butnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(addressView);
            make.top.mas_equalTo(grayView2.mas_bottom);
            make.bottom.mas_equalTo(confirmBtn).offset(10 * autoSizeScaleH);
        }];
        
        lineView.backgroundColor = VIEWBACKGRAY;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(ws.contentView);
            make.top.mas_equalTo(butnView.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        
        [sumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView.mas_bottom).offset(15 * autoSizeScaleH);
        }];
        
        NSString *confirmTittle;
        if ([self.reuseIdentifier isEqualToString:@"orderDeliver"]) {
            confirmTittle = @"确认发货";
            
            [self customButn:printOrderButn withTittle:@"打印订单"];
            [printOrderButn addTarget:self action:@selector(goToScanSuccess) forControlEvents:UIControlEventTouchUpInside];
            [printOrderButn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(butnView);
                make.top.mas_equalTo(butnView).offset(10 * autoSizeScaleH);
                make.size.mas_equalTo(CGSizeMake(70 * autoSizeScaleW, 25 * autoSizeScaleH));
            }];
            
            [confirmBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.centerY.mas_equalTo(printOrderButn);
                make.right.mas_equalTo(printBtn.mas_left).offset(-10 * autoSizeScaleW);
            }];
            
            [self customButn:editBtn withTittle:@"编辑订单"];
            [editBtn addTarget:self action:@selector(goToEdit) forControlEvents:UIControlEventTouchUpInside];
            [editBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.centerY.mas_equalTo(confirmBtn);
                make.right.mas_equalTo(confirmBtn.mas_left).offset(-10 * autoSizeScaleW);
            }];

            //[printBtn removeFromSuperview];
            [self customButn:printBtn withTittle:@"导出订单"];
            [printBtn addTarget:self action:@selector(goToOutput) forControlEvents:UIControlEventTouchUpInside];
            [printBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.centerY.mas_equalTo(editBtn);
                make.right.mas_equalTo(printOrderButn.mas_left).offset(-10 * autoSizeScaleW);
            }];
            
        } else {
            confirmTittle = @"交易完成";
            [confirmBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(butnView);
                make.top.mas_equalTo(butnView).offset(10 * autoSizeScaleH);
                make.size.mas_equalTo(CGSizeMake(70 * autoSizeScaleW, 25 * autoSizeScaleH));
            }];
            
            [printBtn removeFromSuperview];
            [editBtn removeFromSuperview];
            [printOrderButn removeFromSuperview];
            
        }
        
        [self customButn:confirmBtn withTittle:confirmTittle];
        [confirmBtn addTarget:self action:@selector(goToConfirm:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [sumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(goodsView);
        make.bottom.mas_equalTo(ws.contentView).offset(-15 * autoSizeScaleH);
    }];
    
}

- (void)setData:(id)model{
    MKOrderCellModel *cellModel = (MKOrderCellModel *)model;
    orderID.text = cellModel.orderSn;
    orderId = cellModel.orderId;
    if ([cellModel.conditionType integerValue] == 2) {
        condition.text = @" 已完成 ";
        condition.backgroundColor = [UIColor hexStringToColor:@"#37BF76"];
    } else {
        if (![cellModel.payStatus integerValue]) {
            condition.text = @" 未付款 ";
            condition.backgroundColor = [UIColor hexStringToColor:@"#FB737C"];
        }else{
            condition.text = @" 已付款 ";
            condition.backgroundColor = [UIColor hexStringToColor:@"#77AEFF"];
        }
    }

    NSString *method;
    switch ([cellModel.deliverMethod integerValue]) {
        case 0:
            method = @"同城配送";
            break;
        case 1:
            method = @"快递配送";
            break;
        case 2:
            method = @"商家自配送";
            break;
        default:
            method = @"用户自提";
            break;
    }
    methodLab.text = method;
    NSArray *array = [cellModel.createTime componentsSeparatedByString:@"-"];
    dateLab.text = [NSString stringWithFormat:@"%@年%@月%@日发货",array[0],array[1],array[2]];
    [self loadGoodsViewsWithData:cellModel.goodsInfoArra];
    
    if (![self.reuseIdentifier isEqualToString:@"orderHistory"]) {
        addreLab.text = cellModel.address;
        
        //LxDBAnyVar(addreLab.numberOfLines);
    }
    
    NSString *resultStr = [NSString stringWithFormat:@"共%@件商品 合计(元):¥ %@",cellModel.totalAmount,cellModel.totalCost];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:resultStr];
    [attr addAttribute:NSFontAttributeName
                 value:FONT(12)
                 range:NSMakeRange(0, resultStr.length - cellModel.totalCost.length)];
    [attr addAttribute:NSForegroundColorAttributeName
                 value:grayColor69
                 range:NSMakeRange(0, resultStr.length - cellModel.totalCost.length)];
    [attr addAttribute:NSFontAttributeName
                 value:FONT(18)
                 range:NSMakeRange(resultStr.length - cellModel.totalCost.length, cellModel.totalCost.length)];
    [attr addAttribute:NSForegroundColorAttributeName
                 value:[UIColor hexStringToColor:@"#ff7878"]
                 range:NSMakeRange(resultStr.length - cellModel.totalCost.length, cellModel.totalCost.length)];
    
    sumLab.attributedText = attr;
    
    if ([self.reuseIdentifier isEqualToString:@"orderConfirmCenter"] || [self.reuseIdentifier isEqualToString:@"orderDeliver"]) {
        [clickButn setImage:[[UIImage imageNamed:cellModel.isSelected ? @"moreAdresDef" : @"moreAdresNodef"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)] forState:UIControlStateNormal];
        isSelected = cellModel.isSelected;
    }
    
}

- (void)clickButnClick {
    isSelected = !isSelected;
    [clickButn setImage:[[UIImage imageNamed:isSelected ? @"moreAdresDef" : @"moreAdresNodef"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)] forState:UIControlStateNormal];
    if (_clickButnClickBlock) {
        _clickButnClickBlock(isSelected,orderId);
    }
}

- (void)goToOutput {
    
    UIViewController *parent = [self parentController];
    
    MKScanViewController *controller = [[MKScanViewController alloc] initWithTitle:@"打码扫印"];
    controller.printStr = orderId;
    controller.printType = 10;
    [parent.navigationController pushViewController:controller animated:YES];
}

- (void)goToScanSuccess {
    
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

- (void)goToEdit {
    UIViewController *parent = [self parentController];
    MKOrderWritingController *controller = [[MKOrderWritingController alloc] initWithType:1];
    controller.orderId = orderId;
    [parent.navigationController pushViewController:controller animated:YES];
}

- (void)goToConfirm:(UIButton *)sender {
    UIViewController *parent = [self parentController];
    NSString *title = sender.titleLabel.text;
    NSArray *signArrays = @[
                            @[@"请确定您要删除订单",@"删除订单"],
                            @[@"是否确认发货",@"确认发货"],
                            @[@"请确定您已收到货款并用户已收货",@"交易成功"]
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
    if ([title isEqualToString:@"删除订单"]) {
        [confirmView setSignStr:signArrays[0]];
    }else if ([title isEqualToString:@"确认发货"]){
        [confirmView setSignStr:signArrays[1]];
    }else{
        [confirmView setSignStr:signArrays[2]];
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

- (void)confirm {
    BaseViewController *controller = (BaseViewController *)[self parentController];
    MKOrderManageController *manageController;
    MKPerformanceController *performController;
    MKTradesDetailController *tradesController;
    MKSearResultController *resultController;
    if ([controller isKindOfClass:[MKOrderManageController class]]) {
        manageController = (MKOrderManageController *)controller;
    }
    if ([controller isKindOfClass:[MKPerformanceController class]]) {
        performController = (MKPerformanceController *)controller;
    }
    if ([controller isKindOfClass:[MKTradesDetailController class]]) {
        tradesController = (MKTradesDetailController *)controller;
    }
    if ([controller isKindOfClass:[MKSearResultController class]]) {
        resultController = (MKSearResultController *)controller;
    }
    NSString *titleStr = confirmBtn.titleLabel.text;
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    BOOL isDeliver = [titleStr isEqualToString:@"确认发货"];
    BOOL isDelete = [titleStr isEqualToString:@"删除订单"];
    if (isDelete) {
        [plist setObject:@"3" forKey:@"post_status"];
    }else{
        [plist setObject: isDeliver ? @"1" : @"2" forKey:@"post_status"];
    }
    [AFNetWorkingUsing httpPut:[NSString stringWithFormat:@"order/%@/change",orderId] params:plist success:^(id json) {
        [controller.hud showTipMessageAutoHide:@"订单状态已更新"];
        if (manageController) {
            [manageController reloadTableView:isDeliver ? 0 : 1];
        }
        if (performController) {
            [performController reloadSecondTable];
        }
        if (tradesController) {
            [tradesController reloadTableView];
        }
        if (resultController) {
            [resultController reloadTableView];
        }
        [self cancelConfirm];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [controller.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
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

- (void)loadGoodsViewsWithData:(NSMutableArray *)dataArra {
    MKGoodsInfoView *lastView;
    if (bottomConstraint) {
        [bottomConstraint uninstall];
    }
    for (UIView *subView in goodsView.subviews) {
        if ([subView isKindOfClass:[MKGoodsInfoView class]]) {
            [subView removeFromSuperview];
        }
    }
    //LxDBAnyVar(dataArra);
    for (int index = 0; index < dataArra.count; index ++) {
        MKOrderGoodsModel *model = dataArra[index];
        MKGoodsInfoView *infoView = [[MKGoodsInfoView alloc] initWithType:1];
        [infoView setDataWithModel:model];
        [goodsView addSubview:infoView];
        [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!index) {
                make.top.mas_equalTo(goodsView);
            }else{
                make.top.mas_equalTo(lastView.mas_bottom).offset(10 * autoSizeScaleH);
            }
            make.left.right.mas_equalTo(goodsView);
            make.height.mas_equalTo(100 * autoSizeScaleH);
        }];
        lastView = infoView;
    }
    
    [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (dataArra.count > 0) {
            bottomConstraint = make.bottom.mas_equalTo(lastView);
        }else{
            bottomConstraint = make.height.mas_equalTo(50 * autoSizeScaleH);
        }
    }];
    
}

- (void)customButn:(UIButton *)butn withTittle:(NSString *)tittle {
    [butn setTitle:tittle forState:UIControlStateNormal];
    [butn setTitleColor:grayColor69 forState:UIControlStateNormal];
    butn.titleLabel.font = FONT(14);
    butn.layer.cornerRadius = 5.0;
    butn.layer.masksToBounds = YES;
    butn.borderWidth = 1.0;
    butn.borderColor = [UIColor hexStringToColor:@"#EEEEEE"];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
