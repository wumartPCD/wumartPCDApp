//
//  ReportsWebService.m
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "SitePerfmTop10WebService.h"

@implementation SitePerfmTop10WebService

static SitePerfmTop10WebService * sharedService = nil;

+ (SitePerfmTop10WebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[SitePerfmTop10WebService alloc] init];
    }
    
    return sharedService;
}

- (CommReportsRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_SITE_PERFM_Top10 xmlStr:xmlStr];
    
    return [self getCommReportsRtnVO:dict];
}

@end
