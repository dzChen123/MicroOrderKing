//
//  MKGoodsManageCell.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKGoodsManageController.h"
#import "MKNewGoodsController.h"
#import "MKSearResultController.h"

#import "MKGoodsManageCell.h"
#import "MKGoodsInfoView.h"
#import "MKConfirmView.h"

#import "MKOrderCellModel.h"

@implementation MKGoodsManageCell
{
    UIView *grayView;
    UIView *lineView;
    MKGoodsInfoView *goodsInfoView;
    UIButton *editButn;
    UIButton *deleteButn;
    UIButton *manageButn;
    UIView *whiteView;
    
    NSString *goodsId;
    UIView *maskView;
    MKConfirmView *confirmView;
    BOOL isSale;    //yes  表示正在销售 操作的话 是下架  no与之相反
}

- (void)createView {
    grayView = [[UIView alloc] init];
    lineView = [[UIView alloc] init];
    goodsInfoView = [[MKGoodsInfoView alloc] initWithType:2];
    editButn = [[UIButton alloc] init];
    deleteButn = [[UIButton alloc] init];
    manageButn = [[UIButton alloc] init];
    whiteView = [[UIView alloc] init];
    
    [self.contentView addSubview:grayView];
    [self.contentView addSubview:lineView];
    [self.contentView addSubview:goodsInfoView];
    [self.contentView addSubview:whiteView];
    [whiteView addSubview:editButn];
    [whiteView addSubview:deleteButn];
    [whiteView addSubview:manageButn];
}

- (void)setttingViewAtuoLayout {
    
    WS(ws)      //不知怎么升级到8.3之后约束报警告了 (底部换参照物没用) 按理说不应该的...  订单管理那里也一样
    
    MASAttachKeys(lineView,goodsInfoView,deleteButn,editButn,grayView,manageButn);
    
    self.contentView.backgroundColor = customWhite;
    
    grayView.backgroundColor = VIEWBACKGRAY;
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(15 * autoSizeScaleH);
    }];

    lineView.backgroundColor = [UIColor hexStringToColor:@"#F0F0F0"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(grayView);
        //make.top.mas_equalTo(grayView.mas_bottom);
        make.top.mas_equalTo(ws.contentView).offset(15 * autoSizeScaleH);
        make.height.mas_equalTo(1);
    }];
    
    goodsInfoView.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
    [goodsInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom);
        make.left.right.mas_equalTo(ws.contentView);
        //make.bottom.mas_equalTo(ws.contentView);
    }];
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(50 * autoSizeScaleH);
        make.top.mas_equalTo(goodsInfoView.mas_bottom);
        make.bottom.mas_equalTo(ws.contentView);
    }];
    
    [deleteButn setTitle:@" 删除" forState:UIControlStateNormal];
    [deleteButn setImage:[[UIImage imageNamed:@"comManDel"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)]forState:UIControlStateNormal];
    [deleteButn addTarget:self action:@selector(goToConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [deleteButn setTitleColor:[UIColor hexStringToColor:@"#7A7A7A"] forState:UIControlStateNormal];
    deleteButn.titleLabel.font = FONT(14);
    deleteButn.layer.masksToBounds = YES;
    deleteButn.layer.cornerRadius = 3.0;
    deleteButn.layer.borderColor = [UIColor hexStringToColor:@"#EEEEEE"].CGColor;
    deleteButn.layer.borderWidth = 1.0;
    [deleteButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(whiteView).offset(rightPadding);
        make.top.mas_equalTo(whiteView).offset(10 * autoSizeScaleH);
        make.size.mas_equalTo(CGSizeMake(80 * autoSizeScaleW, 30 * autoSizeScaleH));
        //make.bottom.mas_equalTo(ws.contentView).offset(-10 * autoSizeScaleH);
    }];
    

    [editButn setTitle:@" 编辑" forState:UIControlStateNormal];
    [editButn addTarget:self action:@selector(goToEditGoods) forControlEvents:UIControlEventTouchUpInside];
    [editButn setImage:[[UIImage imageNamed:@"comManEdit"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)]forState:UIControlStateNormal];
    [editButn setTitleColor:[UIColor hexStringToColor:@"#7A7A7A"] forState:UIControlStateNormal];
    editButn.titleLabel.font = FONT(14);
    editButn.layer.masksToBounds = YES;
    editButn.layer.cornerRadius = 3.0;
    editButn.layer.borderColor = [UIColor hexStringToColor:@"#EEEEEE"].CGColor;
    editButn.layer.borderWidth = 1.0;
    [editButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(deleteButn.mas_left).offset(rightPadding);
        make.size.centerY.mas_equalTo(deleteButn);
    }];
    
    //[manageButn setTitle:@" 编辑" forState:UIControlStateNormal];
    [manageButn addTarget:self action:@selector(goToConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [manageButn setImage:[[UIImage imageNamed:@"shangjia"] imageByScalingToSize:CGSizeMake(13 * autoSizeScaleW, 14 * autoSizeScaleW)]forState:UIControlStateNormal];
    [manageButn setTitleColor:[UIColor hexStringToColor:@"#7A7A7A"] forState:UIControlStateNormal];
    manageButn.titleLabel.font = FONT(14);
    manageButn.layer.masksToBounds = YES;
    manageButn.layer.cornerRadius = 3.0;
    manageButn.layer.borderColor = [UIColor hexStringToColor:@"#EEEEEE"].CGColor;
    manageButn.layer.borderWidth = 1.0;
    [manageButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(editButn.mas_left).offset(rightPadding);
        make.size.centerY.mas_equalTo(deleteButn);
    }];
    
}

