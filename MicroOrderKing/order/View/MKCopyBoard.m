//
//  MKCopyBoard.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/28.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKCheckFormController.h"
#import "BaseViewController.h"

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
    UILabel *formLab;
    UILabel *signLab;   //提示如何进行智能匹配
    
    NSString *placeHolder;
    MASConstraint *topConstraint;
    NSArray *matchedArray;
    NSArray *saparatArra;
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
    formLab = [[UILabel alloc] init];
    signLab = [[UILabel alloc] init];
    
    [self addSubview:copyIcon];
    [self addSubview:copyTittle];
    [self addSubview:grayView];
    [grayView addSubview:copyView];
    [self addSubview:signView];
    [signView addSubview:errorView];
    [signView addSubview:infoLab];
    [signView addSubview:instanceLab];
    [signView addSubview:formLab];
    [self addSubview:clearButn];
    [self addSubview:fillButn];
    [self addSubview:signLab];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    saparatArra = @[@",",@"，",@"。",@"！",@"!",@" "];
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
    
    signLab.text = @"输入手机号，点击完成或空白处可进行智能匹配";
    signLab.font = FONT(12);
    signLab.textColor = wordSixColor;
    signLab.hidden = YES;
    signLab.alpha = 0;
    [signLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(copyIcon.mas_bottom).offset(5 * autoSizeScaleH);
        make.left.mas_equalTo(copyIcon);
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
    
    placeHolder = @"粘贴整段地址，智能匹配填入姓名、电话和地址";
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
        make.bottom.mas_equalTo(infoLab).offset(15 * autoSizeScaleH);
    }];
    
    [errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(signView);
        make.width.height.mas_equalTo(15 * autoSizeScaleW);
    }];
    
    //infoLab.text = @"未匹配到相应的会员，请自行输入用户信息";
    infoLab.font = FONT(12);
    infoLab.textColor = [UIColor hexStringToColor:@"#ff0000"];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(errorView.mas_right).offset(5 * autoSizeScaleW);
        make.centerY.mas_equalTo(errorView);
    }];
    
    instanceLab.hidden = YES;
    instanceLab.text = @"例：张三，18288888888，广东省深圳市南山区XX街道XX号";
    instanceLab.font = FONT(12);
    instanceLab.textColor = [UIColor hexStringToColor:@"#ff0000"];
    [instanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(infoLab);
        make.top.mas_equalTo(infoLab.mas_bottom).offset(10 * autoSizeScaleH);
    }];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"查看支持格式"];
    NSRange range = NSMakeRange(0, attr.length);
    
    [attr addAttribute:NSFontAttributeName value:FONT(12) range:range];
    [attr addAttribute:NSForegroundColorAttributeName value:wordSixColor range:range];
    [attr addAttribute:NSUnderlineColorAttributeName value:wordSixColor range:range];
    [attr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    
    formLab.attributedText = attr;
    formLab.userInteractionEnabled = YES;
    formLab.hidden = YES;
    [formLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToCheckForm:)]];
    [formLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(grayView);
        make.centerY.mas_equalTo(errorView);
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



- (void)goToCheckForm:(UITapGestureRecognizer *)tap {
    MKCheckFormController *controller = [[MKCheckFormController alloc] initWithTitle:@"查看支持格式"];
    UIViewController *parent = [self parentController];
    [parent.navigationController pushViewController:controller animated:YES];
}

- (void)clearContent {
    copyView.text = @"";
    copyView.text = placeHolder;
    copyView.textColor = holderColor;
}

- (void)setText:(NSString *)content {
    copyView.text = content;
    copyView.textColor = wordThreeColor;
}

- (void)fillOrder {
    BaseViewController *parent = (BaseViewController *)[self parentController];
    if ([copyView.text isEqualToString:placeHolder]) {
        [parent.hud showTipMessageAutoHide:@"请先输入内容在进行智能填单"];
        return;
    }
    
    matchedArray = @[];
    [self getPhoneNumber:copyView.text];
    if (!matchedArray.count) {
        formLab.hidden = NO;
        [self showSignContentWithSign:@"识别失败，请修改文本格式或自行填入内容"];
        return;
    }
    NSArray *resultArray = @[];
    NSString *phoneNum = matchedArray[0];
    //有分隔符
    for (NSString *separator in saparatArra) {
        if ([copyView.text containsString:separator]) {
            NSArray *result = [copyView.text componentsSeparatedByString:separator];
            NSString *str1,*str2;
            NSInteger count = 0;
            if (result.count != 3) {
                continue;
            }
            for (NSString *item in result) {    //赋值
                if (![item isEqualToString:phoneNum]) {
                    if (!count) {
                        str1 = item;
                        count ++;
                    }else{
                        str2 = item;
                    }
                }
            }
            //最后数组按  名字 号码 地址  的顺序排
            resultArray = str1.length < str2.length ? @[str1,phoneNum,str2] : @[str2,phoneNum,str1];
        }
    }
    
    if (!resultArray.count) {
        //无分隔符
        NSArray *result = [copyView.text componentsSeparatedByString:phoneNum];
        if (result.count != 2) {
            resultArray = @[phoneNum];
        }else{
            NSString *str1,*str2;
            str1 = result[0]; str2 = result[1];
            //最后数组按  名字 号码 地址  的顺序排
            resultArray = str1.length < str2.length ? @[str1,phoneNum,str2] : @[str2,phoneNum,str1];
        }
    }
    
    formLab.hidden = YES;
    [self showSignContentWithSign:@"已完成智能填单，如有误差请自行调整"];
    
    if (_autoFillBlock) {
        _autoFillBlock(resultArray);
    }
    
}

- (void)showSignContentWithSign:(NSString *)signStr {
    
    infoLab.text = signStr;
    
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
}

- (void)getPhoneNumber:(NSString *)checkString {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    //NSString * MOBILE = @"1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    //NSString * CM = @"1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    //NSString * CU = @"1(3[0-2]|5[256]|8[56])\\d{8}";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    //NSString * CT = @"1((33|53|8[09])[0-9]|349)\\d{7}";
    
//    [self getPhoneNum:checkString regexStr:MOBILE];
//    [self getPhoneNum:checkString regexStr:CM];
//    [self getPhoneNum:checkString regexStr:CU];
//    [self getPhoneNum:checkString regexStr:CT];
    
    NSString *finalCheckStr = @"1[3|4|5|8][0-9]\\d{8}";
    [self getPhoneNum:checkString regexStr:finalCheckStr];
    

}

- (void)getPhoneNum:(NSString *)phoneNum regexStr:(NSString *)regexStr {
    NSArray *arra = [self matchString:phoneNum toRegexString:regexStr];
    if (arra.count > 0) {
        matchedArray = arra;
    }
}

- (NSArray *)matchString:(NSString *)string toRegexString:(NSString *)regexStr {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray * matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    //match: 所有匹配到的字符,根据() 包含级
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSTextCheckingResult *match in matches) {
        
        for (int i = 0; i < [match numberOfRanges]; i++) {
            //以正则中的(),划分成不同的匹配部分
            NSString *component = [string substringWithRange:[match rangeAtIndex:i]];
            
            [array addObject:component];
            
        }
        
    }
    
    return array;
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
    }else{
        matchedArray = @[];
        [self getPhoneNumber:copyView.text];
        if ([copyView.text isEqualToString:placeHolder]||!matchedArray.count) {
            formLab.hidden = YES;
            [self showSignContentWithSign:@"未匹配到相应会员，可选择智能填单"];
            return;
        }
        if (_fillClickBlock) {
            if (matchedArray.count > 0) {
                LxDBAnyVar(matchedArray[0]);
                _fillClickBlock(matchedArray[0]);
            }
        }

    }
}

// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"1(3[0-2]|5[256]|8[56])\\d{8}";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"1((33|53|8[09])[0-9]|349)\\d{7}";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        if([regextestcm evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    else
    {
        return NO;
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
