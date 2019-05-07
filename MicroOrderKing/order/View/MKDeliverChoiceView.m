//
//  MKDeliverChoiceView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 2017/9/22.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKDeliverChoiceView.h"

@implementation MKDeliverChoiceView
{
    NSMutableArray *butnArray;
    NSMutableArray *titleArray;
    
    NSInteger _choice;
    
}

- (instancetype)initWithChoice:(NSInteger)choice {

    _choice = choice;
    butnArray = [[NSMutableArray alloc] init];
    titleArray = [[NSMutableArray alloc] initWithObjects:@"同城配送",@"快递配送",@"商家自配送",@"用户自提", nil];
    
    self = [super init];
    
    return self;
}

- (void)CreatView {     //创建和布局不好分割  就写一块了
    
    
    WS(ws)
    
    self.backgroundColor = customWhite;
    
    UIButton *confirmButn = [[UIButton alloc] init];
    [self addSubview:confirmButn];
    confirmButn.backgroundColor = [UIColor clearColor];
    [confirmButn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButn addTarget:self action:@selector(confirmButnClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmButn setTitleColor:[UIColor hexStringToColor:@"#476288"] forState:UIControlStateNormal];
    confirmButn.titleLabel.font = FONT(15);
    [confirmButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(60 * autoSizeScaleW, 40 * autoSizeScaleH));
    }];
    
    UIView *lastView = confirmButn;
    for (int i = 0; i < titleArray.count; i ++) {
        
        UIView *lineView = [[UIView alloc] init];
        UIButton *butn = [[UIButton alloc] init];
        
        [self addSubview:lineView];
        [self addSubview:butn];
        
        lineView.backgroundColor = VIEWBACKGRAY;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(ws);
            make.top.mas_equalTo(lastView.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        
        [butnArray addObject:butn];
        [butn addTarget:self action:@selector(choiceButnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [butn setTitleColor:i == _choice ? themeGreen : wordThreeColor forState:UIControlStateNormal];
        [butn setTitle:titleArray[i] forState:UIControlStateNormal];
        butn.titleLabel.font = FONT(15);
        [butn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(ws);
            make.top.mas_equalTo(lineView.mas_bottom);
            make.height.mas_equalTo(45 * autoSizeScaleH);
        }];
        
        lastView = butn;
        
    }
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lastView);
    }];
    
}

- (void)choiceButnCLick:(UIButton *)sender {

    NSInteger selectIndex = [butnArray indexOfObject:sender];
    
    for (UIButton *butn in butnArray) {
        NSInteger index = [butnArray indexOfObject:butn];
        [butn setTitleColor:index == selectIndex ? themeGreen : wordThreeColor forState:UIControlStateNormal];
    }
    
    _choice = selectIndex;
}

- (void)confirmButnClick {
    
    if (_deliverItemBlock) {
        _deliverItemBlock(titleArray[_choice]);
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
