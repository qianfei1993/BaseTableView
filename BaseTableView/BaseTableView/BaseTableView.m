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
@interface BaseTableView ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation BaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setConfigure];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setConfigure];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setConfigure];
    }
    return self;
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self setConfigure];
}

- (void)setConfigure {

    self.dataSource = self;
    self.delegate = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
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

/**
 *  空页面  emptyView
 *
 *  @param state            空页面类型
 *  @param image            空页面图片
 *  @param title            空页面标题
 *  @param detail           空页面副标题
 */
- (void)emptyViewState:(EmptyViewState)state withImage:(NSString*)image withTitle:(NSString*)title withDetail:(NSString*)detail{
    switch (state) {
        case EmptyViewStateNoMoreData:
            self.ly_emptyView = [BaseEmptyView baseEmptyViewImage:image titleStr:title detailStr:detail];
            break;
        case EmptyViewStateNetError:
            self.ly_emptyView = [BaseEmptyView baseEmptyView];
             [self endMJRefresh];
            break;
        default:
            break;
    }
    __weak typeof(self) weakSelf = self;
    [self.ly_emptyView setTapContentViewBlock:^(){
        [weakSelf.mj_header beginRefreshing];
    }];
}

// UITableView -- reloadData
- (void)baseReloadData{
    [self reloadData];
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

-(void)setBaseEstimatedRowHeight:(CGFloat)baseEstimatedRowHeight{
    _baseEstimatedRowHeight = baseEstimatedRowHeight;
    self.estimatedRowHeight = baseEstimatedRowHeight;
}

-(void)setBaseEstimatedSectionHeaderHeight:(CGFloat)baseEstimatedSectionHeaderHeight{
    _baseEstimatedSectionHeaderHeight = baseEstimatedSectionHeaderHeight;
    self.estimatedSectionHeaderHeight = _baseEstimatedSectionHeaderHeight;
}

-(void)setBaseEstimatedSectionFooterHeight:(CGFloat)baseEstimatedSectionFooterHeight{
    _baseEstimatedSectionFooterHeight = baseEstimatedSectionFooterHeight;
    self.estimatedSectionFooterHeight = baseEstimatedSectionFooterHeight;
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
    return 1;
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
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.viewForFooterInSectionBlock) {
        return self.viewForFooterInSectionBlock(tableView, section);
    }
    return nil;
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

#pragma mark UITableViewDelegate -- Variable estimatedheight support
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.estimatedHeightForRowAtIndexPathBlock) {
        return self.estimatedHeightForRowAtIndexPathBlock(tableView, indexPath);
    }
    if (self.baseEstimatedRowHeight) {
        return self.baseEstimatedRowHeight;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    if (self.estimatedHeightForHeaderInSectionBlock) {
        return self.estimatedHeightForHeaderInSectionBlock(tableView, section);
    }
    if (self.baseEstimatedSectionHeaderHeight) {
        return self.baseEstimatedSectionHeaderHeight;
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    if (self.estimatedHeightForFooterInSectionBlock) {
        return self.estimatedHeightForFooterInSectionBlock(tableView, section);
    }
    if (self.baseEstimatedSectionFooterHeight) {
        return self.baseEstimatedSectionFooterHeight;
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
