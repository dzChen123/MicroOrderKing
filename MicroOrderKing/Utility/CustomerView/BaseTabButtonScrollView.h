//
//  BaseTabButtonScrollView.h
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/11.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabButtonScrollView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic) NSInteger index;
@property (nonatomic, strong) void (^changeIndexValue)(NSInteger);
@property (nonatomic,assign) NSInteger showButtonCount;
-(void)setData:(NSMutableArray *)array;

- (void)SetButnNormalColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor;
- (void)SetButnFont:(UIFont *)font;
- (void)SetSlideViewBackgroundColor:(UIColor *)backColor;

@end
