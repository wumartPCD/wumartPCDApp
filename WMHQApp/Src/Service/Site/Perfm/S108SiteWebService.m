//
//  FeedbackWebService.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-16.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "S108SiteWebService.h"

@implementation S108SiteWebService

static S108SiteWebService * sharedService = nil;

+ (S108SiteWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[S108SiteWebService alloc] init];
    }
    
    return sharedService;
}

- (MasterDataRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_SITE_PERFM_S108_SITE xmlStr:xmlStr];
    
    return [self getCommMasterRtnVO:dict];
}
@end
