//
//  MKOrderWritingController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKOrderWritingController.h"

#import "MKAddressManager.h"

#import "MKCopyBoard.h"
#import "MKReceiverInfoView.h"
#import "MKGoodsInfoCell.h"
#import "MKGoodsInfoTable.h"
#import "MKOrderOtherView.h"
#import "MKAddreChoiceView.h"
#import "MKDeliverChoiceView.h"
#import "MKTimeChoiceView.h"
#import "MKConfirmView.h"

#import "MKOrderCellModel.h"
#import "MKAddreMatchModel.h"

@interface MKOrderWritingController ()

@end

@implementation MKOrderWritingController
{
    MKCopyBoard *copyBoard;
    MKReceiverInfoView *receiverInfoView;
    MKOrderOtherView *otherView;
    UIView *maskView;
    MKAddreChoiceView *addreChoiceView;
    MKDeliverChoiceView *deliverChoiceView;
    MKTimeChoiceView *timeChoiceView;
    
    MKConfirmView *confirmView;
    UIView *maskView2;
    
    NSInteger _type;
    BOOL isMatched;
    NSString *phoneStr;
    NSString *memberId;
    NSString *addressId;
    NSString *addressStr;
    NSString *deliverTime;
    NSInteger shippingMethod;
    MASConstraint *heightConstraint;
    MASConstraint *deliverTopConstraint;
    MASConstraint *timeTopConstraint;
    NSMutableArray *deliverArray;
}

- (instancetype)initWithType:(NSInteger)type {
    _type = type;
    self = [super init];
    return self;
}

- (void)setTopView {
    [super setTopView];
    self.topTitle = !_type ? @"录入订单" : @"编辑订单";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    deliverArray = [[NSMutableArray alloc] initWithObjects:@"同城配送",@"快递配送",@"商家自配送",@"用户自提", nil];
    
    WS(ws)
    copyBoard.fillClickBlock =^(NSString *phoneNum){
        [ws goToChoose:phoneNum];
    };
    copyBoard.autoFillBlock =^(NSArray *array){
        [ws autoFillInfoBlock:array];
    };
    
    otherView.confirmButnBlock =^(){
        [ws confirmButnBlock];
    };
    otherView.deleteButnBlock =^(){
        [ws deleteButnBlock];
    };
    otherView.deliverChoiceBlock = ^(){
        [ws deliverChoose];
    };
    otherView.timeChoiceBlock =^(){
        [ws timeChoose];
    };
    
    
    deliverChoiceView.deliverItemBlock = ^(NSString *deliver) {
        [ws deliverConfirm:deliver];
    };
    timeChoiceView.timeConfirmBlock = ^(NSDate *date) {
        [ws timeConfirm:date];
    };
    
    _infoTable.mj_header = nil;
    _infoTable.mj_footer = nil;
    [_infoTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(receiverInfoView);
        make.top.mas_equalTo(receiverInfoView.mas_bottom);
        heightConstraint = make.height.mas_equalTo(90 * autoSizeScaleH);
    }];
    
    maskView.alpha = 0;
    maskView.hidden = YES;
    [self.view sendSubviewToBack:maskView];
    [maskView addTapEventWith:self action:@selector(cancelChoose)];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(ws.view);
        make.center.mas_equalTo(ws.view);
    }];
    
    [deliverChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.view);
        deliverTopConstraint = make.top.mas_equalTo(ws.view.mas_bottom);
    }];
    
    [timeChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.view);
        timeTopConstraint = make.top.mas_equalTo(ws.view.mas_bottom);
    }];
    
    _infoTable.cellDeleteBlock =^(){
        [ws cellDeleteUpdate];
    };
    
    _isOrdered = NO;
    
    if (_orderId) {
        [self loadEditionData];
    }

    // Do any additional setup after loading the view.
}


