//
//  ReportsWebService.m
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "SitePerfmS107WebService.h"

@implementation SitePerfmS107WebService

static SitePerfmS107WebService * sharedService = nil;

+ (SitePerfmS107WebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[SitePerfmS107WebService alloc] init];
    }
    
    return sharedService;
}

- (CommReportsRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_SITE_PERFM_S107 xmlStr:xmlStr];
    
    return [self getCommReportsRtnVO:dict];
}

@end
