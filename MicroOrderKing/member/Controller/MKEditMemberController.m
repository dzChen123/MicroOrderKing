//
//  MKEditMemberController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/6.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKEditMemberController.h"
#import "MKAddreManageController.h"
#import "MKEditAddreController.h"

#import "MKTittleTextView.h"

#import "MKMemberBaseModel.h"
#import "MKAddreManageModel.h"

@interface MKEditMemberController ()

@end

@implementation MKEditMemberController
{
    UIScrollView *scrollerView;
    UIView *containerView;
    UIButton *saveButn;
    UIButton *manageButn;
    UILabel *titleLab;
    
    NSMutableArray *textViewArray;
    NSMutableArray *addreViewArray;
    UIView *lastView;
    MASConstraint *topConstraint;
    NSString *name;
}

- (void)CreatView {
    scrollerView = [[UIScrollView alloc] init];
    containerView = [[UIView alloc] init];
    saveButn = [[UIButton alloc] init];
    manageButn = [[UIButton alloc] init];
    titleLab = [[UILabel alloc] init];
    
    [self addSubview:scrollerView];
    [self addSubview:saveButn];
    [scrollerView addSubview:containerView];
    [containerView addSubview:manageButn];
    [containerView addSubview:titleLab];
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
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(manageButn).offset(20 * autoSizeScaleH);
    }];
    
    manageButn.backgroundColor = customWhite;
    manageButn.layer.masksToBounds = YES;
    manageButn.layer.cornerRadius = 6.0;
    [manageButn addTarget:self action:@selector(goToManageAddre) forControlEvents:UIControlEventTouchUpInside];
    [manageButn setTitle:@"  地址管理" forState:UIControlStateNormal];
    [manageButn setTitleColor:[UIColor hexStringToColor:@"#6E6666"] forState:UIControlStateNormal];
    manageButn.titleLabel.font = FONT(15);
    
    [super updateViewConstraints];
}

- (void)LoadtextViews {
    textViewArray = [[NSMutableArray alloc] init];
    addreViewArray = [[NSMutableArray alloc] init];
    NSArray *titleArra = @[@"会员号(即收货人联系方式)",@"会员姓名(即收货人姓名)",@"备注"];
    NSArray *holderArra = @[@"请输入会员手机号",@"请输入会员姓名",@"写点什么..."];
    for (int count = 0; count < 3; count ++) {
        MKTextViewModel *model = [[MKTextViewModel alloc] init];
        model.superView = containerView;
        model.type = count < 2 ? 0 : 1;
        model.tittle = titleArra[count];
        model.placeHolder = holderArra[count];
        model.isNumberPod = !count ? 1 : 0;
        if (count == 2) {
            model.whiteHeight = 80 * autoSizeScaleH;
        }
        MKTittleTextView *textView = [[MKTittleTextView alloc] initWithModel:model];
        [textViewArray addObject:textView];
    }
    
    [self LayOutTextViews];
    
}

- (void)LayOutTextViews {
    for (int index = 0 ; index < 3; index ++) {
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
    
    titleLab.text = @"收货地址";
    titleLab.font = FONT(12);
    titleLab.textColor = [UIColor hexStringToColor:@"#B5B6B8"];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(containerView).offset(leftPadding);
        make.top.mas_equalTo(lastView.mas_bottom).offset(25 * autoSizeScaleH);
    }];
    
    lastView = titleLab;
    
    

}

- (void)LoadData {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:[NSString stringWithFormat:@"member/%@/edit",_memberId] params:plist success:^(id json) {
        MKMemberDetailModel *model = [MKMemberDetailModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
        for (int index = 0; index < textViewArray.count; index ++) {
            MKTittleTextView *itemView = textViewArray[index];
            switch (index) {
                case 0:
                    [itemView SetText:model.phoneNum];
                    itemView.userInteractionEnabled = NO;
                    break;
                case 1:
                    name = model.name;
                    [itemView SetText:model.name];
                    break;
                case 2:
                    if (model.remark.length > 0) {
                        [itemView SetText:model.remark];
                    }
                    break;
                    
                default:
                    break;
            }
        }
        [self LoadAddre:model.address];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        
    }];
}

