//
//  MKAddreMangeCell.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/8/5.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MKAddreMangeCell : BaseTableViewCell

@property (assign,nonatomic) CGFloat cellHeight;

@end

@interface MKAddreView : BaseView

- (void)setAddre:(NSString *)addre;

@end
