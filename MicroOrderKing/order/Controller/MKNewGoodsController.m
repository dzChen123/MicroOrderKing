//
//  MKNewGoodsController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKNewGoodsController.h"

#import "MKNewGoodsInfoView.h"

#import "MKOrderCellModel.h"

@interface MKNewGoodsController ()

@end

@implementation MKNewGoodsController
{
    MKGoodsPicView *picView;
    MKNewGoodsInfoView *infoView;
    UIButton *saveButn;
    
    BOOL isEdit;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![self.topTitle isEqualToString:@"新增商品"]) {
        isEdit = YES;
    }
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    if (isEdit) {
        [self loadEditionInfo];
    }
}

- (void)CreatView {
    picView = [[MKGoodsPicView alloc] init];
    infoView = [[MKNewGoodsInfoView alloc] init];
    saveButn = [[UIButton alloc] init];
    
    [self addSubview:picView];
    [self addSubview:infoView];
    [self addSubview:saveButn];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [picView setImage:[UIImage imageNamed:@"comManImg"]];
    [picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(ws.topView.mas_bottom);
    }];
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(picView.mas_bottom).offset(15 * autoSizeScaleH);
    }];

    [saveButn setTitle:[self.topTitle isEqualToString:@"新增商品"] ? @"保存" : @"修改" forState:UIControlStateNormal];
    [saveButn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [saveButn setTitleColor:customWhite forState:UIControlStateNormal];
    saveButn.titleLabel.font = FONT(16);
    saveButn.backgroundColor = themeGreen;
    [saveButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(ws.view);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    [super updateViewConstraints];
}

- (void)loadEditionInfo {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:[NSString stringWithFormat:@"goods/%@/edit",_goodsId] params:plist success:^(id json) {
        MKGoodsInfoModel *model = [MKGoodsInfoModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
        [infoView setData:model];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:@"商品信息加载失败"];
    }];
}

- (void)saveClick {
    NSString *name,*price,*unit,*number;
    NSArray *infoArr = [infoView getGoodsInfo];
    name = infoArr[0];
    price = infoArr[1];
    unit = infoArr[2];
    number = infoArr[3];
    if (!name.length) {
        [self.hud showTipMessageAutoHide:@"请填写商品名"];
        return;
    }
    if (!price.length) {
        [self.hud showTipMessageAutoHide:@"请填写价格"];
        return;
    }
    if (!unit.length) {
        [self.hud showTipMessageAutoHide:@"请填写商品单位"];
        return;
    }
    if (!number.length) {
        [self.hud showTipMessageAutoHide:@"请填写库存"];
        return;
    }
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:name forKey:@"name"];
    [plist setObject:price forKey:@"price"];
    [plist setObject:unit forKey:@"unit"];
    [plist setObject:number forKey:@"number"];
    if (isEdit) {
        [plist setObject:@"" forKey:@"sm_logo"];
        [AFNetWorkingUsing httpPut:[NSString stringWithFormat:@"goods/%@",_goodsId] params:plist success:^(id json) {
            [self.hud showTipMessageAutoHide:@"修改成功"];
        } fail:^(NSError *error) {
            
        } other:^(id json) {
            [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
        }];
    }else{
        [AFNetWorkingUsing httpPost:@"goods" params:plist success:^(id json) {
            [self.hud showTipMessageAutoHide:@"添加成功"];
        } fail:^(NSError *error) {
            
        } other:^(id json) {
            [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
        }];
    }
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
