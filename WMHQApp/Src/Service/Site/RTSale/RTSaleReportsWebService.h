//
//  ReportsWebService.h
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "BaseWebService.h"

@interface RTSaleReportsWebService : BaseWebService

+ (RTSaleReportsWebService *) sharedInstance;

- (CommReportsRtnVO *) exec:(NSString *)xmlStr;
    
@end
