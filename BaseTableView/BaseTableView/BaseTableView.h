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

@interface BaseTableView : UITableView

// 添加MJHeader
- (void)addMJHeader:(mjheaderBlock)block;

// 添加MJFooter
- (void)addMJFooter:(mjfooterBlock)block;

//TableVIew  ReloadData
- (void)baseReloadData;

@property(nonatomic,strong)NSMutableArray *dataArray; /** 数据源 */

@end
