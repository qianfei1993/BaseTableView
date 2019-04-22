# BaseTableView
## 效果图
#### 上拉刷新&上拉加载
![下拉刷新](https://raw.githubusercontent.com/qianfei1993/BaseTableView/master/BaseTableView/image1.png)
![上拉加载](https://raw.githubusercontent.com/qianfei1993/BaseTableView/master/BaseTableView/image2.png)

#### 空页面展示
![无数据](https://raw.githubusercontent.com/qianfei1993/BaseTableView/master/BaseTableView/image3.png)
![无网络](https://raw.githubusercontent.com/qianfei1993/BaseTableView/master/BaseTableView/image4.png)

## 介绍
#### TableView常用代理转为Block，集成下拉刷新，上拉加载，无数据页面，使列表实现更为简洁，依赖MJRefresh与LYEmptyView第三方框架；
## 使用
#### 创建UITableView继承自BaseTableView，调用block数据源方法；
```
// block调用数据源方法
self.tableView.numberOfRowsInSectionBlock = ^NSInteger(UITableView *tableView, NSInteger section) {
    return 10;
};
self.tableView.cellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIID" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataSource[indexPath.row]];
    cell.backgroundColor = kRandomColor;
    return cell;
};
// block调用delegate方法
[self.tableView setDidSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
    NSLog(@"当前点击第%ld行",indexPath.row);
}];

// 下拉刷新
[self.tableView addMJHeader:^{
    
}];
 上拉加载
[self.tableView addMJFooter:^{
  
}];
// 添加空页面  
[self.tableView emptyViewState:EmptyViewStateNoMoreData scrollEnabled:YES imgName:@"image.png" titleStr:@"没有数据了" detailStr:@""];

```
