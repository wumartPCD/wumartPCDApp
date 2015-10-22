//
//  FeedbackWebService.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-16.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "SiteListWebService.h"

@implementation SiteListWebService

static SiteListWebService * sharedService = nil;

+ (SiteListWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[SiteListWebService alloc] init];
    }
    
    return sharedService;
}

- (MasterDataRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_SITE_LIST xmlStr:xmlStr];
    
    return [self getCommMasterRtnVO:dict];
}
@end
