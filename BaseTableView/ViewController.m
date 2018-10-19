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
@property (nonatomic, assign) NSInteger page;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 0;
    __weak typeof(self) weakSelf = self;
    self.tableView.baseRowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cellIID"];
    self.tableView.numberOfRowsInSectionBlock = ^NSInteger(UITableView *tableView, NSInteger section) {
        return self.dataSource.count;
    };
    self.tableView.cellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIID" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataSource[indexPath.row]];
        cell.backgroundColor = kRandomColor;
        return cell;
    };
    [self.tableView addMJHeader:^{
        self.page = 0;
        [self loadData];
    }];
    [self.tableView addMJFooter:^{
        weakSelf.page ++;
        [self loadData];
    }];
    [self.tableView setDidSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
        NSLog(@"当前点击第%ld行",indexPath.row);
    }];
}

//模拟数据
- (void)loadData{
    
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
        [self.tableView baseReloadData];
    });
}

// 清除数据
- (IBAction)calearDataAction:(UIButton *)sender {
    
    [self.tableView emptyViewState:EmptyViewStateNoMoreData scrollEnabled:YES imgName:@"nodata@2x.png" titleStr:@"没有数据了" detailStr:@""];
    [self.dataSource removeAllObjects];
    [self.tableView baseReloadData];
}

//模拟断网
- (IBAction)brokenBetworkAction:(UIButton *)sender {
    
    [self.tableView emptyViewState:EmptyViewStateNetError scrollEnabled:NO imgName:nil titleStr:nil detailStr:nil];
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