- (void)CreatView {
    
    isMatched = NO;
    shippingMethod = -1;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    deliverTime = [formatter stringFromDate:[NSDate date]];
    
    copyBoard = [[MKCopyBoard alloc] init];
    receiverInfoView = [[MKReceiverInfoView alloc] init];
    _infoTable = [[MKGoodsInfoTable alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped cellIdentifier:@"goodsInfoCell" class:[MKGoodsInfoCell class]];
    otherView = [[MKOrderOtherView alloc] initWithType:_type];
    maskView = [[UIView alloc] init];
    deliverChoiceView = [[MKDeliverChoiceView alloc] initWithChoice:0];
    timeChoiceView = [[MKTimeChoiceView alloc] initWithDate:[NSDate date] isFilter:NO];
    
    [self addSubview:copyBoard];
    [self addSubview:receiverInfoView];
    [self addSubview:_infoTable];
    [self addSubview:otherView];
    [self.view addSubview:maskView];
    [self.view addSubview:deliverChoiceView];
    [self.view addSubview:timeChoiceView];
    
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    if (!_type) {
        [copyBoard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(ws.containerView);
        }];
    }else{
        [copyBoard removeFromSuperview];
    }
    
    [receiverInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.containerView);
        if (!_type) {
             make.top.mas_equalTo(copyBoard.mas_bottom);
        }else{
            make.top.mas_equalTo(ws.containerView);
        }
    }];
    
    [otherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.containerView);
        make.top.mas_equalTo(_infoTable.mas_bottom);
    }];
    
    [self setBottomView:otherView withHeight:.1f];
    
    [super updateViewConstraints];
    
}

- (void)confirmButnBlock {
    if (_orderId) {
        [self editOrder];
    }else{
        [self addOrder];
    }
}

- (void)deleteButnBlock {
    [self goToDeleteConfirm];
}

