//
//  BlockTableView.h
//  BaseTableView
//
//  Created by damai on 2019/4/22.
//  Copyright © 2019 personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^mjheaderBlock) (void);
typedef void(^mjfooterBlock) (void);
@interface BlockTableView : UITableView
// 添加MJHeader
- (void)addMJHeader:(mjheaderBlock)block;

// 添加MJFooter
- (void)addMJFooter:(mjfooterBlock)block;

//TableVIew  ReloadData
- (void)baseReloadData;

@property(nonatomic,strong)NSMutableArray *dataArray; /** 数据源 */


//UITableViewDelegate & UITableDatasource  => block
// @property

 @property (nonatomic, assign) CGFloat baseRowHeight;
 @property (nonatomic, assign) CGFloat baseSectionHeaderHeight;
 @property (nonatomic, assign) CGFloat baseSectionFooterHeight;
 
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
 
 // UITableViewDelegate -- The user changes the selection.
 @property (nonatomic, copy) void (^didSelectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
 @property (nonatomic, copy) void (^didDeselectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
