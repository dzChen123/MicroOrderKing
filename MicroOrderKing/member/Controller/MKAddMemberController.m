//
//  MKAddMemberController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/5.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKAddMemberController.h"

#import "MKTittleTextView.h"

@interface MKAddMemberController ()

@end

@implementation MKAddMemberController
{
    UIButton *saveButn;
    UIScrollView *scrollerView;
    UIView *containerView;
    UIButton *addButn;
 
    NSMutableArray *textViewArray;
    NSMutableArray *addreViewArray;
    UIView *lastView;
    
    MASConstraint *topConstraint;
    
}

- (void)CreatView {
    scrollerView = [[UIScrollView alloc] init];
    containerView = [[UIView alloc] init];
    saveButn = [[UIButton alloc] init];
    addButn = [[UIButton alloc] init];
    
    [self addSubview:scrollerView];
    [self addSubview:saveButn];
    [scrollerView addSubview:containerView];
    [containerView addSubview:addButn];
    
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    scrollerView.bounces = NO;
    scrollerView.showsVerticalScrollIndicator = NO;
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.topView.mas_bottom);
        make.left.right.mas_equalTo(ws.view);
        make.bottom.mas_equalTo(saveButn.mas_top);
    }];
    
    //containerView.backgroundColor = [UIColor yellowColor];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(scrollerView);
        make.width.mas_equalTo(scrollerView);
    }];
    
    [saveButn setTitle:@"保存" forState:UIControlStateNormal];
    [saveButn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    saveButn.titleLabel.textColor = customWhite;
    saveButn.titleLabel.font = FONT(16);
    saveButn.backgroundColor = themeGreen;
    [saveButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(ws.view);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    addButn.backgroundColor = customWhite;
    addButn.layer.masksToBounds = YES;
    addButn.layer.cornerRadius = 6.0;
    [addButn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [addButn setTitle:@"  新增地址" forState:UIControlStateNormal];
    [addButn setTitleColor:[UIColor hexStringToColor:@"#6E6666"] forState:UIControlStateNormal];
    [addButn setImage:[[UIImage imageNamed:@"addAress"] imageByScalingToSize:CGSizeMake(15 * autoSizeScaleW, 15 * autoSizeScaleW)] forState:UIControlStateNormal];
    addButn.titleLabel.font = FONT(15);
    
    [super updateViewConstraints];
}

- (void)LoadtextViews {
    textViewArray = [[NSMutableArray alloc] init];
    addreViewArray = [[NSMutableArray alloc] init];
    NSArray *titleArra = @[@"会员号(即收货人联系方式)",@"会员姓名(即收货人姓名)",@"备注",@"收货地址"];
    NSArray *holderArra = @[@"请输入会员手机号",@"请输入会员姓名",@"写点什么...",@"请输入详细地址信息..."];
    for (int count = 0; count < 4; count ++) {
        MKTextViewModel *model = [[MKTextViewModel alloc] init];
        model.superView = containerView;
        model.type = count < 2 ? 0 : 1;
        model.tittle = titleArra[count];
        model.placeHolder = holderArra[count];
        model.isNumberPod = !count ? 1 : 0;
        if (count == 2) {
            model.whiteHeight = 80 * autoSizeScaleH;
        }
        if (count == 3) {
            model.whiteHeight = 110 * autoSizeScaleH;
        }
        MKTittleTextView *textView = [[MKTittleTextView alloc] initWithModel:model];
        [textViewArray addObject:textView];
    }
    
    [self LayOutTextViews];
    
}

- (void)LayOutTextViews {
    
    for (int index = 0 ; index < 4; index ++) {
        MKTittleTextView *itemView = textViewArray[index];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!index) {
                make.top.mas_equalTo(containerView);
            }else{
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            make.left.right.mas_equalTo(containerView);
        }];
        lastView = itemView;
    }
    [addButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(containerView).offset(leftPadding);
        make.right.mas_equalTo(containerView).offset(rightPadding);
        topConstraint = make.top.mas_equalTo(lastView.mas_bottom).offset(5 * autoSizeScaleH);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.height.mas_equalTo(800 * autoSizeScaleH);
        make.bottom.mas_equalTo(addButn).offset(20 * autoSizeScaleH);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self LoadtextViews];
    // Do any additional setup after loading the view.
}

