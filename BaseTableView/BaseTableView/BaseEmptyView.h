//
//  BaseEmptyView.h
//  Common
//
//  Created by damai on 2018/10/15.
//  Copyright © 2018年 qianfei. All rights reserved.
//

#import "LYEmptyView.h"

@interface BaseEmptyView : LYEmptyView

+ (instancetype)baseEmptyViewImage:(NSString*)imgName titleStr:(NSString*)titleStr detailStr:(NSString*)detailStr;

+ (instancetype)baseEmptyView;

@end
