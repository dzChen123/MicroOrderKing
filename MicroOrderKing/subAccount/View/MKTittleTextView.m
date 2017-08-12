//
//  MKTittleTextView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKTittleTextView.h"

#define holderColor [UIColor hexStringToColor:@"#D7D7D8"]

@implementation MKTittleTextView
{
    UILabel *tittleLab;
    UIView *whiteView;
    UITextField *writeField;
    UITextView *writeView;
    UIButton *closeButn;
    
    MKTextViewModel *textModel;

}

- (instancetype)initWithModel:(id)model{
    textModel = (MKTextViewModel *)model;
    self = [super init];
    return self;
}

- (void)CreatView {
    tittleLab = [[UILabel alloc] init];
    whiteView = [[UIView alloc] init];
    writeField = [[UITextField alloc] init];
    writeView = [[UITextView alloc] init];
    closeButn = [[UIButton alloc] init];

    [textModel.superView addSubview:self];
    [self addSubview:tittleLab];
    [self addSubview:whiteView];
    [textModel.superView addSubview:closeButn];
    [textModel.superView addSubview:writeField];
    [textModel.superView addSubview:writeView];
    
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    _text = @"";
    
    if (!textModel.tittle) {
        [tittleLab removeFromSuperview];
    }else{
        tittleLab.text = textModel.tittle;
        tittleLab.font = FONT(12);
        tittleLab.textColor = [UIColor hexStringToColor:@"#B5B6B8"];
        [tittleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws).offset(25 * autoSizeScaleH);
            make.left.mas_equalTo(ws).offset(leftPadding);
        }];
    }
    
    whiteView.backgroundColor = customWhite;
    whiteView.layer.cornerRadius = 5.0;
    whiteView.layer.masksToBounds = YES;
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.right.mas_equalTo(ws).offset(rightPadding);
        if (!textModel.tittle) {
            make.top.mas_equalTo(ws);
        }else{
            make.top.mas_equalTo(tittleLab.mas_bottom).offset(10 * autoSizeScaleH);
        }
        make.height.mas_equalTo( textModel.type == 0 ? 45 * autoSizeScaleH : textModel.whiteHeight);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(whiteView);
    }];
    
    if (!textModel.type) {
        writeField.placeholder = textModel.placeHolder;
        writeField.font = FONT(14);
        writeField.textColor = [UIColor hexStringToColor:@"#5A5A5A"];
        if (textModel.isNumberPod) {
            writeField.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (textModel.isPasd) {
            writeField.secureTextEntry = YES;
        }
        writeField.delegate = self;
        writeField.clearButtonMode = UITextFieldViewModeAlways;
        [writeField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
        [writeField setValue:holderColor forKeyPath:@"_placeholderLabel.textColor"];
        [writeField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(whiteView).offset(10 * autoSizeScaleW);
            make.right.mas_equalTo(whiteView).offset(rightPadding);
            make.height.centerY.mas_equalTo(whiteView);
        }];
        
        [closeButn removeFromSuperview];
        [writeView removeFromSuperview];
    }else{
        
        if (textModel.type == 2) {
            [closeButn setImage:[[UIImage imageNamed:@"addMemDel"] imageByScalingToSize:CGSizeMake(20 * autoSizeScaleW, 20 * autoSizeScaleW)] forState:UIControlStateNormal];
            [closeButn addTarget:self action:@selector(closeButnClick) forControlEvents:UIControlEventTouchUpInside];
            [closeButn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(whiteView).offset(10 * autoSizeScaleH);
                make.right.mas_equalTo(whiteView).offset(-10 * autoSizeScaleH);
                make.width.height.mas_equalTo(20 * autoSizeScaleW);
            }];
        }
        
        writeView.delegate = self;
        writeView.text = textModel.placeHolder;
        writeView.textColor = holderColor;
        writeView.font = FONT(14);
        [writeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(whiteView).offset(5 * autoSizeScaleW);
            make.right.mas_equalTo(whiteView).offset(-5 * autoSizeScaleW);
            make.centerY.height.mas_equalTo(whiteView);
        }];
        
        [writeField removeFromSuperview];
    }
}

- (UITextView *)getTextView {
    return writeView;
}

- (UIButton *)getCloseButn {
    return closeButn;
}

- (void)closeButnClick {
    [writeView removeFromSuperview];
    [closeButn removeFromSuperview];
    if (_closeClickblock) {
        _closeClickblock(self);
    }
}

- (void)CleanText {
    writeView.text = @"";
    writeField.text = @"";
    _text = @"";
}

- (void)SetText:(NSString *)text {
    writeView.text = text;
    writeView.textColor = wordThreeColor;
    writeField.text = text;
    _text = text;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:textModel.placeHolder]) {
        textView.text = @"";
        textView.textColor = wordThreeColor;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(textView.text.length < 1) {
        textView.text = textModel.placeHolder;
        textView.textColor = holderColor;
    }else{
        _text = textView.text;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _text = textField.text;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_isNumber) {
        return [self validateNumber:string];
    }
    return YES;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


@end

@implementation MKTextViewModel

@end
