//
//  BaseEmptyView.h
//  Common
//
//  Created by damai on 2018/10/15.
//  Copyright © 2018年 qianfei. All rights reserved.
//

#import "LYEmptyView.h"

@interface BaseEmptyView : LYEmptyView

+ (instancetype)baseEmptyViewWithImage:(NSString*)imgName withTitle:(NSString*)title withDetail:(NSString*)detail;

+ (instancetype)baseEmptyViewNoData;

+ (instancetype)baseEmptyViewNoNetwork;

@end
