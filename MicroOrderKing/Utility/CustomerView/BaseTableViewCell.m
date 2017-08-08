//
//  BaseTableViewCell.m
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/9.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell
{
    UILabel *titleLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier
{
    // 1.缓存中取
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil)
    {
        cell = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self createView];
        [self setttingViewAtuoLayout];
    }
    return self;
}



#pragma make 创建子控件
- (void) createView {
    


}


#pragma mark - 在此方法内使用 Masonry 设置控件的约束,设置约束不需要在layoutSubviews中设置，只需要在初始化的时候设置
- (void) setttingViewAtuoLayout {
    
    

    
}



-(void)setData:(id)model
{

}



@end
