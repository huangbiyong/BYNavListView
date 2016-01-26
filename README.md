# projects
导航条下拉菜单


    BYNavListView *view = [BYNavListView share];
    view.listArray = @[@"白色",@"红色",@"绿色",@"黄色"];
    view.delegate = self;
    [view setNavigationTitleViewByViewController:self];
    [self.view addSubview:view];
    
    
![image](https://raw.github.com/huangbiyong/BYNavListView/master/1.png)
![image](https://raw.github.com/huangbiyong/BYNavListView/master/2.png)