- (void)saveClick {
    NSArray *signArr = @[@"请输入手机号",@"请输入会员姓名",@"请输入收货地址"];
    NSString *phoneNum,*name,*remark,*address;
    NSMutableArray *addreArr = [[NSMutableArray alloc] init];
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
                remark = itemView.text;
                break;
            case 3:
                address = itemView.text;
                break;
                
            default:
                break;
        }
    }
    if (address.length > 0) { [addreArr addObject:address]; }
    for (MKTittleTextView *itemView in addreViewArray) {
        if (itemView.text.length > 0) {
            [addreArr addObject:itemView.text];
        }
    }
    if (!phoneNum.length) {
        [self.hud showTipMessageAutoHide:signArr[0]];
        return;
    }
    if (!name.length) {
        [self.hud showTipMessageAutoHide:signArr[1]];
        return;
    }
    if (!addreArr.count) {
        [self.hud showTipMessageAutoHide:signArr[2]];
        return;
    }
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:phoneNum forKey:@"mobile"];
    [plist setObject:name forKey:@"name"];
    [plist setObject:(NSArray *)addreArr forKey:@"address"];
    if (remark.length > 0) {
        [plist setObject:remark forKey:@"remark"];
    }
    [AFNetWorkingUsing httpPost:@"member" params:plist success:^(id json) {
        [self.hud showTipMessageAutoHide:@"添加会员成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
    
    

    
}

- (void)addClick {
    
    WS(ws)
    MKTextViewModel *model = [[MKTextViewModel alloc] init];
    model.superView = containerView;
    model.type = 2;
    model.placeHolder = @"请输入收货地址";
    model.isNumberPod = 0;
    model.whiteHeight = 110 * autoSizeScaleH;
    
    MKTittleTextView *textView = [[MKTittleTextView alloc] initWithModel:model];
    textView.closeClickblock =^(MKTittleTextView *textView){
        [ws closeClick:textView];
    };
    [containerView addSubview:textView];
    [addreViewArray addObject:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(lastView.mas_bottom).offset(5 * autoSizeScaleH);
    }];
    
    UITextView *write = [textView getTextView];
    [containerView bringSubviewToFront:write];
    UIButton *close = [textView getCloseButn];
    [containerView bringSubviewToFront:close];
    
    lastView = textView;
    
    [topConstraint uninstall];
    [addButn mas_updateConstraints:^(MASConstraintMaker *make) {
        topConstraint = make.top.mas_equalTo(lastView.mas_bottom).offset(5 * autoSizeScaleH);
    }];
    
    [self.view layoutIfNeeded];
    
}

- (void)closeClick:(MKTittleTextView *)textView {
    if (addreViewArray.count == 1) {
        lastView = textViewArray[3];
        [topConstraint uninstall];
        [addButn mas_updateConstraints:^(MASConstraintMaker *make) {
            topConstraint = make.top.mas_equalTo(lastView.mas_bottom).offset(5 * autoSizeScaleH);
        }];
    }else{
        NSInteger index = [addreViewArray indexOfObject:textView];
        MKTittleTextView *afterView;
        if (!index) {
            lastView = textViewArray[3];
            afterView = addreViewArray[index + 1];
            [afterView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastView.mas_bottom).offset(5 * autoSizeScaleH);
            }];
        }else if(index == addreViewArray.count - 1){
            lastView = addreViewArray[index - 1];
            [topConstraint uninstall];
            [addButn mas_updateConstraints:^(MASConstraintMaker *make) {
                topConstraint = make.top.mas_equalTo(lastView.mas_bottom).offset(5 * autoSizeScaleH);
            }];
        }else{
            lastView = addreViewArray[index - 1];
            afterView = addreViewArray[index + 1];
            [afterView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastView.mas_bottom).offset(5 * autoSizeScaleH);
            }];
        }
    }

    [textView removeFromSuperview];
    [addreViewArray removeObject:textView];
    [self.view layoutIfNeeded];
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
