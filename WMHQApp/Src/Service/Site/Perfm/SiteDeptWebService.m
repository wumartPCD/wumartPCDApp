//
//  FetchPswdWebService.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-27.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "SiteDeptWebService.h"

@implementation SiteDeptWebService

static SiteDeptWebService * sharedService = nil;

+ (SiteDeptWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[SiteDeptWebService alloc] init];
    }
    
    return sharedService;
}

- (MasterDataRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_SITE_DEPT xmlStr:xmlStr];
    
    return [self getCommMasterRtnVO:dict];
}

@end
