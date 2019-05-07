//
//  MKFilterView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 2017/9/23.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKFilterView.h"

@implementation MKFilterView
{
    MKFilterItemView *_statusView;
    MKFilterItemView *_methodView;
    UIView *lineView;
    UIButton *cancelButn;
    UIButton *confirmButn;
}

- (void)CreatView {
    
    _statusView = [[MKFilterItemView alloc] initWithTitle:@"付款状态选择" AndButnTitles:@[@"全部",@"已付款",@"未付款"]];
    _methodView = [[MKFilterItemView alloc] initWithTitle:@"配送方式选择" AndButnTitles:@[@"全部",@"同城配送",@"快递配送",@"商家自配送",@"用户自提"]];
    _timeView = [[MKFilterTimeView alloc] init];
    lineView = [[UIView alloc] init];
    cancelButn = [[UIButton alloc] init];
    confirmButn = [[UIButton alloc] init];
    
    [self addSubview:_statusView];
    [self addSubview:_methodView];
    [self addSubview:_timeView];
    [self addSubview:lineView];
    [self addSubview:cancelButn];
    [self addSubview:confirmButn];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    self.backgroundColor = customWhite;
    
    [_statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws);
        make.top.mas_equalTo(ws).offset(20 * autoSizeScaleH);
    }];
    
    [_methodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws);
        make.top.mas_equalTo(_statusView.mas_bottom);
    }];
    
    [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws);
        make.top.mas_equalTo(_methodView.mas_bottom).offset(10 * autoSizeScaleH);
    }];

    [confirmButn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButn setTitleColor:customWhite forState:UIControlStateNormal];
    [confirmButn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    confirmButn.titleLabel.font = FONT(14);
    confirmButn.backgroundColor = themeGreen;
    [confirmButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws);
        make.top.mas_equalTo(_timeView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2, 45 * autoSizeScaleH));
    }];
    
    lineView.backgroundColor = [UIColor hexStringToColor:@"#F6F6F6"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(confirmButn);
        make.left.mas_equalTo(ws);
        make.width.mas_equalTo(ws).multipliedBy(.5);
        make.height.mas_equalTo(1);
    }];
    
    [cancelButn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButn setTitleColor:[UIColor hexStringToColor:@"#8E8E8E"] forState:UIControlStateNormal];
    [cancelButn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    cancelButn.titleLabel.font = FONT(14);
    [cancelButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(lineView);
        make.top.mas_equalTo(lineView.mas_bottom);
        make.size.mas_equalTo(confirmButn);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(confirmButn);
    }];

}

- (void)confirmClick {
    if (_filterCanfirmBlock) {
        _filterCanfirmBlock(_statusView.selectIndex,_methodView.selectIndex);
    }
}

- (void)cancelClick {
    if (_filterCancelBlock) {
        _filterCancelBlock();
    }
}

@end

@implementation MKFilterTimeView
{
    UILabel *titleLab;
    UIButton *startButn;
    UIButton *endButn;
    UIView *lineView;
    
    NSMutableArray *butnArray;
}

- (void)CreatView {
    
    titleLab = [[UILabel alloc] init];
    startButn = [[UIButton alloc] init];
    endButn = [[UIButton alloc] init];
    lineView = [[UIView alloc] init];
    
    [self addSubview:titleLab];
    [self addSubview:startButn];
    [self addSubview:endButn];
    [self addSubview:lineView];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    butnArray = [[NSMutableArray alloc] initWithObjects:startButn,endButn, nil];
    
    titleLab.text = @"发货时间选择";
    titleLab.font = FONT(14);
    titleLab.textColor = wordSixColor;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.top.mas_equalTo(ws);
    }];
    
    UIColor *titleColor = [UIColor hexStringToColor:@"#ACACAC"];
    [startButn setTitle:@"开始时间选择" forState:UIControlStateNormal];
    [startButn setTitleColor:titleColor forState:UIControlStateNormal];
    [startButn addTarget:self action:@selector(timeButnClick:) forControlEvents:UIControlEventTouchUpInside];
    startButn.titleLabel.font = FONT(12);
    startButn.layer.cornerRadius = 5.0;
    startButn.backgroundColor = [UIColor hexStringToColor:@"#F4F4F4"];
    [startButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10 * autoSizeScaleH);
        make.size.mas_equalTo(CGSizeMake(140 * autoSizeScaleW, 35 * autoSizeScaleH));
    }];
    
    lineView.backgroundColor = [UIColor hexStringToColor:@"#DADADA"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(startButn.mas_right).offset(10 * autoSizeScaleW);
        make.centerY.mas_equalTo(startButn);
        make.size.mas_equalTo(CGSizeMake(20 * autoSizeScaleW, 2 * autoSizeScaleH));
    }];
    
    [endButn setTitle:@"结束时间选择" forState:UIControlStateNormal];
    [endButn setTitleColor:titleColor forState:UIControlStateNormal];
    [endButn addTarget:self action:@selector(timeButnClick:) forControlEvents:UIControlEventTouchUpInside];
    endButn.titleLabel.font = FONT(12);
    endButn.layer.cornerRadius = 5.0;
    endButn.backgroundColor = [UIColor hexStringToColor:@"#F4F4F4"];
    [endButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_right).offset(10 * autoSizeScaleW);
        make.size.centerY.mas_equalTo(startButn);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(startButn).offset(20 * autoSizeScaleH);
    }];
    
}

