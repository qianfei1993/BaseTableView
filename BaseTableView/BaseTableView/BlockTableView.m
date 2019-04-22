//
//  BlockTableView.m
//  BaseTableView
//
//  Created by damai on 2019/4/22.
//  Copyright © 2019 personal. All rights reserved.
//

#import "BlockTableView.h"
#import "BaseEmptyView.h"
#import "LYEmptyViewHeader.h"
@interface BlockTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation BlockTableView
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
    
    self.delegate = self;
    self.dataSource = self;
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


 - (void)setBaseRowHeight:(CGFloat)baseRowHeight{
     _baseRowHeight = baseRowHeight;
     self.rowHeight = _baseRowHeight;
 }
 
 -(void)setBaseSectionHeaderHeight:(CGFloat)baseSectionHeaderHeight{
     _baseSectionHeaderHeight = baseSectionHeaderHeight;
     self.sectionHeaderHeight = _baseSectionHeaderHeight;
 }
 
 -(void)setBaseSectionFooterHeight:(CGFloat)baseSectionFooterHeight{
     _baseSectionFooterHeight = baseSectionFooterHeight;
     self.sectionFooterHeight = _baseSectionFooterHeight;
 }
 
 #pragma mark UITableViewDataSource
 -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     if (self.numberOfSectionsInTableViewBlock) {
         return self.numberOfSectionsInTableViewBlock(tableView);
     }
     return 1;
 }
 
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     if (self.numberOfRowsInSectionBlock) {
         return self.numberOfRowsInSectionBlock(tableView, section);
     }
     return 0;
 }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellForRowAtIndexPathBlock) {
        return self.cellForRowAtIndexPathBlock(tableView, indexPath);
    }
    return nil;
}

#pragma mark UITableViewDelegate
#pragma mark UITableViewDelegate -- Section header & footer
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.viewForHeaderInSectionBlock) {
        return self.viewForHeaderInSectionBlock(tableView, section);
    }
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.viewForFooterInSectionBlock) {
        return self.viewForFooterInSectionBlock(tableView, section);
    }
    return [UIView new];
}

#pragma mark UITableViewDelegate -- Variable height support
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.heightForRowAtIndexPathBlock) {
        return self.heightForRowAtIndexPathBlock(tableView, indexPath);
    }
    if (self.baseRowHeight) {
        return self.baseRowHeight;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.heightForHeaderInSectionBlock) {
        return self.heightForHeaderInSectionBlock(tableView, section);
    }
    if (self.baseSectionHeaderHeight) {
        return self.baseSectionHeaderHeight;
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.heightForFooterInSectionBlock) {
        return self.heightForFooterInSectionBlock(tableView, section);
    }
    if (self.baseSectionFooterHeight) {
        return self.baseSectionFooterHeight;
    }
    return CGFLOAT_MIN;
}


#pragma mark UITableViewDelegate -- The user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelectRowAtIndexPathBlock) {
        self.didSelectRowAtIndexPathBlock(tableView, indexPath);
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didDeselectRowAtIndexPathBlock) {
        self.didDeselectRowAtIndexPathBlock(tableView, indexPath);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
