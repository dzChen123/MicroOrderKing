//
//  MKVersionModel.h
//  MicroOrderKing
//
//  Created by 陈徳柱 on 2017/9/19.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKVersionModel : NSObject

@property (strong,nonatomic) NSString *updateUrl;
@property (strong,nonatomic) NSString *version;
@property (strong,nonatomic) NSString *updateSign;

@end
