//
//  BaseEmptyView.m
//  Common
//
//  Created by damai on 2018/10/15.
//  Copyright © 2018年 qianfei. All rights reserved.
//

#import "BaseEmptyView.h"

@implementation BaseEmptyView


+ (instancetype)baseEmptyViewImage:(NSString*)imgName titleStr:(NSString*)titleStr detailStr:(NSString*)detailStr{
    
    BaseEmptyView *emptyView = [BaseEmptyView emptyViewWithImageStr:imgName
                                                           titleStr:titleStr
                                                          detailStr:detailStr];
    emptyView.autoShowEmptyView = NO;
    emptyView.isEmptyScrollEnabled = YES;
    emptyView.emptyViewIsCompleteCoverSuperView = YES;
    return emptyView;
}

+ (instancetype)baseEmptyView{
    BaseEmptyView *emptyView = [BaseEmptyView emptyViewWithImageStr:@"noNetwork@2x.png"
                                                           titleStr:@"无网络连接"
                                                          detailStr:@"请检查你的网络连接是否正确!"];
    emptyView.autoShowEmptyView = NO;
    emptyView.isEmptyScrollEnabled = YES;
    emptyView.emptyViewIsCompleteCoverSuperView = YES;
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
