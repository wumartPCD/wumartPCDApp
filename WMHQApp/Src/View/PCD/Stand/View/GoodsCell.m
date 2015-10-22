//
//  GoodsCell.m
//  WMPCDApp
//
//  Created by 杨淑园 on 15/10/8.
//  Copyright © 2015年 yangshuyuan. All rights reserved.
//

#import "GoodsCell.h"
#import "UIView+Frame.h"

@implementation GoodsCell

-(instancetype)init
{
    if(self = [super init])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self ConfigUI];
    }
    return  self;

}


-(void)ConfigUI
{
    _goodsCode = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 25)];
    [self addSubview:_goodsCode];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(_goodsCode.right , _goodsCode.top, 1, _goodsCode.height)];
    [line setBackgroundColor:[UIColor grayColor]];
    [self addSubview:line];
    
    _goodsName = [[UILabel alloc]initWithFrame:CGRectMake(line.right , _goodsCode.top,self.bounds.size.width - line.right , _goodsCode.height)];
    [self addSubview:_goodsName];
}


-(void)ConfigCellData:(NSDictionary *)dic
{
//    _goodsCode.text = @"K1237918";
//    _goodsName.text = @"我是商品名";
    _goodsCode.text = dic[@"goodsCode"];
    _goodsName.text = dic[@"goodsName"];

}


@end
