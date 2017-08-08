//
//  MKCopyBoard.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKCopyBoard.h"

#define holderColor [UIColor hexStringToColor:@"#DBDADB"]

@implementation MKCopyBoard
{
    UIImageView *copyIcon;
    UILabel *copyTittle;
    UIView *grayView;
    UITextView *copyView;
    UIImageView *errorView;
    UIView *signView;
    UILabel *infoLab;
    UILabel *instanceLab;
    UIButton *clearButn;
    UIButton *fillButn;
    
    NSString *placeHolder;
    MASConstraint *topConstraint;
}

- (void)CreatView {
    copyIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"enorderClip"]];
    copyTittle = [[UILabel alloc] init];
    grayView = [[UIView alloc] init];
    copyView = [[UITextView alloc] init];
    signView = [[UIView alloc] init];
    errorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"enorderNote"]];
    infoLab = [[UILabel alloc] init];
    instanceLab = [[UILabel alloc] init];
    clearButn = [[UIButton alloc] init];
    fillButn = [[UIButton alloc] init];
    
    [self addSubview:copyIcon];
    [self addSubview:copyTittle];
    [self addSubview:grayView];
    [grayView addSubview:copyView];
    [self addSubview:signView];
    [signView addSubview:errorView];
    [signView addSubview:infoLab];
    [signView addSubview:instanceLab];
    [self addSubview:clearButn];
    [self addSubview:fillButn];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    self.backgroundColor = customWhite;
    
    [copyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.top.mas_equalTo(ws).offset(15 * autoSizeScaleH);
        make.width.height.mas_equalTo(18 * autoSizeScaleW);
    }];
    
    copyTittle.text = @"剪贴板";
    copyTittle.font = FONT(15);
    copyTittle.textColor = [UIColor hexStringToColor:@"#4A4A4A"];
    [copyTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(copyIcon.mas_right).offset(5 * autoSizeScaleW);
        make.centerY.mas_equalTo(copyIcon);
    }];
    
    grayView.backgroundColor = [UIColor hexStringToColor:@"#FAFAFA"];
    grayView.borderWidth = 1.0;
    grayView.borderColor = [UIColor hexStringToColor:@"#F6F6F6"];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(copyIcon);
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.top.mas_equalTo(copyIcon.mas_bottom).offset(10 * autoSizeScaleH);
        make.height.mas_equalTo(100 * autoSizeScaleH);
    }];
    
    placeHolder = @"粘贴整段地址，只能匹配填入姓名、电话和地址";
    copyView.font = FONT(14);
    copyView.delegate = self;
    copyView.textColor = holderColor;
    copyView.text = placeHolder;
    copyView.backgroundColor = [UIColor clearColor];
    [copyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(grayView).offset(5 * autoSizeScaleW);
        make.right.mas_equalTo(grayView).offset(-5 * autoSizeScaleW);
        make.center.height.mas_equalTo(grayView);
    }];
    
    signView.hidden = YES;
    [signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(grayView);
        make.top.mas_equalTo(grayView.mas_bottom).offset(10 * autoSizeScaleH);
        make.bottom.mas_equalTo(instanceLab).offset(15 * autoSizeScaleH);
    }];
    
    [errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(signView);
        make.width.height.mas_equalTo(15 * autoSizeScaleW);
    }];
    
    infoLab.text = @"未成功提取到手机信息，请按照如下格式调整输入内容";
    infoLab.font = FONT(10);
    infoLab.textColor = [UIColor hexStringToColor:@"#ff0000"];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(errorView.mas_right).offset(5 * autoSizeScaleW);
        make.centerY.mas_equalTo(errorView);
    }];
    
    instanceLab.text = @"例：张三，18288888888，广东省深圳市南山区XX街道XX号";
    instanceLab.font = FONT(10);
    instanceLab.textColor = [UIColor hexStringToColor:@"#ff0000"];
    [instanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(infoLab);
        make.top.mas_equalTo(infoLab.mas_bottom).offset(10 * autoSizeScaleH);
    }];
    
    [clearButn addTarget:self action:@selector(clearContent) forControlEvents:UIControlEventTouchUpInside];
    [clearButn setTitle:@"清空" forState:UIControlStateNormal];
    [clearButn setTitleColor:[UIColor hexStringToColor:@"#A8A9AB"] forState:UIControlStateNormal];
    clearButn.backgroundColor = [UIColor hexStringToColor:@"#F3F4F6"];
    clearButn.titleLabel.font = FONT(14);
    clearButn.layer.masksToBounds = YES;
    clearButn.layer.cornerRadius = 5.0;
    [clearButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(fillButn.mas_left).offset(rightPadding);
        make.size.centerY.mas_equalTo(fillButn);
    }];


    [fillButn setTitle:@"智能填单" forState:UIControlStateNormal];
    fillButn.backgroundColor = themeGreen;
    fillButn.titleLabel.textColor = customWhite;
    fillButn.titleLabel.font = FONT(14);
    fillButn.layer.masksToBounds = YES;
    fillButn.layer.cornerRadius = 5.0;
    [fillButn addTarget:self action:@selector(fillOrder) forControlEvents:UIControlEventTouchUpInside];
    [fillButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(grayView);
        topConstraint = make.top.mas_equalTo(grayView.mas_bottom).offset(15 * autoSizeScaleH);
//        make.top.mas_equalTo(signView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(85 * autoSizeScaleW, 35 * autoSizeScaleH));
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(fillButn).offset(15 * autoSizeScaleH);
    }];
    
}

- (void)clearContent {
    copyView.text = @"";
    copyView.text = placeHolder;
    copyView.textColor = holderColor;
}

- (void)fillOrder {
    if ([copyView.text isEqualToString:placeHolder]) {
        [topConstraint uninstall];
        [fillButn mas_makeConstraints:^(MASConstraintMaker *make) {
            topConstraint = make.top.mas_equalTo(signView.mas_bottom);
        }];
        UIViewController *parent = [self parentController];
        [UIView animateWithDuration:.3 animations:^{
            [parent.view layoutIfNeeded];
        }completion:^(BOOL finished) {
            signView.hidden = NO;
        }];
        return;
    }
    if (_fillClickBlock) {
        _fillClickBlock(copyView.text);
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:placeHolder]) {
        textView.text = @"";
        textView.textColor = wordThreeColor;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(textView.text.length < 1) {
        textView.text = placeHolder;
        textView.textColor = holderColor;
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
