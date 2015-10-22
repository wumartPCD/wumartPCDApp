//
//  ReportsWebService.h
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "BaseWebService.h"
#import "CommMasterAndReportsRtnVO.h"

@interface KeyMerchReportsWebService : BaseWebService

+ (KeyMerchReportsWebService *) sharedInstance;

- (CommMasterAndReportsRtnVO *) exec:(NSString *)xmlStr;

@end
