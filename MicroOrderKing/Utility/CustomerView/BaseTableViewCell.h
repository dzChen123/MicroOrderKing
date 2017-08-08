//
//  BaseTableViewCell.h
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/9.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@protocol BaseTableViewCellDelete <NSObject>

-(void)CellButtonClick:(id)message;

@end

@interface BaseTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
-(void)setData:(id)model;
- (void) createView ;
- (void) setttingViewAtuoLayout;
@property (nonatomic,strong) void (^imageLoadedEvent)();
@property (nonatomic,strong) id<BaseTableViewCellDelete> cellDelete;
@end