- (void)goToDeleteConfirm {
    
    maskView2 = [[UIView alloc] init];
    maskView2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    maskView2.alpha = 0;
    [self.view addSubview:maskView2];
    [self.view bringSubviewToFront:maskView2];
    
    WS(ws)
    
    [maskView2 addTapEventWith:self action:@selector(cancelDeleteConfirm)];
    [maskView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(ws.view);
        make.center.mas_equalTo(ws.view);
    }];
    confirmView = [[MKConfirmView alloc] init];
    [confirmView setSignStr:@[@"请确定您要删除该订单",@"删除"]];
    confirmView.confirmBlock = ^{
        [ws deleteConfirm];
    };
    
    [self.view addSubview:confirmView];
    confirmView.cancelBlock =^(){
        [ws cancelDeleteConfirm];
    };
    confirmView.alpha = 0;
    confirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
    [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).offset(leftPadding);
        make.right.mas_equalTo(ws.view).offset(rightPadding);
        make.centerY.mas_equalTo(ws.view);
    }];
    [UIView animateWithDuration:.3 animations:^{
        maskView2.alpha = 1;
        confirmView.alpha = 1;
        confirmView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)cancelDeleteConfirm {
    //[self setEditing:NO];
    [UIView animateWithDuration:.2 animations:^{
        maskView2.alpha = 0;
        confirmView.alpha = 0;
        confirmView.transform = CGAffineTransformMakeScale(.0001, .0001);
    }completion:^(BOOL finished) {
        maskView2.hidden = YES;
        confirmView.hidden = YES;
        [maskView2 removeFromSuperview];
        [confirmView removeFromSuperview];
    }];
}

- (void)deleteConfirm {
    
    [self cancelDeleteConfirm];
    
    [self.hud showWait];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@"3" forKey:@"post_status"];
    [AFNetWorkingUsing httpPut:[NSString stringWithFormat:@"order/%@/change",_orderId] params:plist success:^(id json) {
        [self.hud hideAnimated:YES];
        [self.hud showTipMessageAutoHide:@"订单已删除"];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
    
}

- (void)addOrder {
    
    NSString *name,*phoneNum,*address,*remark;
    NSArray *infoArra = [receiverInfoView getReceiverInfo];
    NSArray *otherArra = [otherView getOrderOtherInfo];
    name = infoArra[0];
    phoneNum = infoArra[1];
    address = infoArra[2];
    remark = otherArra[0];
    BOOL isPaid = [otherArra[1] boolValue];
    if (!name.length) {
        [self.hud showTipMessageAutoHide:@"请输入收件人姓名"];
        return;
    }
    if (!phoneNum.length) {
        [self.hud showTipMessageAutoHide:@"请输入手机号"];
        return;
    }
    if (!address.length) {
        [self.hud showTipMessageAutoHide:@"请输入收货地址"];
        return;
    }
    if (!_infoTable.dataArray.count) {
        [self.hud showTipMessageAutoHide:@"请先选择一些商品"];
        return;
    }
    if (shippingMethod < 0) {
        [self.hud showTipMessageAutoHide:@"请先选择配送方式"];
        return;
    }
    
    [self.hud showWaitHudWithMessage:@"订单录入中..."];
    
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:isMatched ? memberId : @"0" forKey:@"member_id"];
    [plist setObject:isPaid ? @"1" : @"0" forKey:@"pay_status"];
    [plist setObject:isMatched ? addressId : @"0" forKey:@"address_id"];
    [plist setObject:address forKey:@"address"];
    [plist setObject:name forKey:@"consignee"];
    [plist setObject:phoneNum forKey:@"mobile"];
    [plist setObject:@(shippingMethod) forKey:@"shipping_method"];
    [plist setObject:deliverTime forKey:@"delivery_time"];
    if (remark.length > 0) {
        [plist setObject:remark forKey:@"remark"];
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (MKCountCostCellModel *model in self.infoTable.dataArray) {
        if ([model.goodsCellModel.buyCount integerValue] > 0) {
            [dict setObject:@([model.goodsCellModel.buyCount integerValue]) forKey:model.goodsCellModel.goodsId];
        }
    }
    [plist setObject:(NSDictionary *)dict forKey:@"goods"];
    [AFNetWorkingUsing httpPost:@"order" params:plist success:^(id json) {
        
        [self.hud hideAnimated:YES];
        
        [self.hud showTipMessageAutoHide:@"订单录入成功"];
        
        //[self.navigationController popViewControllerAnimated:YES];
        
        WS(ws)
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [ws.navigationController popViewControllerAnimated:YES];
        });
        
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)editOrder {
    
    NSString *name,*phoneNum,*address,*remark;
    NSArray *infoArra = [receiverInfoView getReceiverInfo];
    NSArray *otherArra = [otherView getOrderOtherInfo];
    name = infoArra[0];
    phoneNum = infoArra[1];
    address = infoArra[2];
    remark = otherArra[0];
    BOOL isPaid = [otherArra[1] boolValue];
    if (!phoneNum.length) {
        [self.hud showTipMessageAutoHide:@"请输入手机号"];
        return;
    }
    if (!name.length) {
        [self.hud showTipMessageAutoHide:@"请输入收件人姓名"];
        return;
    }
    if (!address.length) {
        [self.hud showTipMessageAutoHide:@"请输入收货地址"];
        return;
    }
    if (!_infoTable.dataArray.count) {
        [self.hud showTipMessageAutoHide:@"请先选择一些商品"];
        return;
    }
    if ([addressStr isEqualToString:address] == NO || [phoneStr isEqualToString:phoneNum] == NO) {
        [[MKAddressManager sharedAddressManager] needsUpdate:memberId];
    }
    
    [self.hud showWaitHudWithMessage:@"订单保存中..."];
    
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:memberId forKey:@"member_id"];
    [plist setObject:isPaid ? @"1" : @"0" forKey:@"pay_status"];
    [plist setObject:isMatched ? addressId : @"0" forKey:@"address_id"];
    [plist setObject:address forKey:@"address"];
    [plist setObject:addressId forKey:@"address_id"];
    [plist setObject:name forKey:@"consignee"];
    [plist setObject:phoneNum forKey:@"mobile"];
    [plist setObject:@(shippingMethod) forKey:@"shipping_method"];
    [plist setObject:deliverTime forKey:@"delivery_time"];
    if (remark.length > 0) {
        [plist setObject:remark forKey:@"remark"];
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (MKCountCostCellModel *model in self.infoTable.dataArray) {
        if ([model.goodsCellModel.buyCount integerValue] > 0) {
            [dict setObject:@([model.goodsCellModel.buyCount integerValue]) forKey:model.goodsCellModel.goodsId];
        }
    }
    [plist setObject:(NSDictionary *)dict forKey:@"goods"];
    [AFNetWorkingUsing httpPut:[NSString stringWithFormat:@"order/%@",_orderId] params:plist success:^(id json) {
        
        [self.hud hideAnimated:YES];
        [self.hud showTipMessageAutoHide:@"订单编辑成功"];
        
        WS(ws)
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [ws.navigationController popViewControllerAnimated:YES];
        });

    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)goToChoose:(NSString *)phoneNum {
    
    MKAddreMatchModel *localModel = [[MKAddressManager sharedAddressManager] getAddreModelWithPhone:phoneNum];
    if (localModel != nil && localModel.needsUpdate == NO) {
        WS(ws)
        [self.view bringSubviewToFront:maskView];
        maskView.hidden = NO;
        addreChoiceView = [[MKAddreChoiceView alloc] init];
        [addreChoiceView setData:localModel];
        addreChoiceView.transform = CGAffineTransformMakeScale(.0001, .0001);
        addreChoiceView.alpha = 0;
        addreChoiceView.cancelClickBock =^(){
            [ws cancelChoose];
        };
        addreChoiceView.confirmClickBock =^(MKAddreMatchModel *model,NSInteger index){
            [ws confirmChoose:model Index:index];
        };
        [self.view addSubview:addreChoiceView];
        [addreChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ws.view).offset(leftPadding);
            make.right.mas_equalTo(ws.view).offset(rightPadding);
            make.centerY.mas_equalTo(ws.view);
        }];
        [UIView animateWithDuration:.3 animations:^{
            maskView.alpha = 1;
            addreChoiceView.alpha = 1;
            addreChoiceView.transform = CGAffineTransformMakeScale(1,1);
        }];
    }else{
        NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
        [plist setObject:phoneNum forKey:@"address"];
        [AFNetWorkingUsing httpPost:@"match/mobile" params:plist success:^(id json) {
            WS(ws)
            [self.view bringSubviewToFront:maskView];
            maskView.hidden = NO;
            addreChoiceView = [[MKAddreChoiceView alloc] init];
            MKAddreMatchModel *model = [MKAddreMatchModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
            model.needsUpdate = NO;
            if (!localModel) {
                [[MKAddressManager sharedAddressManager].memberArray addObject:model];
            }else{
                [[MKAddressManager sharedAddressManager] updadteLocalInfo:model];
            }
            [addreChoiceView setData:model];
            addreChoiceView.transform = CGAffineTransformMakeScale(.0001, .0001);
            addreChoiceView.alpha = 0;
            addreChoiceView.cancelClickBock =^(){
                [ws cancelChoose];
            };
            addreChoiceView.confirmClickBock =^(MKAddreMatchModel *model,NSInteger index){
                [ws confirmChoose:model Index:index];
            };
            [self.view addSubview:addreChoiceView];
            [addreChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ws.view).offset(leftPadding);
                make.right.mas_equalTo(ws.view).offset(rightPadding);
                make.centerY.mas_equalTo(ws.view);
            }];
            [UIView animateWithDuration:.3 animations:^{
                maskView.alpha = 1;
                addreChoiceView.alpha = 1;
                addreChoiceView.transform = CGAffineTransformMakeScale(1,1);
            }];
        } fail:^(NSError *error) {
            
        } other:^(id json) {
            NSString *signStr = [json objectForKey:@"msg"];
            if ([signStr isEqualToString:@"获取收货信息失败"]) {
                [copyBoard showSignContentWithSign:@"未匹配到相应会员，可选择智能填单"];
            }
            [self.hud showTipMessageAutoHide:@"匹配失败"];
        }];
    }

}

