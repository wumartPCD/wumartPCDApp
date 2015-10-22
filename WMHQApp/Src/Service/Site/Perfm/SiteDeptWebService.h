//
//  FetchPswdWebService.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-27.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseWebService.h"

@interface SiteDeptWebService : BaseWebService

+ (SiteDeptWebService *) sharedInstance;

- (MasterDataRtnVO *) exec: (NSString *)xmlStr;

@end
