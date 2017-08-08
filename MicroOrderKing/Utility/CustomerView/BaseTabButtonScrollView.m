//
//  BaseTabButtonScrollView.m
//  BrightSummit-iOS
//
//  Created by 周逸帆 on 16/7/11.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import "BaseTabButtonScrollView.h"
#import "ZYFUtilityPch.h"
#define BaseTabButtonScrollTitleColor [UIColor blackColor]
#define BaseTabButtonScrollTitleSelectColor [UIColor redColor]
@interface BaseTabButtonScrollView()

@property (nonatomic,strong) NSMutableArray *buttonArray;
@property (nonatomic,strong) UIView *containView;
@property (nonatomic,strong) UIView *slideView;

@end

@implementation BaseTabButtonScrollView
{

}




-(instancetype)init
{
    self=[super init];
    
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces=NO;
        self.delegate=self;
//        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        self.backgroundColor = [UIColor whiteColor];
        _containView=[[UIView alloc] init];
        [self addSubview:_containView];

        _slideView=[[UIView alloc] init];
        _slideView.backgroundColor=[UIColor clearColor];
        [self addSubview:_slideView];

    }
    return  self;
}

-(void)setData:(NSMutableArray *)array
{
    [self creactButtonView:array];
    
}


/**
 *  创建tab  UIButton
 *
 *  @param array <#array description#>
 */
-(void)creactButtonView:(NSArray *)array
{
    WS(ws)
    [_containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws);
        make.height.mas_equalTo(ws);
    }];
    _showButtonCount=5;
    if(array.count<5)
    {
        _showButtonCount=array.count;
    }
    _buttonArray = [[NSMutableArray alloc] init];
    UIView *lastView=ws;
    for (int i =0 ;i<array.count;i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_containView addSubview:btn];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT(14);
        [btn setTitleColor:BaseTabButtonScrollTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:BaseTabButtonScrollTitleSelectColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag =i;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if(lastView==self)
            {
               make.left.mas_equalTo(lastView);
            }
            else
            {
                make.left.mas_equalTo(lastView.mas_right);
            }
            make.height.mas_equalTo(_containView).offset(-5);
            make.width.mas_equalTo(SCREEN_WIDTH/_showButtonCount);
            make.top.mas_equalTo(lastView);
        }];
        [_buttonArray addObject:btn];
        lastView=btn;
    }
    [_containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lastView);
    }];
    [_slideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(0);
        make.bottom.mas_equalTo(ws);
        make.height.mas_equalTo(3);
        make.width.mas_equalTo(SCREEN_WIDTH/_showButtonCount);
    }];
    self.index=0;
}

/**
 *  按钮事件
 *
 *  @param button <#button description#>
 */
-(void)buttonClicked:(UIButton *)button
{
    self.index = button.tag;
    //    block的回调，当button的index发生变化时，将index的值传给视图控制器
    if (_changeIndexValue) {
        _changeIndexValue(_index);
    }
}

/**
 *  设置索引并调整位置
 *
 *  @param index <#index description#>
 */
-(void)setIndex:(NSInteger)index
{
    WS(ws)
    if(_buttonArray.count==0)
    {
        return;
    }
    UIButton *notSelectedButton = _buttonArray[_index];
    notSelectedButton.selected = NO;
    UIButton *selectedButton = _buttonArray[index];
    selectedButton.selected = YES;
    if(_showButtonCount<_buttonArray.count)
    {
        //设置选中的Button居中
        CGFloat offSetX = selectedButton.frame.origin.x - SCREEN_WIDTH/2;
        //1、当offSetX的值小于0时（即点击的是中心点左边的button时），让offSetX为0；反之，让offSetX的值为selectedButton.frame.origin.x-kScreenWidth/2+kButtonWidth/2
        offSetX = offSetX > 0 ?(offSetX + SCREEN_WIDTH/_showButtonCount/2):0;
        //2、在大于0的情况下，又大于self.contentSize.width - kScreenWidth时，offSetX 的值为self.contentSize.width - kScreenWidth，反之为：selectedButton.frame.origin.x-kScreenWidth/2+kButtonWidth/2
        offSetX = offSetX > self.contentSize.width - SCREEN_WIDTH ? self.contentSize.width - SCREEN_WIDTH :offSetX;
        [UIView animateWithDuration:0.3 animations:^{
            self.contentOffset = CGPointMake(offSetX, 0);
        }];
    }
    _index = index;
    [UIView animateWithDuration:0.01 animations:^{
            [_slideView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ws).offset(index*SCREEN_WIDTH/_showButtonCount);
            }];
            [self layoutIfNeeded];
    }];
}

- (void)SetButnNormalColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor{
    
    for (UIButton *butn in self.buttonArray) {
        [butn setTitleColor:normalColor forState:UIControlStateNormal];
        [butn setTitleColor:selectedColor forState:UIControlStateSelected];
    }
}

- (void)SetButnFont:(UIFont *)font{
    
    for (UIButton *butn in self.buttonArray) {
        butn.titleLabel.font = font;
    }
}

- (void)SetSlideViewBackgroundColor:(UIColor *)backColor{
    _slideView.backgroundColor = backColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