- (void)deliverChoose {
    
    WS(ws)
    [deliverTopConstraint uninstall];
    [deliverChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        deliverTopConstraint = make.top.mas_equalTo(ws.view.mas_bottom).offset(-224 * autoSizeScaleH);
    }];
    
    maskView.hidden = NO;
    [self.view bringSubviewToFront:maskView];
    [self.view bringSubviewToFront:deliverChoiceView];
    
    [UIView animateWithDuration:.3 animations:^{
        maskView.alpha = 1;
        [self.view layoutIfNeeded];
    }];
    
}

- (void)deliverConfirm:(NSString *)deliver {
    
    [otherView setDeliverStr:deliver];
    
    shippingMethod = [deliverArray indexOfObject:deliver];
    
    [self cancelChoose];
    
}

- (void)timeChoose {
    
    WS(ws)
    [timeTopConstraint uninstall];
    [timeChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        timeTopConstraint = make.top.mas_equalTo(ws.view.mas_bottom).offset(-225 * autoSizeScaleH);
    }];
    
    maskView.hidden = NO;
    [self.view bringSubviewToFront:maskView];
    [self.view bringSubviewToFront:timeChoiceView];
    
    [UIView animateWithDuration:.3 animations:^{
        maskView.alpha = 1;
        [self.view layoutIfNeeded];
    }];
}

