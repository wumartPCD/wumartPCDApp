//
//  BaseReportsRtnVO.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-11.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRtnVO.h"

@interface PcdNaviRtnVO : BaseRtnVO

@property(strong, nonatomic) NSMutableArray *AktnrList;
@property(strong, nonatomic) NSMutableArray *OperList;
@property(strong, nonatomic) NSMutableArray *PuunitList;

@end
