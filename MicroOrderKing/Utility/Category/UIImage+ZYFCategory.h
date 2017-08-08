//
//  UIImage+ZYFCategory.h
//  ZYFFramework
//
//  Created by 周逸帆 on 16/9/13.
//  Copyright © 2016年 周逸帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZYFCategory)
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
- (UIImage *)rotation:(UIImageOrientation)orientation;
-(UIImage *) autoChangeImageSizeWithWidth:(CGFloat)defineWidth;
-(UIImage *)autoChangeImageSize:(CGSize)maxSize;
@end