- (void)timeConfirm:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    
    deliverTime = dateStr;
    [otherView setDateStr:dateStr];
    
    [self cancelChoose];
}

- (void)cancelChoose {
    
    WS(ws)
    [deliverTopConstraint uninstall];
    [deliverChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        deliverTopConstraint = make.top.mas_equalTo(ws.view.mas_bottom);
    }];
    
    [timeTopConstraint uninstall];
    [timeChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        timeTopConstraint = make.top.mas_equalTo(ws.view.mas_bottom);
    }];
    
    [UIView animateWithDuration:.3 animations:^{
        maskView.alpha = 0;
        addreChoiceView.alpha = 0;
        addreChoiceView.transform = CGAffineTransformMakeScale(.0001,.0001);
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        maskView.hidden = YES;
        addreChoiceView.hidden = YES;
        [addreChoiceView removeFromSuperview];
        [self.view sendSubviewToBack:maskView];
    }];
}

- (void)confirmChoose:(MKAddreMatchModel *)model Index:(NSInteger)index {
    [self cancelChoose];
    isMatched = YES;
    MKAddreMatchItemModel *itemModel = model.address[index];
    memberId = model.matchId;
    addressId = itemModel.itemId;
    addressStr = itemModel.address;
    [receiverInfoView setReceiverInfo:model.name Phone:model.mobile Address:itemModel.address];
    [copyBoard showSignContentWithSign:@"已完成智能填单，如有误差请自行调整"];
}

