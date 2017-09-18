//
//  MKOrderManageTable.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/27.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseUITableView.h"

@interface MKOrderManageTable : BaseUITableView

@property (strong,nonatomic) void (^confirmButnBlock)();
@property (strong,nonatomic) void (^printButnBlock)(NSInteger tag);

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style cellIdentifier:(NSString *)cellIdentifier class:(Class)cellClass type:(NSInteger)type;
- (void)SetGreenBtn;

@end
