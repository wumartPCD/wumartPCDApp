//
//  BaseWebService.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-11.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FuncConst.h"
#import "CommConst.h"
#import "ParamConst.h"
#import "ServiceArgs.h"
#import "ServiceHelper.h"
#import "SoapXmlParseHelper.h"
#import "CommReportsRtnVO.h"
#import "MasterDataRtnVO.h"
#import "CommMasterAndReportsRtnVO.h"

@interface BaseWebService : NSObject

- (NSDictionary *) execComm: (NSString *)funcCode xmlStr:(NSString *)xmlStr;
- (CommReportsRtnVO *) getCommReportsRtnVO: (NSDictionary *)dict;
- (MasterDataRtnVO *) getCommMasterRtnVO: (NSDictionary *)dict;
- (CommMasterAndReportsRtnVO *) getCommMasterAndReportsRtnVO: (NSDictionary *)dict;
- (NSString *) getVal: (NSString *)val;

@end
