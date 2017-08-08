//
//  MKEditAddreController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/5.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKEditAddreController.h"

#import "MKMemberBaseModel.h"

#define holderColor [UIColor hexStringToColor:@"#D7D7D8"]

@interface MKEditAddreController ()<UITextViewDelegate>

@end

@implementation MKEditAddreController
{
    UILabel *titleLab;
    UIView *whiteView;
    UITextView *writeView;
    UIButton *deleteButn;
    UIButton *saveButn;
    
    NSInteger _type;
    NSString *address;
    NSString *oldAddre;
}

- (instancetype)initWithType:(NSInteger)type {
    _type = type;
    self = [super init];
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_type) {
        [self loadAddress];
    }

}

- (void)setTopView {
    [super setTopView];
    self.topTitle = _type ? @"编辑地址" : @"新增地址";
}

- (void)CreatView {
    address = @"";
    
    titleLab = [[UILabel alloc] init];
    whiteView = [[UIView alloc] init];
    writeView = [[UITextView alloc] init];
    deleteButn = [[UIButton alloc] init];
    saveButn = [[UIButton alloc] init];
    
    [self addSubview:titleLab];
    [self addSubview:whiteView];
    [self addSubview:writeView];
    [self addSubview:deleteButn];
    [self addSubview:saveButn];
    
    writeView.delegate = self;
    writeView.text = @"请输入详细地址信息...";
    writeView.textColor = holderColor;
    writeView.font = FONT(14);
    
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    titleLab.text = @"收货地址";
    titleLab.font = FONT(15);
    titleLab.textColor = [UIColor hexStringToColor:@"#B5B6B8"];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).offset(leftPadding);
        make.top.mas_equalTo(ws.topView.mas_bottom).offset(25 * autoSizeScaleH);
    }];
    
    whiteView.backgroundColor = customWhite;
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10 * autoSizeScaleH);
        make.height.mas_equalTo(150 * autoSizeScaleH);
    }];
    

    //[textModel.superView bringSubviewToFront:writeView];
    [writeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(whiteView).offset(10 * autoSizeScaleW);
        make.right.mas_equalTo(whiteView).offset(-5 * autoSizeScaleW);
        make.centerY.height.mas_equalTo(whiteView);
    }];
    
    if (_type) {
        deleteButn.backgroundColor = customWhite;
        [deleteButn setTitle:@"删除地址" forState:UIControlStateNormal];
        [deleteButn addTarget:self action:@selector(deleteAddress) forControlEvents:UIControlEventTouchUpInside];
        [deleteButn setTitleColor:[UIColor hexStringToColor:@"#F77787"] forState:UIControlStateNormal];
        deleteButn.titleLabel.font = FONT(15);
        deleteButn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        deleteButn.titleEdgeInsets = UIEdgeInsetsMake(0, 15 * autoSizeScaleW , 0, 0);
        [deleteButn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(whiteView);
            make.top.mas_equalTo(whiteView.mas_bottom).offset(20 * autoSizeScaleH);
            make.height.mas_equalTo(45 * autoSizeScaleH);
        }];
    }else{
        [deleteButn removeFromSuperview];
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

- (void)saveClick {
    if (_type) {
        [self editAddress];
    }else{
        [self addAddress];
    }
}

- (void)addAddress {
    if (!address.length) {
        [self.hud showTipMessageAutoHide:@"请输入地址"];
        return;
    }
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:address forKey:@"address"];
    [plist setObject:_memberId forKey:@"member_id"];
    [AFNetWorkingUsing httpPost:@"address" params:plist success:^(id json) {
        [self.hud showTipMessageAutoHide:@"地址添加成功"];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)editAddress {
    if (!address.length) {
        [self.hud showTipMessageAutoHide:@"请输入地址"];
        return;
    }
    if ([address isEqualToString:oldAddre]) {
        [self.hud showTipMessageAutoHide:@"请先修改再提交"];
        return;
    }
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:address forKey:@"address"];
    [AFNetWorkingUsing httpPut:[NSString stringWithFormat:@"address/%@",_addreId] params:plist success:^(id json) {
        [self.hud showTipMessageAutoHide:@"地址更新成功"];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)deleteAddress {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpDelete:[NSString stringWithFormat:@"address/%@",_addreId] params:plist success:^(id json) {
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)loadAddress {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:[NSString stringWithFormat:@"address/%@/edit",_addreId] params:plist success:^(id json) {
        MKMemAddreModel *model = [MKMemAddreModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
        writeView.text = model.address;
        oldAddre = model.address;
        writeView.textColor = wordThreeColor;
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请输入详细地址信息..."]) {
        textView.text = @"";
        textView.textColor = wordThreeColor;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(textView.text.length < 1) {
        textView.text = @"请输入详细地址信息...";
        textView.textColor = holderColor;
    }else{
        address = textView.text;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
