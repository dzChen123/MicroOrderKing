//
//  MKAddreMangeCell.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/5.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAddreManageController.h"
#import "MKEditAddreController.h"

#import "MKAddreMangeCell.h"
#import "MKConfirmView.h"

#import "MKAddreManageModel.h"

@implementation MKAddreMangeCell
{
    UIView *grayView;
    MKAddreView *addreView;
    UIView *lineView;
    UIButton *editButn;
    UIButton *deleteButn;
    
    MKConfirmView *confirmView;
    UIView *maskView;
    
    UIView *view;
    
    NSString *addressId;
    //MASConstraint *heightConstraint;
}

- (void)createView {
    grayView = [[UIView alloc] init];
    addreView = [[MKAddreView alloc] init];
    lineView = [[UIView alloc] init];
    editButn = [[UIButton alloc] init];
    deleteButn = [[UIButton alloc] init];
    
    view = [[UIView alloc] init];
    
    [self.contentView addSubview:view];
    
    [self.contentView addSubview:grayView];
    [self.contentView addSubview:addreView];
    [self.contentView addSubview:lineView];
    [self.contentView addSubview:editButn];
    [self.contentView addSubview:deleteButn];
}

- (void)setttingViewAtuoLayout {
    
    WS(ws)
    
    self.contentView.backgroundColor = customWhite;
    
    grayView.backgroundColor = VIEWBACKGRAY;
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(10 * autoSizeScaleH);
    }];
    
    [addreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(grayView.mas_bottom);
        make.left.right.mas_equalTo(grayView);
    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(grayView.mas_bottom);
        make.left.right.mas_equalTo(grayView);
        make.height.equalTo(addreView.mas_height);
    }];

    lineView.backgroundColor = VIEWBACKGRAY;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(grayView);
        make.top.mas_equalTo(view.mas_bottom);
        make.height.mas_equalTo(1);
    }];

    [deleteButn setTitle:@"  删除" forState:UIControlStateNormal];
    [deleteButn setTitleColor:wordThreeColor forState:UIControlStateNormal];
    [deleteButn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [deleteButn setImage:[[UIImage imageNamed:@"searchPageEmplcon"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)] forState:UIControlStateNormal];
    deleteButn.titleLabel.font = FONT(14);
    [deleteButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(grayView).offset(rightPadding);
        make.top.mas_equalTo(lineView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(70 * autoSizeScaleW, 45 * autoSizeScaleH));
    }];
    
    [editButn setTitle:@"  编辑" forState:UIControlStateNormal];
    [editButn addTarget:self action:@selector(goToEdit) forControlEvents:UIControlEventTouchUpInside];
    [editButn setTitleColor:wordThreeColor forState:UIControlStateNormal];
    [editButn setImage:[[UIImage imageNamed:@"comManEdit"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)] forState:UIControlStateNormal];
    editButn.titleLabel.font = FONT(14);
    [editButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(deleteButn.mas_left).offset(-5 * autoSizeScaleW);
        make.size.centerY.mas_equalTo(deleteButn);
        make.bottom.mas_equalTo(ws.contentView);
    }];

    
    
}

- (void)setData:(id)model {
    MKAddreManageModel *cellModel = (MKAddreManageModel *)model;
    NSString *addre = cellModel.address;
    addressId = cellModel.addreId;
    [addreView setAddre:addre];
    NSDictionary *attribute = @{NSFontAttributeName:FONT(14)};
    CGSize rectSize = [addre boundingRectWithSize:CGSizeMake(350 * autoSizeScaleW, MAXFLOAT)
                                          options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    _cellHeight = rectSize.height + 100 * autoSizeScaleH;
}

- (void)goToEdit {
    UIViewController *parent = [self parentController];
    MKEditAddreController *controller = [[MKEditAddreController alloc] initWithType:1];
    controller.addreId = addressId;
    [parent.navigationController pushViewController:controller animated:YES];
}

- (void)delete {
    MKAddreManageController *parent = (MKAddreManageController *)[self parentController];
    if (parent.addreManageTable.dataArray.count > 1) {

        [self goToConfirm];
        
    }else {
        [parent.hud showTipMessageAutoHide:@"必须有一个收货地址"];
    }
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
    [confirmView setSignStr:@[@"请确定您要删除该地址",@"删除"]];
    confirmView.confirmBlock = ^{
        [ws confirm];
    };
    
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
    [self setEditing:NO];
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

- (void)confirm {
    
    [self cancelConfirm];
    
    MKAddreManageController *parent = (MKAddreManageController *)[self parentController];
    
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpDelete:[NSString stringWithFormat:@"address/%@",addressId] params:plist success:^(id json) {
        NSInteger rowNum = 0;
        for (MKAddreManageModel *model in parent.addreManageTable.dataArray) {
            if ([model.addreId isEqualToString:addressId]) {
                rowNum = [parent.addreManageTable.dataArray indexOfObject:model];
                [parent.addreManageTable.dataArray removeObject:model];
                break;
            }
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowNum inSection:0];
        [parent.addreManageTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [parent.hud showTipMessageAutoHide:@"删除失败"];
    }];
    
}

@end

@implementation MKAddreView
{
    UILabel *addreLab;
}

- (void)CreatView {
    addreLab = [[UILabel alloc] init];
    
    [self addSubview:addreLab];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    addreLab.font = FONT(14);
    addreLab.textColor = wordThreeColor;
    addreLab.numberOfLines = 0;
    [addreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws).offset(15 * autoSizeScaleH);
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.right.lessThanOrEqualTo(ws).offset(rightPadding);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(addreLab).offset(25 * autoSizeScaleH);
    }];
}

- (void)setAddre:(NSString *)addre {
    addreLab.text = addre;
}


@end

