//
//  MKOrderManageTable.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/27.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKOrderManageTable.h"
#import "MKOrderManageCell.h"

#import "MKOrderCellModel.h"

#import "UITableView+FDTemplateLayoutCell.h"

@implementation MKOrderManageTable
{
    NSInteger _type;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style cellIdentifier:(NSString *)cellIdentifier class:(Class)cellClass type:(NSInteger)type {
    self = [super initWithFrame:frame style:style cellIdentifier:cellIdentifier class:cellClass];
    if (self) {
        _type = type;   
    }
    return self;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MKOrderManageCell *cell =[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    cell.imageLoadedEvent=^()
    {
        if([tableView cellForRowAtIndexPath:indexPath])
        {
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    };
    
    WS(ws)
    cell.clickButnClickBlock =^(BOOL isSelect,NSString *orderId){
        [ws clickButnClickBlock:isSelect OrderID:orderId];
    };
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setData:self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat height =[tableView fd_heightForCellWithIdentifier:self.cellIdentifier cacheByIndexPath:indexPath configuration:^(BaseTableViewCell *cell) {
        
        [cell setData:self.dataArray[indexPath.row]];
        
    }];
    return height;
}


- (void)SetGreenBtn {
    
    if(!_type){
        
        [self setPrintButns];
        
    }else{
        
        [self setConfirmButn];
    }
    
}

- (void)setConfirmButn {
    
    WS(ws)
    
    UIViewController *parent = [self parentController];
    
    UIButton *butn = [self getGreenButnWithTitle:@" 批量确认" AndIcon:@"orderDetConf"];
    
    [self addSubview:butn];
    
    [butn addTarget:self action:@selector(confirmButnClick) forControlEvents:UIControlEventTouchUpInside];
    [butn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.bottom.mas_equalTo(parent.view).offset(-15 * autoSizeScaleH);
        make.height.mas_equalTo(40 * autoSizeScaleH);
        make.width.mas_equalTo(SCREEN_WIDTH - 30 * autoSizeScaleW);
    }];
    
}

- (void)setPrintButns {
    
    WS(ws)
    
    UIViewController *parent = [self parentController];
    
    UIButton *butn1 = [self getGreenButnWithTitle:@" 批量导出" AndIcon:@"orderDetPrint"];
    UIButton *butn2 = [self getGreenButnWithTitle:@" 批量打印" AndIcon:@"orderDetPrint"];
    
    [self addSubview:butn1];
    [self addSubview:butn2];
    
    butn1.tag = 20;
    [butn1 addTarget:self action:@selector(printButnClick:) forControlEvents:UIControlEventTouchUpInside];
    [butn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.bottom.mas_equalTo(parent.view).offset(-15 * autoSizeScaleH);
        make.height.mas_equalTo(40 * autoSizeScaleH);
        make.width.mas_equalTo((SCREEN_WIDTH - 60 * autoSizeScaleW) / 2);
    }];
    
    butn2.tag = 21;
    [butn2 addTarget:self action:@selector(printButnClick:) forControlEvents:UIControlEventTouchUpInside];
    [butn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(butn1.mas_right).offset(30 * autoSizeScaleW);
        make.size.centerY.mas_equalTo(butn1);
    }];
    
}

- (UIButton *)getGreenButnWithTitle:(NSString *)title AndIcon:(NSString *)iconName {
    
    UIButton *resultButn = [[UIButton alloc] init];
    
    resultButn.titleLabel.font = FONT(14);
    resultButn.titleLabel.textColor = customWhite;
    resultButn.layer.cornerRadius = 5.0;
    resultButn.layer.masksToBounds = YES;
    [resultButn setTitle:title forState:UIControlStateNormal];
    [resultButn setImage:[[UIImage imageNamed:iconName] imageByScalingToSize:CGSizeMake(15, 15)]
                forState:UIControlStateNormal];
    resultButn.backgroundColor = [UIColor colorWithRed:.2078 green:.7568 blue:.447 alpha:.8];
    
    return resultButn;
}

- (void)confirmButnClick {
    if (_confirmButnBlock) {
        _confirmButnBlock();
    }
}

- (void)printButnClick:(UIButton *)sender{
    NSInteger tag = sender.tag;
    if (_printButnBlock) {
        _printButnBlock(tag);
    }
    
}

- (void)clickButnClickBlock:(BOOL)isSelect  OrderID:(NSString *)orderId{
    for (MKOrderCellModel *model in self.dataArray) {
        if ([model.orderId isEqualToString:orderId]) {
            model.isSelected = isSelect;
            return;
        }
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
