//
//  ViewController.m
//  BaseTableView
//
//  Created by damai on 2018/10/18.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "ViewController.h"
#import "BaseTableView.h"
#import "TableViewCell.h"
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
@interface ViewController ()
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, assign) NSInteger page;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initTableView];
}

- (void)initTableView{
    
    _page = 0;
    [self.tableView addMJHeader:^{
        self.page = 0;
        [self.dataSource removeAllObjects];
        [self loadData];
    }];
    [self.tableView addMJFooter:^{
        self.page ++;
        [self loadData];
    }];
    self.tableView.baseRowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cellIID"];
    self.tableView.numberOfSectionsInTableViewBlock = ^NSInteger(UITableView *tableView) {
        return self.sectionCount;
    };
    self.tableView.numberOfRowsInSectionBlock = ^NSInteger(UITableView *tableView, NSInteger section) {
        return self.dataSource.count;
    };
    self.tableView.cellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIID" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataSource[indexPath.row]];
        cell.backgroundColor = kRandomColor;
        return cell;
    };
    self.tableView.viewForHeaderInSectionBlock = ^UIView *(UITableView *tableView, NSInteger section) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 414, 30)];
        headView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 300, 30)];
        label.text = [NSString stringWithFormat:@"第%ld组头部是图",section];
        label.textColor = [UIColor blackColor];
        [headView addSubview:label];
        return headView;
    };
    self.tableView.heightForHeaderInSectionBlock = ^CGFloat(UITableView *tableView, NSInteger section) {
        return 50;
    };
    self.tableView.viewForFooterInSectionBlock = ^UIView *(UITableView *tableView, NSInteger section) {
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 414, 30)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 300, 30)];
        label.text = [NSString stringWithFormat:@"第%ld组尾部是图",section];
        label.textColor = [UIColor blackColor];
        [footerView addSubview:label];
        footerView.backgroundColor = [UIColor darkGrayColor];
        return footerView;
    };
    self.tableView.heightForFooterInSectionBlock = ^CGFloat(UITableView *tableView, NSInteger section) {
        return 30;
    };
  
    [self.tableView setDidSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
        NSLog(@"当前点击第%ld行",indexPath.row);
    }];
}

//模拟数据
- (void)loadData{
    
    [self.tableView emptyViewState:EmptyViewStateNoMoreData withImage:@"nodata@2x.png" withTitle:@"暂无数据" withDetail:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.tableView endMJRefresh];
        NSArray *array = @[@"假数据1", @"假数据2", @"假数据3",@"假数据4", @"假数据5", @"假数据6",@"假数据7", @"假数据8", @"假数据9"];
        if (self.page == 0) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:array];
        }else{
            if (self.page < 3) {
                NSString *dataStr = [NSString stringWithFormat:@"新增数据%ld",(long)self.page];
                [self.dataSource addObject:dataStr];
            }else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        self.sectionCount = 3;
        [self.tableView baseReloadData];
    });
}

// 清除数据
- (IBAction)calearDataAction:(UIButton *)sender {
    
    [self.dataSource removeAllObjects];
    [self.tableView baseReloadData];
}

//模拟断网
- (IBAction)brokenBetworkAction:(UIButton *)sender {
    [self.tableView emptyViewState:EmptyViewStateNetError withImage:nil withTitle:nil withDetail:nil];
    self.sectionCount = 0;
    [self.dataSource removeAllObjects];
    [self.tableView baseReloadData];
}


-(NSMutableArray*)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
