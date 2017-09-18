//
//  MKContactController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/1.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKContactController.h"

#import "MKContactView.h"

#import "MKContactModel.h"

@interface MKContactController ()

@end

@implementation MKContactController
{
    MKContactView *contactView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    // Do any additional setup after loading the view.
}

- (void)CreatView {
    
    contactView = [[MKContactView alloc] init];
    
    [self addSubview:contactView];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).offset(leftPadding);
        make.right.mas_equalTo(ws.view).offset(rightPadding);
        make.top.mas_equalTo(ws.topView.mas_bottom).offset(15 * autoSizeScaleH);
    }];
    
    [super updateViewConstraints];
}

- (void)setData {
    
    MKContactModel *model = [[MKContactModel alloc] init];
    model.weChatNum = @"wdw_kf";
    model.phoneNum = @"13002698223";
    model.qqNum = @"3290613410";
    [contactView setData:model];
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
