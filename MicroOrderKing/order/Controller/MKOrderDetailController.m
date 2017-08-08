//
//  MKOrderDetailController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKOrderDetailController.h"

#import "MKOrderDetailView.h"
#import "MKOrderGoodsView.h"

#import "MKOrderCellModel.h"

@interface MKOrderDetailController ()

@end

@implementation MKOrderDetailController
{
    MKOrderDetailView *orderDetailView;
    MKOrderGoodsView *orderGoodsView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _isUpdate = NO;
    // Do any additional setup after loading the view.
}

- (void)CreatView {
    orderDetailView = [[MKOrderDetailView alloc] init];
    orderGoodsView = [[MKOrderGoodsView alloc] init];
    
    [self addSubview:orderDetailView];
    [self addSubview:orderGoodsView];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [orderDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.containerView);
        make.left.right.mas_equalTo(ws.containerView);
    }];
    
    [orderGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderDetailView.mas_bottom).offset(15 * autoSizeScaleH);
        make.left.right.mas_equalTo(ws.containerView);
    }];
    
    [self setBottomView:orderGoodsView withHeight:.1f];
    
    [super updateViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //[self loadData];
}

- (void)loadData {
    
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:[NSString stringWithFormat:@"order/%@",_orderId] params:plist success:^(id json) {
        MKOrderDetailModel *model = [MKOrderDetailModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
        if (!_isUpdate) {
            model.conditionType = _postStatus;
        } else {
            NSInteger status = [_postStatus integerValue];
            status ++;
            _postStatus = [NSString stringWithFormat:@"%ld",status];
            model.conditionType = _postStatus;
        }

        [orderDetailView setData:model];
        [orderGoodsView setData:model];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];

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
