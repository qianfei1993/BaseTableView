//
//  BlockTableViewController.m
//  BaseTableView
//
//  Created by damai on 2019/4/22.
//  Copyright © 2019 personal. All rights reserved.
//

#import "BlockTableViewController.h"
#import "BlockTableView.h"
#import "FirstStyleTableViewCell.h"
#import "SecondStyleTableViewCell.h"
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
@interface BlockTableViewController ()
@property (weak, nonatomic) IBOutlet BlockTableView *tableView;
@property (nonatomic, assign) NSInteger page;   /** 分页 */
@property (nonatomic, assign) NSInteger sectionCount; /** 分组数量 */
@end

@implementation BlockTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithBlockTableView];
}

#pragma mark —————BaseTableView—————
- (void)initWithBlockTableView{
    
    self.page = 0;
    self.sectionCount = 2;
    __weak typeof(self) weakSelf = self;
    [self.tableView addMJHeader:^{
        weakSelf.page = 0;
        self.sectionCount = 2;
        [weakSelf loadData];
    }];
    [self.tableView addMJFooter:^{
        weakSelf.page ++;
        [weakSelf loadData];
    }];
    self.tableView.baseRowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstStyleTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstStyleTableViewCellID"];
    
    self.tableView.numberOfSectionsInTableViewBlock = ^NSInteger(UITableView * _Nonnull tableView) {
        return 2;
    };
    
    self.tableView.numberOfRowsInSectionBlock = ^NSInteger(UITableView *tableView, NSInteger section) {
        return self.tableView.dataArray.count;
    };
    
    self.tableView.cellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
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
    };
    
    self.tableView.viewForHeaderInSectionBlock = ^UIView * _Nonnull(UITableView * _Nonnull tableView, NSInteger section) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 300, 35)];
        label.text = [NSString stringWithFormat:@"第%ld组头部视图",(long)section];
        label.textColor = [UIColor blackColor];
        [headView addSubview:label];
        return headView;
    };
    
    self.tableView.heightForHeaderInSectionBlock = ^CGFloat(UITableView * _Nonnull tableView, NSInteger section) {
        return 35;
    };
    
    self.tableView.viewForFooterInSectionBlock = ^UIView * _Nonnull(UITableView * _Nonnull tableView, NSInteger section) {
        UIView *footerView = [[UIView alloc]init];
        footerView.backgroundColor = [UIColor purpleColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 300, 50)];
        label.text = [NSString stringWithFormat:@"第%ld组尾部视图",(long)section];
        label.textColor = [UIColor blackColor];
        [footerView addSubview:label];
        footerView.backgroundColor = [UIColor darkGrayColor];
        return footerView;
    };
    
    self.tableView.heightForFooterInSectionBlock = ^CGFloat(UITableView * _Nonnull tableView, NSInteger section) {
        return 50;
    };
    
    self.tableView.didSelectRowAtIndexPathBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        
    };
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
