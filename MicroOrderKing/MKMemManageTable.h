//
//  MKMemManageTable.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/30.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseUITableView.h"

@interface MKMemManageTable : BaseUITableView

@property (strong,nonatomic) NSMutableArray *sectionArray;  //储存有数据的索引
@property (strong,nonatomic) NSMutableArray *indexes;   //完整的所有索引的title字符串
@property (strong,nonatomic) NSMutableArray *titleArra;     //储存所有有数据的title字符

@end
