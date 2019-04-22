//
//  BaseTableViewController.m
//  BaseTableView
//
//  Created by damai on 2019/4/22.
//  Copyright © 2019 personal. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableView.h"
#import "FirstStyleTableViewCell.h"
#import "SecondStyleTableViewCell.h"
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
@interface BaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;
@property (nonatomic, assign) NSInteger page;   /** 分页 */
@property (nonatomic, assign) NSInteger sectionCount; /** 分组数量 */
@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithTableView];
}

#pragma mark —————UITableView—————
- (void)initWithTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.sectionCount = 2;
    [self.tableView addMJHeader:^{
        self.page = 0;
        self.sectionCount = 2;
        [self loadData];
    }];
    [self.tableView addMJFooter:^{
        self.page ++;
        [self loadData];
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstStyleTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstStyleTableViewCellID"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableView.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        FirstStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstStyleTableViewCellID" forIndexPath:indexPath];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.tableView.dataArray[indexPath.row]];
        cell.contentView.backgroundColor = kRandomColor;
        cell.separatorLine.backgroundColor = [UIColor blackColor];
        return cell;
    }else{
        SecondStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondStyleTableViewCellID"];
        if (!cell) {
            cell = [[SecondStyleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondStyleTableViewCellID"];
            cell.separatorLine.backgroundColor = [UIColor blueColor];
            cell.contentView.backgroundColor = [UIColor cyanColor];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.tableView.dataArray[indexPath.row]];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 300, 35)];
    label.text = [NSString stringWithFormat:@"第%ld组头部视图",(long)section];
    label.textColor = [UIColor blackColor];
    [headView addSubview:label];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = [UIColor purpleColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 300, 50)];
    label.text = [NSString stringWithFormat:@"第%ld组尾部视图",(long)section];
    label.textColor = [UIColor blackColor];
    [footerView addSubview:label];
    footerView.backgroundColor = [UIColor darkGrayColor];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

//模拟数据
- (void)loadData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.page == 0) {
            [self.tableView.dataArray removeAllObjects];
            NSArray *array = @[@"假数据1", @"假数据2", @"假数据3",@"假数据4", @"假数据5", @"假数据6",@"假数据7", @"假数据8", @"假数据9"];
            [self.tableView.dataArray addObjectsFromArray:array];
        }
        if (self.page > 0) {
            for (int i = 0; i < 5; i++) {
                NSString *str = [NSString stringWithFormat:@"新增数据%ld",(long)self.page];
                [self.tableView.dataArray addObject:str];
            }
        }
        [self.tableView baseReloadData];
        if (self.page > 3) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    });
}

// 清空数据
- (IBAction)clearDataAction:(UIButton *)sender {
    [self.tableView.dataArray removeAllObjects];
    self.sectionCount = 0;
    [self.tableView baseReloadData];
}














/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
