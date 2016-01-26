//
//  BYNavListView.h
//  Project02
//
//  Created by Huangbiyong on 16/1/9.
//  Copyright © 2016年 sihaizhongxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BYNavListView;


typedef void(^selectRowBlock)(NSInteger row);

@protocol BYNavListDelegate <NSObject>

-(void)navListView:(BYNavListView*)listView didSelectRow:(NSInteger)row;

@end



@interface BYNavListView : UIView

@property (nonatomic,strong) NSArray *listArray;
@property (nonatomic,strong) selectRowBlock selectRowBlock;

@property (nonatomic) NSInteger selectRow;

@property (nonatomic,strong)id<BYNavListDelegate> delegate;

+(BYNavListView*)share;

//字符串文字的长度
-(CGFloat)widthOfString:(NSString*)string font:(UIFont*)font height:(CGFloat)height;

-(void)setNavigationTitleViewByViewController:(UIViewController*)vcs;


@end