- (void)autoFillInfoBlock:(NSArray *)array {
    if (array.count == 1) {
        [receiverInfoView setInfoPhoneNum:array[0]];
    }else{
        if(array.count == 3) {
            [receiverInfoView setReceiverInfo:array[0] Phone:array[1] Address:array[2]];
        }else{
            [self.hud showTipMessage:@"识别失败"];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_isOrdered) {
        [self tableViewReload:_infoTable];
    }
    if (_phoneNum != nil && _phoneNum.length > 0) {
        [copyBoard setText:_phoneNum];
        [self goToChoose:_phoneNum];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    _phoneNum = @"";
    
    [[MKAddressManager sharedAddressManager] saveLocalInfo];
}


- (void)loadEditionData {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:[NSString stringWithFormat:@"order/%@/edit",_orderId] params:plist success:^(id json) {
        MKOrderDetailModel *model = [MKOrderDetailModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
        memberId = model.memberId;
        addressId = model.addressId;
        phoneStr = model.phoneNum;
        [receiverInfoView setReceiverInfo:model.name Phone:model.phoneNum Address:model.address];
        [self tableViewEditionReload:_infoTable WithData:model.goodsInfoArra];
        [otherView setOrderOtherInfo:model.remark IsPaid:![model.payStatus integerValue] ? NO : YES];
        shippingMethod = [model.shippingMethod integerValue];
        deliverTime  =model.deliveryTime;
        [otherView setDeliverStr:deliverArray[shippingMethod]];
        [otherView setDateStr:model.deliveryTime];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}


- (void)tableViewReload:(UITableView *)tableView {
    BaseUITableView *table = (BaseUITableView *)tableView;
    [table.dataArray removeAllObjects];
    for (MKAddGoodsCellModel *model in self.tableViewData) {
        if ([model.buyCount integerValue] > 0) {
            MKCountCostCellModel *costModel = [[MKCountCostCellModel alloc] init];
            costModel.goodsCellModel = model;
            NSInteger cost = [model.buyCount integerValue] * [model.price integerValue];
            costModel.totalCost = [NSString stringWithFormat:@"%ld",cost];
            [table.dataArray addObject:costModel];
            continue;
        }
    }
    
    [heightConstraint uninstall];
    
    CGFloat tableHeight = 90 * autoSizeScaleH + 190 * autoSizeScaleH * table.dataArray.count;
    [_infoTable mas_makeConstraints:^(MASConstraintMaker *make) {
        heightConstraint = make.height.mas_equalTo(tableHeight);
    }];
    
    [self.view layoutIfNeeded];
    
    [table reloadData];
}

- (void)tableViewEditionReload:(UITableView *)tableView WithData:(NSMutableArray *)editionArra{
    BaseUITableView *table = (BaseUITableView *)tableView;
    [table.dataArray removeAllObjects];
    for (MKOrderGoodsModel *model in editionArra) {
        MKCountCostCellModel *costModel = [[MKCountCostCellModel alloc] init];
        MKAddGoodsCellModel *goodsCellModel = [[MKAddGoodsCellModel alloc] init];
        [self getValueFromParent:goodsCellModel SuperModel:model.goods];
        goodsCellModel.buyCount = model.payNumber;
        costModel.totalCost = [NSString stringWithFormat:@"%ld",[model.payNumber integerValue] * [model.price integerValue]];
        costModel.goodsCellModel = goodsCellModel;
        [table.dataArray addObject:costModel];
    }
    
    [heightConstraint uninstall];
    
    CGFloat tableHeight = 90 * autoSizeScaleH + 190 * autoSizeScaleH * table.dataArray.count;
    [_infoTable mas_makeConstraints:^(MASConstraintMaker *make) {
        heightConstraint = make.height.mas_equalTo(tableHeight);
    }];
    
    [self.view layoutIfNeeded];
    
    [table reloadData];
}

- (void)cellDeleteUpdate {
    
    [heightConstraint uninstall];
    
    CGFloat tableHeight = 90 * autoSizeScaleH + 190 * autoSizeScaleH * _infoTable.dataArray.count;
    [_infoTable mas_makeConstraints:^(MASConstraintMaker *make) {
        heightConstraint = make.height.mas_equalTo(tableHeight);
    }];
    
//    [self.view layoutIfNeeded];
}

- (void)getValueFromParent:(MKAddGoodsCellModel *)model SuperModel:(MKGoodsInfoModel *)superModel {
    model.imgUrl = superModel.imgUrl;
    model.goodsName = superModel.goodsName;
    model.goodsId = superModel.goodsId;
    model.price = superModel.price;
    model.unit = superModel.unit;
    model.number = superModel.number;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
