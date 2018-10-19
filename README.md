# BaseTableView
#### 将部分delegate方法转为block方法，方便调用
#### 集成无数据占位图，下拉刷新，上拉加载，调用即可实现相应功能
```
// 下拉刷新
[self.tableView addMJHeader:^{
    
}];
 上拉加载
[self.tableView addMJFooter:^{
  
}];
// 添加空页面  
[self.tableView emptyViewState:EmptyViewStateNoMoreData scrollEnabled:YES imgName:@"image.png" titleStr:@"没有数据了" detailStr:@""];

```
