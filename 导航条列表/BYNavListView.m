//
//  BYNavListView.m
//  Project02
//
//  Created by Huangbiyong on 16/1/9.
//  Copyright © 2016年 sihaizhongxing. All rights reserved.
//

#import "BYNavListView.h"
#import "BYNavTListCell.h"

@interface BYNavListView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)BYNavTListCell *oldCell;

@property (nonatomic,strong) UIViewController *vcs;

@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation BYNavListView

+(BYNavListView*)share
{
    static BYNavListView *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[self alloc] initWithFrame:CGRectMake(0, 64-([UIScreen mainScreen].bounds.size.height-64), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    });
    
    return _instance;
}

/************************** _myTableView的初始化 **************************/
-(void)initTableView
{
    [_vcs.view bringSubviewToFront:self];
    
    _myTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorColor = [UIColor colorWithRed:230/255.0
                                                  green:230/255.0
                                                   blue:230/255.0
                                                  alpha:1.0];
    [self addSubview:_myTableView];
    
    
    [_myTableView registerNib:[UINib nibWithNibName:@"BYNavTListCell" bundle:nil]
       forCellReuseIdentifier:@"BYNavTListCell"];
}

/************************** 计算字符串和向下图标的宽度 **************************/
//字符串文字的长度
-(CGFloat)widthOfString:(NSString*)string font:(UIFont*)font height:(CGFloat)height
{
    NSDictionary * dict=[NSDictionary dictionaryWithObject:font
                                                    forKey:NSFontAttributeName];
    CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                     options:NSStringDrawingTruncatesLastVisibleLine|
                 NSStringDrawingUsesFontLeading|
                 NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dict
                                     context:nil];
    return rect.size.width;
}
/************************** 设置导航条的文字 **************************/
-(void)setNavigationTitleViewByViewController:(UIViewController*)vcs
{
    static UIView * _titleView = nil;
    
    _vcs = vcs;
    
    _contentLabel = [_titleView viewWithTag:100];
    _imgView  = [_titleView viewWithTag:101];
    
    CGFloat widthText = [self widthOfString:_listArray[0]
                                       font:[UIFont systemFontOfSize:18.0f]
                                     height:31]+5;
    if (_titleView == nil) {
        
        //设置标题
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, widthText+5+8, 31)];
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, widthText, 31)];
        _contentLabel.font = [UIFont systemFontOfSize:18.0f];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.tag = 100;
        [_titleView addSubview:_contentLabel];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(_contentLabel.frame.size.width+5, 13, 8, 6)];
        _imgView.image = [UIImage imageNamed:@"nav_drop_black"];
        _imgView.tag = 101;
        [_titleView addSubview:_imgView];
        
        vcs.navigationItem.titleView = _titleView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick)];
        [_titleView addGestureRecognizer:tap];
    }
    else
    {
        _titleView.frame = CGRectMake(_titleView.frame.origin.x, _titleView.frame.origin.y, widthText+5+8, 31);
        _contentLabel.frame = CGRectMake(0, 0, widthText, 31);
        _imgView.frame = CGRectMake(_contentLabel.frame.size.width+5, 13, 8, 6);
    }
    _contentLabel.text = _listArray[0];
}

/************************** 点击导航条事件 **************************/
-(void)titleClick
{
    if (_myTableView==nil) {
        [self initTableView];
        [_myTableView reloadData];
    }
    
    //还没展现出来
    if (self.frame.origin.y != 64) {
        
        self.hidden = NO;
        [UIView animateWithDuration:0.5f animations:^{
            
            NSInteger height = self.frame.size.height;
            NSInteger width  = self.frame.size.width;
            self.frame = CGRectMake(0, self.frame.origin.y+height, width, height);
            
            
            _imgView.transform = CGAffineTransformRotate(_imgView.transform, M_PI/180*180);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else   //收回
    {
        [UIView animateWithDuration:0.5f animations:^{
            
            NSInteger height = self.frame.size.height;
            NSInteger width  = self.frame.size.width;
            self.frame = CGRectMake(0, self.frame.origin.y-height, width, height);
            
            
            _imgView.transform = CGAffineTransformRotate(_imgView.transform, M_PI/180*(-180));
            
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }
}

/****************************** tableView代理 *******************************/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _listArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BYNavTListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BYNavTListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = _listArray[indexPath.section];
    
    if (_selectRow == indexPath.section) {
        cell.selectImgView.hidden = NO;
        _oldCell = cell;
    }
    else
    {
        cell.selectImgView.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _oldCell.selectImgView.hidden = YES;
    _selectRow = indexPath.section;
    _contentLabel.text = _listArray[_selectRow];
    
    [_delegate navListView:self didSelectRow:_selectRow];
    
    BYNavTListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectImgView.hidden = NO;
    
    _oldCell = cell;
    
    [UIView animateWithDuration:0.5f animations:^{
        
        NSInteger height = self.frame.size.height;
        NSInteger width  = self.frame.size.width;
        self.frame = CGRectMake(0, self.frame.origin.y-height, width, height);
        
        _imgView.transform = CGAffineTransformRotate(_imgView.transform, M_PI/180*(-180));
        
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}


@end





























