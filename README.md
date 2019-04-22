# BaseTableView
## 效果图
#### 上拉刷新&上拉加载
![下拉刷新](https://raw.githubusercontent.com/qianfei1993/BaseTableView/master/BaseTableView/image1.png)
![上拉加载](https://raw.githubusercontent.com/qianfei1993/BaseTableView/master/BaseTableView/image2.png)


#### 空页面展示
![无数据](https://raw.githubusercontent.com/qianfei1993/BaseTableView/master/BaseTableView/image3.png)

## 介绍&使用
#### BaseTableView,封装的UITableView基类，集成下拉刷新，上拉加载，无数据页面，配置公共项，但是并没有将delegate与dataSource独立出来，依赖MJRefresh与LYEmptyView第三方框架；
#### 创建UITableView继承自BaseTableView，常规UITableView写法，实现数据源与代理方法；
```
#pragma mark —————UITableView—————
- (void)initWithTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //下拉刷新
    [self.tableView addMJHeader:^{
    
    }];
    //上拉加载
    [self.tableView addMJFooter:^{
       
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
```

#### BlockTableView，UITableView常用代理转为Block，集成下拉刷新，上拉加载，无数据页面，使列表实现更为简洁，依赖MJRefresh与LYEmptyView第三方框架；
#### 创建UITableView继承自BaseTableView，调用block数据源方法；
```
#pragma mark —————BaseTableView—————
- (void)initWithBlockTableView{
 
    //下拉刷新
    [self.tableView addMJHeader:^{
       
    }];
    //上拉加载
    [self.tableView addMJFooter:^{
      
    }];
  
    self.tableView.numberOfSectionsInTableViewBlock = ^NSInteger(UITableView * _Nonnull tableView) {

    };
    
    self.tableView.numberOfRowsInSectionBlock = ^NSInteger(UITableView *tableView, NSInteger section) {

    };
    
    self.tableView.cellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
      
    };
    
    self.tableView.didSelectRowAtIndexPathBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        
    };
```
