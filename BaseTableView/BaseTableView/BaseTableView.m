//
//  BaseTableView.m
//  Common
//
//  Created by damai on 2018/9/11.
//  Copyright © 2018年 qianfei. All rights reserved.
//

#import "BaseTableView.h"
#import "BaseEmptyView.h"
#import "LYEmptyViewHeader.h"
@interface BaseTableView ()
@end
@implementation BaseTableView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initWithConfig];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initWithConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithConfig];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initWithConfig];
    }
    return self;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self initWithConfig];
}


- (void)initWithConfig {
    
    self.backgroundColor = [UIColor lightGrayColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.delaysContentTouches = NO;
    self.canCancelContentTouches = YES;
    self.dataArray = [NSMutableArray array];
    [self showEmptyView];
}

///添加MJHeader
-(void)addMJHeader:(mjheaderBlock)block{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        block();
    }];
    [self.mj_header beginRefreshing];
}

///添加MJFooter
-(void)addMJFooter:(mjfooterBlock)block{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        block();
    }];
}
//结束刷新
- (void)endMJRefresh{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

//空页面设置
- (void)showEmptyView{
    // 可根据需求更改空页面样式；
    //断网
    //self.ly_emptyView = [BaseEmptyView baseEmptyViewNoNetwork];
    //无数据
    self.ly_emptyView = [BaseEmptyView baseEmptyViewNoData];
    __weak typeof(self) weakSelf = self;
    [self.ly_emptyView setTapContentViewBlock:^(){
        [weakSelf.mj_header beginRefreshing];
    }];
}
/**
 *  自定义空页面  emptyView
 *
 *  @param image            空页面图片
 *  @param title            空页面标题
 *  @param detail           空页面副标题
 */
- (void)showEmptyViewWithImage:(NSString*)image withTitle:(NSString*)title withDetail:(NSString*)detail{
    self.ly_emptyView = [BaseEmptyView baseEmptyViewWithImage:image withTitle:title withDetail:detail];
    __weak typeof(self) weakSelf = self;
    [self.ly_emptyView setTapContentViewBlock:^(){
        [weakSelf.mj_header beginRefreshing];
    }];
}

// UITableView -- reloadData
- (void)baseReloadData{
    [self reloadData];
    [self endMJRefresh];
    [self ly_endLoading];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
