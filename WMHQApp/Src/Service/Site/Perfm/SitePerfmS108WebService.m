//
//  ReportsWebService.m
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "SitePerfmS108WebService.h"

@implementation SitePerfmS108WebService

static SitePerfmS108WebService * sharedService = nil;

+ (SitePerfmS108WebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[SitePerfmS108WebService alloc] init];
    }
    
    return sharedService;
}

- (CommReportsRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_SITE_PERFM_S108 xmlStr:xmlStr];
    
    return [self getCommReportsRtnVO:dict];
}

@end
