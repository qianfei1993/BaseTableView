//
//  BaseTableView.h
//  Common
//
//  Created by damai on 2018/9/11.
//  Copyright © 2018年 qianfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
typedef void(^mjheaderBlock) (void);
typedef void(^mjfooterBlock) (void);
typedef void(^tapReloadBlock) (void);

typedef NS_OPTIONS(NSUInteger, EmptyViewState) {
    ///暂无数据
    EmptyViewStateNoMoreData = 0,
    ///网络异常
    EmptyViewStateNetError,
};

@interface BaseTableView : UITableView

// MJRefresh
// 添加MJHeader
- (void)addMJHeader:(mjheaderBlock)block;
// 添加MJFooter
- (void)addMJFooter:(mjfooterBlock)block;
//结束刷新
- (void)endMJRefresh;

//TableVIew  ReloadData
- (void)baseReloadData;

/**
 *  空页面  emptyView
 *
 *  @param state            空页面类型
 *  @param image            空页面图片
 *  @param title            空页面标题
 *  @param detail           空页面副标题
 */
- (void)emptyViewState:(EmptyViewState)state withImage:(NSString*)image withTitle:(NSString*)title withDetail:(NSString*)detail;


//UITableViewDelegate & UITableDatasource  => block
// @property
@property (nonatomic, assign) CGFloat baseRowHeight;             
@property (nonatomic, assign) CGFloat baseSectionHeaderHeight;   
@property (nonatomic, assign) CGFloat baseSectionFooterHeight;   
@property (nonatomic, assign) CGFloat baseEstimatedRowHeight;
@property (nonatomic, assign) CGFloat baseEstimatedSectionHeaderHeight;
@property (nonatomic, assign) CGFloat baseEstimatedSectionFooterHeight;

// UITableViewDataSource
@property (nonatomic, copy) NSInteger (^numberOfSectionsInTableViewBlock)(UITableView *tableView);
@property (nonatomic, copy) NSInteger (^numberOfRowsInSectionBlock)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) UITableViewCell* (^cellForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);

// UITableViewDelegate -- Section header & footer
@property (nonatomic, copy) UIView* (^viewForHeaderInSectionBlock)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) UIView* (^viewForFooterInSectionBlock)(UITableView *tableView, NSInteger section);


// UITableViewDelegate -- Variable height support
@property (nonatomic, copy) CGFloat (^heightForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) CGFloat (^heightForHeaderInSectionBlock)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) CGFloat (^heightForFooterInSectionBlock)(UITableView *tableView, NSInteger section);

// UITableViewDelegate -- Variable estimatedheight support
@property (nonatomic, copy) CGFloat (^estimatedHeightForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) CGFloat (^estimatedHeightForHeaderInSectionBlock)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) CGFloat (^estimatedHeightForFooterInSectionBlock)(UITableView *tableView, NSInteger section);


// wUITableViewDelegate -- The user changes the selection.
@property (nonatomic, copy) void (^didSelectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^didDeselectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);

@end
