//
//  MKOrderManageTable.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/27.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKOrderManageTable.h"

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


- (void)SetGreenBtn {
    NSString *btnTittle,*iconName;
    if(!_type){
        btnTittle = @" 批量打印";
        iconName = @"orderDetPrint";
    }else{
        btnTittle = @" 批量确认";
        iconName = @"orderDetConf";
    }
    
    UIButton *greenBtn = [[UIButton alloc] init];
    UIViewController *parent = [self parentController];
    
    [self addSubview:greenBtn];
    
    WS(ws)
    greenBtn.titleLabel.font = FONT(14);
    greenBtn.titleLabel.textColor = customWhite;
    greenBtn.layer.cornerRadius = 5.0;
    greenBtn.layer.masksToBounds = YES;
    [greenBtn setTitle:btnTittle forState:UIControlStateNormal];
    [greenBtn addTarget:self action:@selector(butnClick) forControlEvents:UIControlEventTouchUpInside];
    [greenBtn setImage:[[UIImage imageNamed:iconName] imageByScalingToSize:CGSizeMake(15, 15)] forState:UIControlStateNormal];
    greenBtn.backgroundColor = [UIColor colorWithRed:.2078 green:.7568 blue:.447 alpha:.8];
    [greenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.bottom.mas_equalTo(parent.view).offset(-15 * autoSizeScaleH);
        make.height.mas_equalTo(40 * autoSizeScaleH);
        make.width.mas_equalTo(SCREEN_WIDTH - 30 * autoSizeScaleW);
    }];
    
}

- (void)butnClick {
    if (_greenButnBlock) {
        _greenButnBlock();
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
