//
//  YSHYListView.h
//  WMPCDApp
//
//  Created by 杨淑园 on 15/10/9.
//  Copyright © 2015年 yangshuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height


@protocol YSHYListViewDelegate <NSObject>

-(void)SelectedTableViewRow:(NSString *)string;

@end


@interface YSHYListView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_bakeGroundView;
    UITableView * _tableView;
    NSArray *_tableData;
    NSIndexPath *_lastIndexPath;
}

@property (nonatomic, assign)id<YSHYListViewDelegate>delegate;
-(void)ConfigTableViewData:(NSArray *)array;
-(void)freshTableViewData;
-(void)show;

@end
