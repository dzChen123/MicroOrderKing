//
//  MKTittleTextView.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/29.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "BaseView.h"

@interface MKTittleTextView : BaseView<UITextViewDelegate,UITextFieldDelegate>

- (instancetype)initWithModel:(id)model;
- (void)CleanText;
- (void)SetText:(NSString *)text;
- (UITextView *)getTextView;
- (UIButton *)getCloseButn;

@property (strong,nonatomic) NSString *text;
@property (assign,nonatomic) BOOL isNumber;
@property (strong,nonatomic) void (^closeClickblock)(MKTittleTextView *textView);

@end

@interface MKTextViewModel : NSObject

@property(assign,nonatomic) NSInteger type;
@property(assign,nonatomic) CGFloat whiteHeight;
@property(assign,nonatomic) BOOL isNumberPod;
@property(strong,nonatomic) NSString *placeHolder;
@property(strong,nonatomic) NSString *tittle;
@property(strong,nonatomic) UIView *superView;
@property(assign,nonatomic) BOOL isPasd;

@end
