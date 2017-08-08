//
//  BaseUITableView.h
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/9.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@interface BaseUITableView : UITableView<UITableViewDelegate,UITableViewDataSource>
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style cellIdentifier:(NSString *)cellIdentifier   class:(Class)cellClass;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSString *cellIdentifier;
@property (nonatomic,strong) void (^reloadMessage)(UITableView *tableView);
@property (nonatomic,strong) void (^loadMoreMessage)(UITableView *tableView);

@property (nonatomic,strong) void (^cellSelcet)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic,strong) CGFloat (^cellHeight)(UITableView *tableView,NSIndexPath *indexPath);

-(void)setCellIdentifier:(NSString *)cellIdentifier;
@property (nonatomic,strong) id<BaseTableViewCellDelete> cellDelete;
@end
