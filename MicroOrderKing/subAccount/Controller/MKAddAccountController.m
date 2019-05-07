//
//  MKAddAccountController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAddAccountController.h"

#import "MKTittleTextView.h"

#import "MKAccountBaseModel.h"

@interface MKAddAccountController ()

@end

@implementation MKAddAccountController
{
    NSMutableArray *textViewArray;
    UIButton *saveButn;
    NSArray *matchedArray;
    
    NSInteger _type;
    BOOL isEdit;
}

- (instancetype)initWithType:(NSInteger)type {
    _type = type;
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadEditData];
    // Do any additional setup after loading the view.
}

- (void)setTopView {
    [super setTopView];
    if(![self.topTitle isEqualToString:@"分账号编辑"] && ![self.topTitle isEqualToString:@"会员编辑"]){
        self.topTitle = _type == 0 ? @"新增子账户" : @"新增会员";
        isEdit = NO;
    }else{
        isEdit = YES;
    }
}

- (void)CreatView {
    textViewArray = [[NSMutableArray alloc] init];
    NSArray *tittleArra = @[@[@"账号(默认手机号)",@"姓名",@"输入密码",@"确认密码"],
                            @[@"会员号(即收货人联系方式)",@"会员姓名(即收货人姓名)",@"备注",@"收获地址"]];
    NSArray *holderArra = @[@[@"请输入手机号",@"请输入姓名",@"请输入密码",@"请确认密码"],
                            @[@"请输入会员手机号",@"请输入会员姓名",@"写点什么...",@"请输入详细地址信息..."]];
    NSArray *tittles = tittleArra[_type];
    NSArray *holders = holderArra[_type];
    for (int count = 0; count < 4; count ++) {
        MKTextViewModel *model = [[MKTextViewModel alloc] init];
        model.superView = self.view;
        model.type = 0;
        model.tittle = tittles[count];
        model.placeHolder = holders[count];
        if (!_type) {
            model.isNumberPod = count != 1;
            model.isPasd = count > 1 ? YES : NO;
        }else{
            model.isNumberPod = count == 0;
            model.type = count < 2 ? 0 : 1;
            if (count == 2) { model.whiteHeight = 80 * autoSizeScaleH; }
            if (count == 3) { model.whiteHeight = 110 * autoSizeScaleH; }
        }
        MKTittleTextView *textView = [[MKTittleTextView alloc] initWithModel:model];
        textView.isNumber = count == 0 ? YES : NO;
        [textViewArray addObject:textView];
    }
    
    saveButn = [[UIButton alloc] init];
    [self addSubview:saveButn];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    MKTittleTextView *lastView;
    for (int index = 0 ; index < 4; index ++) {
        MKTittleTextView *itemView = textViewArray[index];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!index) {
                make.top.mas_equalTo(ws.topView.mas_bottom);
            }else{
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            make.left.right.mas_equalTo(ws.view);
        }];
        lastView = itemView;
    }
    
    [saveButn setTitle:@"保存" forState:UIControlStateNormal];
    [saveButn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    saveButn.titleLabel.textColor = customWhite;
    saveButn.titleLabel.font = FONT(16);
    saveButn.backgroundColor = themeGreen;
    [saveButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(ws.view);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    
    [super updateViewConstraints];
}

- (void)loadEditData {
    if (isEdit) {
        NSString *requestStr = [NSString stringWithFormat:@"%@/%@/edit",!_type ? @"subaccount" : @"member",_editId];
        NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
        [AFNetWorkingUsing httpGet:requestStr params:plist success:^(id json) {
            if(!_type){
                MKAccountBaseModel *model = [MKAccountBaseModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
                [self setAccountEditionInfo:model];
            }else{
                
            }
        } fail:^(NSError *error) {
            [self.navigationController popViewControllerAnimated:YES];
        } other:^(id json) {
            [self.hud showTipMessageAutoHide:@"编辑信息加载失败"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

- (void)setAccountEditionInfo:(MKAccountBaseModel *)model {
    for (int index = 0; index < 4; index ++) {
        MKTittleTextView *itemView = textViewArray[index];
        switch (index) {
            case 0:
                [itemView SetText:model.phoneNum];
                break;
            case 1:
                [itemView SetText:model.name];
                break;
            default:
                //[itemView SetText:];
                break;
        }
    }
}

- (void)saveClick {
    if(isEdit){
        [self EditAccount];
    }else{
        [self addAccount];
    }
}

- (void)addAccount {
    NSString *requestStr = _type == 0 ? @"subaccount" : @"member";
    NSArray *signStrArras = @[
                            @[@"请输入账号",@"请输入姓名",@"请输入密码",@"请确认密码"],
                            @[@"请输入会员手机号",@"请输入会员姓名",@"",@"请填写收货地址"]
                            ];
    NSArray *signArra = signStrArras[_type];
    NSString *phoneNum,*name,*pasd,*repeat;
    for (int index = 0; index < textViewArray.count; index ++) {
        MKTittleTextView *itemView = textViewArray[index];
        switch (index) {
            case 0:
                phoneNum = itemView.text;
                break;
            case 1:
                name = itemView.text;
                break;
            case 2:
                pasd = itemView.text;
                break;
            case 3:
                repeat = itemView.text;
                break;
            default:
                break;
        }
    }
    if (!phoneNum.length) {
        [self.hud showTipMessageAutoHide:signArra[0]];
        return;
    }
    [self getPhoneNumber:phoneNum];
    if (!matchedArray.count || phoneNum.length != 11) {
        [self.hud showTipMessageAutoHide:@"请输入合法手机号"];
        return;
    }
    if (!name.length) {
        [self.hud showTipMessageAutoHide:signArra[1]];
        return;
    }
    if (!_type && !pasd.length) {
        [self.hud showTipMessageAutoHide:signArra[2]];
        return;
    }
    if (!repeat.length) {
        [self.hud showTipMessageAutoHide:signArra[3]];
        return;
    }
    if (!_type && ![pasd isEqualToString:repeat]) {
        [self.hud showTipMessageAutoHide:@"两次填写的密码不一致,请检查"];
        return;
    }
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:phoneNum forKey:@"mobile"];
    [plist setObject:name forKey: !_type ? @"user_nickname" : @"name"];
    if (!_type || (_type == 1 && pasd.length)) {
        [plist setObject:pasd forKey: !_type ? @"password" : @"remark"];
    }
    if (!_type) {
        [plist setObject:repeat forKey:@"repassword"];
    }else{
        [plist setObject:@[repeat] forKey:@"address"];
    }
    [self.hud showWaitHudWithMessage:@"请稍后"];
    [AFNetWorkingUsing httpPost:requestStr params:plist success:^(id json) {
        [self.hud hideAnimated:YES];
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
        for (MKTittleTextView *itemView in textViewArray) {
            [itemView CleanText];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        [self.hud hideAnimated:YES];
    } other:^(id json) {
        [self.hud hideAnimated:YES];
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)EditAccount {
    NSString *requestStr = [NSString stringWithFormat:@"%@/%@", !_type ? @"subaccount" : @"member",_editId];
    NSArray *signStrArras = @[
                              @[@"请输入账号",@"请输入姓名",@"",@""],
                              @[@"请输入会员手机号",@"请输入会员姓名",@"",@"请填写收货地址"]
                              ];
    NSArray *signArra = signStrArras[_type];
    NSString *phoneNum,*name,*pasd,*repeat;
    for (int index = 0; index < textViewArray.count; index ++) {
        MKTittleTextView *itemView = textViewArray[index];
        switch (index) {
            case 0:
                phoneNum = itemView.text;
                break;
            case 1:
                name = itemView.text;
                break;
            case 2:
                pasd = itemView.text;
                break;
            case 3:
                repeat = itemView.text;
                break;
            default:
                break;
        }
    }
    if (!phoneNum.length) {
        [self.hud showTipMessageAutoHide:signArra[0]];
        return;
    }
    [self getPhoneNumber:phoneNum];
    if (!matchedArray.count || phoneNum.length != 11) {
        [self.hud showTipMessageAutoHide:@"请输入合法手机号"];
        return;
    }
    if (!name.length) {
        [self.hud showTipMessageAutoHide:signArra[1]];
        return;
    }
    if (!pasd.length) {
        [self.hud showTipMessageAutoHide:@"请填写新密码"];
        return;
    }
    if (!repeat.length) {
        [self.hud showTipMessageAutoHide:@"请填写确认密码"];
        return;
    }
    if (![pasd isEqualToString:repeat]) {
        [self.hud showTipMessageAutoHide:@"填写的密码不一致!"];
        return;
    }
    if (pasd.length < 6 || pasd.length > 12) {
        [self.hud showTipMessageAutoHide:@"密码长度限制为6-12"];
        return;
    }
//    if (_type) {
//        if (!repeat.length) {
//            [self.hud showTipMessageAutoHide:signArra[3]];
//            return;
//        }
//    }
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:phoneNum forKey:@"mobile"];
    [plist setObject:name forKey:@"user_nickname"];
    [plist setObject:pasd forKey:@"password"];
    [plist setObject:repeat forKey:@"repassword"];
//    if (_type) {
//
//    }
    [self.hud showWaitHudWithMessage:@"请稍后"];
    [AFNetWorkingUsing httpPut:requestStr params:plist success:^(id json) {
        [self.hud hideAnimated:YES];
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        [self.hud hideAnimated:YES];
    } other:^(id json) {
        [self.hud hideAnimated:YES];
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