- (void)timeButnClick:(UIButton *)sender {
    
    NSInteger index = [butnArray indexOfObject:sender];
    if (_timeButnBlock) {
        _timeButnBlock(index);
    }
}

- (void)setTimeContentWithStart:(NSString *)start End:(NSString *)end {
    
    //[startButn setTitle:@"hahaha" forState:UIControlStateNormal];
    if (start != nil && start.length > 0) {
        [startButn setTitle:start forState:UIControlStateNormal];
        [self setSelectStyle:startButn];
    }
    if (end != nil && end.length > 0) {
        [endButn setTitle:end forState:UIControlStateNormal];
        [self setSelectStyle:endButn];
    }

}

- (void)setSelectStyle:(UIButton *)butn {

    butn.layer.borderColor = themeGreen.CGColor;
    butn.layer.borderWidth = 1.0;
    [butn setTitleColor:themeGreen forState:UIControlStateNormal];
    butn.backgroundColor = customWhite;
    
}


@end

@implementation MKFilterItemView
{
    UILabel *titleLab;

    NSArray *_butnTitles;
    NSMutableArray *butnArray;
    NSString *_title;
}

- (instancetype)initWithTitle:(NSString *)title AndButnTitles:(NSArray *)butnTitles {

    _title = title;
    _butnTitles = butnTitles;
    
    self = [super init];
    return self;
}

- (void)CreatView {

    WS(ws)
    
    _selectIndex = 0;
    self.backgroundColor = customWhite;
    butnArray = [[NSMutableArray alloc] init];
    
    titleLab = [[UILabel alloc] init];
    titleLab.text = _title;
    titleLab.font = FONT(14);
    titleLab.textColor = wordSixColor;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.top.mas_equalTo(ws);
    }];
    
    UIView *firstView,*lastView;
    for (int i = 0; i < _butnTitles.count; i ++) {
        UIButton *butn = [[UIButton alloc] init];
        
        [self addSubview:butn];
        [butnArray addObject:butn];
        
        [butn setTitle:_butnTitles[i] forState:UIControlStateNormal];
        [butn addTarget:self action:@selector(choiceButnClick:) forControlEvents:UIControlEventTouchUpInside];
        butn.titleLabel.font = FONT(12);
        butn.layer.masksToBounds = YES;
        butn.layer.cornerRadius = 5.0;
        if (!i) {
            butn.layer.borderColor = themeGreen.CGColor;
            butn.layer.borderWidth = 1.0;
            [butn setTitleColor:themeGreen forState:UIControlStateNormal];
            butn.backgroundColor = customWhite;
        } else {
            butn.layer.borderWidth = 0;
            butn.layer.borderColor = [UIColor clearColor].CGColor;
            [butn setTitleColor:[UIColor hexStringToColor:@"#545454"] forState:UIControlStateNormal];
            butn.backgroundColor = [UIColor hexStringToColor:@"#F4F4F4"];
        }
        
        if (!i) {
            firstView = butn;
        }
        
        [butn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(75 * autoSizeScaleW, 30 * autoSizeScaleH));
            if (i >= 4) {
                make.top.mas_equalTo(firstView.mas_bottom).offset(10 * autoSizeScaleH);
                make.left.mas_equalTo(titleLab);
            }else{
                make.top.mas_equalTo(titleLab.mas_bottom).offset(10 * autoSizeScaleH);
                if (!i) {
                    make.left.mas_equalTo(titleLab);
                } else {
                    make.left.mas_equalTo(lastView.mas_right).offset(10 * autoSizeScaleW);
                }
            }
        }];
        
        lastView = butn;
    }
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lastView).offset(25 * autoSizeScaleH);
    }];
}

- (void)choiceButnClick:(UIButton *)sender {
    
    NSInteger selectIndex = [butnArray indexOfObject:sender];
    _selectIndex = selectIndex;
    for (UIButton *butn in butnArray) {
        NSInteger index = [butnArray indexOfObject:butn];
        if (index == selectIndex) {
            butn.layer.borderColor = themeGreen.CGColor;
            butn.layer.borderWidth = 1.0;
            [butn setTitleColor:themeGreen forState:UIControlStateNormal];
            butn.backgroundColor = customWhite;
        } else {
            butn.layer.borderWidth = 0;
            butn.layer.borderColor = [UIColor clearColor].CGColor;
            [butn setTitleColor:[UIColor hexStringToColor:@"#545454"] forState:UIControlStateNormal];
            butn.backgroundColor = [UIColor hexStringToColor:@"#F4F4F4"];
        }
    }
}

@end
