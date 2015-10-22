//
//  GoodsCell.h
//  WMPCDApp
//
//  Created by 杨淑园 on 15/10/8.
//  Copyright © 2015年 yangshuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCell : UITableViewCell
{
    UILabel *_goodsCode;
    UILabel *_goodsName;
}

-(void)ConfigCellData:(NSDictionary *)dic;



@end