- (void)goToEditGoods {
    
    UIViewController *parent = [self parentController];
    MKNewGoodsController *controller = [[MKNewGoodsController alloc] initWithTitle:@"商品编辑"];
    controller.goodsId = goodsId;
    [parent.navigationController pushViewController:controller animated:YES];
    
}

- (void)manageGoods {
    BaseViewController *parent = (BaseViewController *)[self parentController];
    MKGoodsManageController *manageController;
    MKSearResultController *resultController;
    if ([parent isKindOfClass:[MKGoodsManageController class]]) {
        manageController = (MKGoodsManageController *)parent;
    }
    if ([parent isKindOfClass:[MKSearResultController class]]) {
        resultController = (MKSearResultController *)parent;
    }
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:@"is_sale" forKey:@"field"];
    [AFNetWorkingUsing httpPut:[NSString stringWithFormat:@"goods/%@/change",goodsId] params:plist success:^(id json) {
        if (manageController) {
            for (MKGoodsInfoModel *model in manageController.manageTable.dataArray) {
                if ([model.goodsId isEqualToString:goodsId]) {
                    model.isSale = isSale ? @"0" : @"1";
                    break;
                }
            }
            [self GoodsSorting:manageController.manageTable.dataArray];
            [manageController.manageTable reloadData];
        }
        if (resultController) {
            for (MKGoodsInfoModel *model in resultController.resultTable.dataArray) {
                if ([model.goodsId isEqualToString:goodsId]) {
                    model.isSale = isSale ? @"0" : @"1";
                    break;
                }
            }
            [self GoodsSorting:resultController.resultTable.dataArray];
            [resultController.resultTable reloadData];
        }
        [self cancelConfirm];
    } fail:^(NSError *error) {
        
        [self cancelConfirm];
        
    } other:^(id json) {
        
        [self cancelConfirm];
        [parent.hud showTipMessageAutoHide:@"商品状态修改失败"];
        
    }];
    

}

