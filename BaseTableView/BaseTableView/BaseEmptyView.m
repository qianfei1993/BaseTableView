//
//  BaseEmptyView.m
//  Common
//
//  Created by damai on 2018/10/15.
//  Copyright © 2018年 qianfei. All rights reserved.
//

#import "BaseEmptyView.h"

@implementation BaseEmptyView


+ (instancetype)baseEmptyViewWithImage:(NSString*)imgName withTitle:(NSString*)title withDetail:(NSString*)detail{
    BaseEmptyView *emptyView = [BaseEmptyView emptyViewWithImageStr:imgName titleStr:title detailStr:detail];
    emptyView.emptyViewIsCompleteCoverSuperView = YES;
    emptyView.subViewMargin = 15;
    emptyView.isEmptyScrollEnabled = YES;
    emptyView.autoShowEmptyView = NO;
    return emptyView;
}


+ (instancetype)baseEmptyViewNoData{
    BaseEmptyView *emptyView = [BaseEmptyView emptyViewWithImageStr:@"nodata@2x.png"
                                                           titleStr:@"暂无内容哦~"
                                                          detailStr:nil];
    emptyView.emptyViewIsCompleteCoverSuperView = YES;
    emptyView.subViewMargin = 15;
    emptyView.isEmptyScrollEnabled = YES;
    emptyView.autoShowEmptyView = NO;
    return emptyView;
}

+ (instancetype)baseEmptyViewNoNetwork{
    BaseEmptyView *emptyView = [BaseEmptyView emptyViewWithImageStr:@"noNetwork@2x.png"
                                                           titleStr:@"无网络连接"
                                                          detailStr:@"请检查你的网络连接是否正确!"];
    emptyView.emptyViewIsCompleteCoverSuperView = YES;
    emptyView.subViewMargin = 15;
    emptyView.isEmptyScrollEnabled = YES;
    emptyView.autoShowEmptyView = NO;
    return emptyView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
