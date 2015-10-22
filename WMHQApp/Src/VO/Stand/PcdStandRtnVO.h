//
//  BaseReportsRtnVO.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-11.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRtnVO.h"

@interface PcdStandRtnVO : BaseRtnVO

@property(strong, nonatomic) NSString *StandNo;
@property(strong, nonatomic) NSString *PcdNo;
@property(strong, nonatomic) NSString *SiteTmpl;
@property(strong, nonatomic) NSString *StandCode;
@property(strong, nonatomic) NSString *Aktnr;
@property(strong, nonatomic) NSString *Oper;
@property(strong, nonatomic) NSString *Puunit;
@property(strong, nonatomic) NSString *Theme;

@property(strong, nonatomic) NSString *PcdType;
@property(strong, nonatomic) NSString *PcdNum;

@property(strong, nonatomic) NSString *ImgUrl;

@property(strong, nonatomic) NSMutableArray *PcdNoList;
@property(strong, nonatomic) NSMutableArray *ImgInfoList;
@property(strong, nonatomic) NSMutableArray *MerchList;

@end