- (void)deleteGoods {
    BaseViewController *parent = (BaseViewController *)[self parentController];
    MKGoodsManageController *manageController;
    MKSearResultController *resultController;
    if ([parent isKindOfClass:[MKGoodsManageController class]]) {
        manageController = (MKGoodsManageController *)parent;
    }
    if ([parent isKindOfClass:[MKSearResultController class]]) {
        resultController = (MKSearResultController *)parent;
    }
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpDelete:[NSString stringWithFormat:@"goods/%@",goodsId] params:plist success:^(id json) {
        if (manageController) {
            NSInteger rowNum = 0;
            for (MKGoodsInfoModel *model in manageController.manageTable.dataArray) {
                if ([model.goodsId isEqualToString:goodsId]) {
                    rowNum = [manageController.manageTable.dataArray indexOfObject:model];
                    [manageController.manageTable.dataArray removeObject:model];
                    break;
                }
            }
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowNum inSection:0];
            [manageController.manageTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        if (resultController) {
            NSInteger rowNum = 0;
            for (MKGoodsInfoModel *model in resultController.resultTable.dataArray) {
                if ([model.goodsId isEqualToString:goodsId]) {
                    rowNum = [resultController.resultTable.dataArray indexOfObject:model];
                    [resultController.resultTable.dataArray removeObject:model];
                    break;
                }
            }
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowNum inSection:0];
            [resultController.resultTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        [self cancelConfirm];
    } fail:^(NSError *error) {
        
        [self cancelConfirm];
        
    } other:^(id json) {
        
        [self cancelConfirm];
        [parent.hud showTipMessageAutoHide:@"删除失败"];
        
    }];
}

- (void)goToConfirm:(UIButton *)sender {
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
    confirmView = [[MKConfirmView alloc] init];
    if ([sender.titleLabel.text isEqualToString:@" 删除"]) {
        [confirmView setSignStr:@[@"请确定您要删除此商品",@"删除"]];
        confirmView.confirmBlock =^(){
            [ws deleteGoods];
        };
    }else if ([sender.titleLabel.text isEqualToString:@" 下架"]){
        isSale = YES;
        [confirmView setSignStr:@[@"请确定您要下架此商品",@"下架"]];
        confirmView.confirmBlock =^(){
            [ws manageGoods];
        };
    }else{
        isSale = NO;
        [confirmView setSignStr:@[@"请确定您要上架此商品",@"上架"]];
        confirmView.confirmBlock =^(){
            [ws manageGoods];
        };
    }
    

    [parent.view addSubview:confirmView];
    confirmView.cancelBlock =^(){
        [ws cancelConfirm];
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
    }completion:^(BOOL finished) {
        maskView.hidden = YES;
        confirmView.hidden = YES;
        [maskView removeFromSuperview];
        [confirmView removeFromSuperview];
    }];
}

- (void)setData:(id)model {
    
    MKGoodsInfoModel *cellModel = (MKGoodsInfoModel *)model;
    [goodsInfoView setDataWithModel:model];
    goodsId = cellModel.goodsId;
    
    [manageButn setTitle:![cellModel.isSale integerValue] ? @" 上架" : @" 下架" forState:UIControlStateNormal];
    manageButn.backgroundColor = ![cellModel.isSale integerValue] ? [UIColor hexStringToColor:@"#F4F4F4"] : customWhite;
    
}

//---获得的商品列表是混乱的  要进行ID从大到小排序且下架商品放在最后---

- (void)GoodsSorting:(NSMutableArray *)array {
    //    for (int i = 0 ;i < array.count ;i ++ ) {
    //        NSLog(@"before:%@",((MKGoodsInfoModel *)array[i]).goodsId);
    //    }
    for (int i = 0; i < array.count; i ++) {
        for (int j = 0; j < array.count - 1; j ++) {
            MKGoodsInfoModel *model1 = array[j];
            MKGoodsInfoModel *model2 = array[j + 1];
            if ([model2.goodsId integerValue] > [model1.goodsId integerValue]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
    }
    //将下架的商品移动到列表的最下面
    NSMutableArray *indexArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; i ++) {
        MKGoodsInfoModel *model = array[i];
        if (![model.isSale integerValue]) {
            [indexArray addObject:model];
        }
    }
    for (int i = 0; i < indexArray.count; i ++) {
        MKGoodsInfoModel *model = indexArray[i];
        [array removeObject:model];
        [array addObject:model];
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
