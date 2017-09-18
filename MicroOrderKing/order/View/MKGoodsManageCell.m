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
    
    NSString *goodsId;
    UIView *maskView;
    MKConfirmView *confirmView;
}

- (void)createView {
    grayView = [[UIView alloc] init];
    lineView = [[UIView alloc] init];
    goodsInfoView = [[MKGoodsInfoView alloc] initWithType:2];
    editButn = [[UIButton alloc] init];
    deleteButn = [[UIButton alloc] init];
    
    [self.contentView addSubview:grayView];
    [self.contentView addSubview:lineView];
    [self.contentView addSubview:goodsInfoView];
    [self.contentView addSubview:editButn];
    [self.contentView addSubview:deleteButn];
}

- (void)setttingViewAtuoLayout {
    
    WS(ws)
    
    MASAttachKeys(lineView,goodsInfoView,deleteButn,editButn);
    
    self.contentView.backgroundColor = customWhite;
    
    grayView.backgroundColor = VIEWBACKGRAY;
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(15 * autoSizeScaleH);
    }];

    lineView.backgroundColor = [UIColor hexStringToColor:@"#F0F0F0"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(grayView);
        make.top.mas_equalTo(grayView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    goodsInfoView.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
    [goodsInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom);
        make.left.right.mas_equalTo(ws.contentView);
    }];

    [deleteButn setTitle:@" 删除" forState:UIControlStateNormal];
    [deleteButn setImage:[[UIImage imageNamed:@"comManDel"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)]forState:UIControlStateNormal];
    [deleteButn addTarget:self action:@selector(goToConfirm) forControlEvents:UIControlEventTouchUpInside];
    [deleteButn setTitleColor:[UIColor hexStringToColor:@"#7A7A7A"] forState:UIControlStateNormal];
    deleteButn.titleLabel.font = FONT(14);
    deleteButn.layer.masksToBounds = YES;
    deleteButn.layer.cornerRadius = 3.0;
    deleteButn.layer.borderColor = [UIColor hexStringToColor:@"#EEEEEE"].CGColor;
    deleteButn.layer.borderWidth = 1.0;
    [deleteButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws.contentView).offset(rightPadding);
        make.top.mas_equalTo(goodsInfoView.mas_bottom).offset(10 * autoSizeScaleH);
        make.size.mas_equalTo(CGSizeMake(80 * autoSizeScaleW, 30 * autoSizeScaleH));
        make.bottom.mas_equalTo(ws.contentView).offset(-10 * autoSizeScaleH);
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
}

- (void)goToEditGoods {
    
    UIViewController *parent = [self parentController];
    MKNewGoodsController *controller = [[MKNewGoodsController alloc] initWithTitle:@"商品编辑"];
    controller.goodsId = goodsId;
    [parent.navigationController pushViewController:controller animated:YES];
    
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

- (void)goToConfirm {
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
    [confirmView setSignStr:@[@"请确定您要删除此商品",@"删除"]];

    [parent.view addSubview:confirmView];
    confirmView.cancelBlock =^(){
        [ws cancelConfirm];
    };
    confirmView.confirmBlock =^(){
        [ws deleteGoods];
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
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
