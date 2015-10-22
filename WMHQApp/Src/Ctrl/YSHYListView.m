//
//  YSHYListView.m
//  WMPCDApp
//
//  Created by 杨淑园 on 15/10/9.
//  Copyright © 2015年 yangshuyuan. All rights reserved.
//

#import "YSHYListView.h"

@implementation YSHYListView

-(instancetype)init
{
    if(self = [super init])
    {
        [self setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self setupBackGroundView];
        [self setupTableView];
    }
    return  self;
}


-(void)setupBackGroundView
{
    if(!_bakeGroundView)
    {
        _bakeGroundView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:_bakeGroundView];
    }
    [_bakeGroundView setBackgroundColor:[UIColor blackColor]];
    _bakeGroundView.hidden = YES;
    _bakeGroundView.alpha = 0.5;
    
}

-(void)setupTableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }
    
}

-(void)ConfigTableViewData:(NSArray *)array
{
    if(!_tableData)
    {
        _tableData = [[NSArray alloc]init];
        [_tableView setBackgroundColor:[UIColor redColor]];
        _tableView.hidden = YES;
    }
    _tableData = array;
    
}

-(void)freshTableViewData
{
    [_tableView reloadData];
}

#pragma  maek - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = _tableData.count;
    CGFloat height ;
    if(row * 30 > self.frame.size.height)
    {
        
        height = self.frame.size.height - 100;
        
    }
    else
    {
        height = row * 30;
    }
    [tableView setFrame:CGRectMake(0, 100,self.frame.size.width - 40,height)];
    tableView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    return  row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = _tableData[indexPath.row];
    
//    if (_lastIndexPath == indexPath) {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    return  cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  30;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_lastIndexPath) {
        UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:_lastIndexPath];
        lastCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    UITableViewCell *cell =  [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [self.delegate SelectedTableViewRow:cell.textLabel.text];
    
    _lastIndexPath = [indexPath copy];
}

-(void)show
{
    
        _bakeGroundView.hidden = NO;
        [_tableView reloadData];
        _tableView.hidden = NO;
    
}



@end
