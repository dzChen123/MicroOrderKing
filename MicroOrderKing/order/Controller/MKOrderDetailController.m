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
    MKOrderBottomView *orderBottomView;
    
    UIScrollView *scrollerView;
    UIView *containerView;
    MASConstraint *bottomConstraint;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _isUpdate = NO;
    
    WS(ws)
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(ws.topView.mas_bottom);
        bottomConstraint = make.bottom.mas_equalTo(orderBottomView.mas_top);
    }];

    // Do any additional setup after loading the view.
}

- (void)CreatView {
    orderDetailView = [[MKOrderDetailView alloc] init];
    orderGoodsView = [[MKOrderGoodsView alloc] init];
    orderBottomView = [[MKOrderBottomView alloc] init];
    scrollerView = [[UIScrollView alloc] init];
    containerView = [[UIView alloc] init];
    
    [self addSubview:scrollerView];
    [scrollerView addSubview:containerView];
    [containerView addSubview:orderDetailView];
    [containerView addSubview:orderGoodsView];
    [self addSubview:orderBottomView];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [orderBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(ws.view);
        make.height.mas_equalTo(50 * autoSizeScaleH);
    }];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(scrollerView);
        make.width.mas_equalTo(scrollerView);
        make.bottom.mas_equalTo(orderGoodsView);
    }];
    
    [orderDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(containerView);
    }];
    
    [orderGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderDetailView.mas_bottom).offset(15 * autoSizeScaleH);
        make.left.right.mas_equalTo(containerView);
    }];
    
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
        if ([model.conditionType integerValue] > 1) {
            orderBottomView.hidden = YES;
            
            WS(ws)
            if (bottomConstraint) {
                [bottomConstraint uninstall];
            }
            [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
                bottomConstraint = make.bottom.mas_equalTo(ws.view);
            }];
        }else{
            [orderBottomView setData:model];
        }
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