- (void)LoadAddre:(NSMutableArray *)addreArr {
    for (UIView *subView in containerView.subviews) {
        if ([subView isKindOfClass:[MKEditAddreView class]]) {
            [subView removeFromSuperview];
        }
    }
    lastView = titleLab;
    if (!addreArr.count) {
        [topConstraint uninstall];
        [manageButn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(containerView).offset(leftPadding);
            make.right.mas_equalTo(containerView).offset(rightPadding);
            topConstraint = make.top.mas_equalTo(titleLab.mas_bottom).offset(5 * autoSizeScaleH);
            make.height.mas_equalTo(45 * autoSizeScaleH);
        }];
        return;
    }
    for (int index = 0; index < addreArr.count; index ++) {
        MKMemAddreModel *model = addreArr[index];
        MKEditAddreView *itemView = [[MKEditAddreView alloc] init];
        [itemView setData:model];
        [containerView addSubview:itemView];
        [addreViewArray addObject:itemView];
        [itemView addTapEventWith:self action:@selector(addreViewTap:)];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(containerView).offset(leftPadding);
            make.right.mas_equalTo(containerView).offset(rightPadding);
            make.top.mas_equalTo(lastView.mas_bottom).offset(5 * autoSizeScaleH);
        }];
        lastView = itemView;
    }
    if (topConstraint) {
        [topConstraint uninstall];
    }
    [manageButn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(containerView).offset(leftPadding);
        make.right.mas_equalTo(containerView).offset(rightPadding);
        topConstraint = make.top.mas_equalTo(lastView.mas_bottom).offset(5 * autoSizeScaleH);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
}

- (void)addreViewTap:(UITapGestureRecognizer *)sender {
    MKEditAddreView *senderView = (MKEditAddreView *)sender.view;
    MKEditAddreController *controller = [[MKEditAddreController alloc] initWithType:1];
    controller.addreId = senderView.addreId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self LoadtextViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //[self LoadtextViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //[self LoadtextViews];
    [self LoadData];
}

- (void)saveClick {
    NSString *nameStr,*remark;
    for (int index = 1; index < 3; index ++) {
        MKTittleTextView *itemView = textViewArray[index];
        if (index == 1) {
            nameStr = itemView.text;
        }else{
            remark = itemView.text;
        }
    }
    if (!nameStr.length) {
        [self.hud showTipMessageAutoHide:@"名字不能为空哦"];
        return;
    }
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:nameStr forKey:@"name"];
    [plist setObject:remark forKey:@"remark"];
    [AFNetWorkingUsing httpPut:[NSString stringWithFormat:@"member/%@",_memberId] params:plist success:^(id json) {
        [self.hud showTipMessageAutoHide:@"更新会员成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
    
}

- (void)goToManageAddre {
    MKAddreManageController *controller = [[MKAddreManageController alloc] init];
    controller.memberId = _memberId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation MKEditAddreView
{
    UILabel *addreLab;
}

- (void)CreatView {
    addreLab = [[UILabel alloc] init];
    
    [self addSubview:addreLab];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    self.backgroundColor = customWhite;
    self.layer.cornerRadius = 6.0;
    self.layer.masksToBounds = YES;
    
    addreLab.font = FONT(14);
    addreLab.textColor = wordSixColor;
    addreLab.numberOfLines = 0;
    [addreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.right.lessThanOrEqualTo(ws).offset(rightPadding);
        make.top.mas_equalTo(ws).offset(15 * autoSizeScaleH);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(addreLab).offset(15 * autoSizeScaleH);
    }];
}

- (void)setData:(id)model {
    
    MKMemAddreModel *dataModel = (MKMemAddreModel *)model;
    addreLab.text = dataModel.address;
    _addreId = dataModel.addreId;
}


@end
