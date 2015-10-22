//
//  ReportsWebService.h
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "BaseWebService.h"

@interface SitePerfmS101WebService : BaseWebService

+ (SitePerfmS101WebService *) sharedInstance;

- (CommReportsRtnVO *) exec:(NSString *)xmlStr;
    
@end
