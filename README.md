# BaseTableView
## 效果图
![](https://raw.githubusercontent.com/qianfei1993/BaseTableView/master/BaseTableView/image1.png)
![](https://raw.githubusercontent.com/qianfei1993/BaseTableView/master/BaseTableView/image2.png)
![](https://raw.githubusercontent.com/qianfei1993/BaseTableView/master/BaseTableView/image3.png)
![](https://raw.githubusercontent.com/qianfei1993/BaseTableView/master/BaseTableView/image4.png)
#### 将部分delegate方法转为block方法，方便调用
#### 集成无数据占位图，下拉刷新，上拉加载，调用即可实现相应功能
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
