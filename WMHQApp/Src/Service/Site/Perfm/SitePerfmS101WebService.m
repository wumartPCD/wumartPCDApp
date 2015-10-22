//
//  ReportsWebService.m
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "SitePerfmS101WebService.h"

@implementation SitePerfmS101WebService

static SitePerfmS101WebService * sharedService = nil;

+ (SitePerfmS101WebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[SitePerfmS101WebService alloc] init];
    }
    
    return sharedService;
}

- (CommReportsRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_SITE_PERFM_S101 xmlStr:xmlStr];
    
    return [self getCommReportsRtnVO:dict];
}

@end
