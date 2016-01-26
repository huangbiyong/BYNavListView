//
//  ViewController.m
//  BYNavListView
//
//  Created by Huangbiyong on 16/1/22.
//  Copyright © 2016年 Super. All rights reserved.
//

#import "ViewController.h"
#import "BYNavListView.h"


@interface ViewController ()<BYNavListDelegate>
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BYNavListView *view = [BYNavListView share];
    view.listArray = @[@"白色",@"红色",@"绿色",@"黄色"];
    view.delegate = self;
    [view setNavigationTitleViewByViewController:self];
    [self.view addSubview:view];
    

    //edit1  <--------> 01
    //edit2  <--------> 02
    
    //edit1  <--------> 03
    //edit2  <--------> 04
    
     _titleLabel.text = view.listArray[0];
}


//BYNavListDelegate 代理
-(void)navListView:(BYNavListView *)listView didSelectRow:(NSInteger)row
{
    if(row==0)
    {
       self.view.backgroundColor = [UIColor whiteColor];
    }
    else if (row==1) //红色
    {
        self.view.backgroundColor = [UIColor redColor];
    }
    else if(row==2) //绿色
    {
        self.view.backgroundColor = [UIColor greenColor];
    }
    else if (row==3) //黄色
    {
        self.view.backgroundColor = [UIColor yellowColor];
    }
    
    
    _titleLabel.text = listView.listArray[row];
}

@end
