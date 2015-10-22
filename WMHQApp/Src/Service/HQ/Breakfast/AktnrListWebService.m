//
//  ReportsWebService.m
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "AktnrListWebService.h"

@implementation AktnrListWebService

static AktnrListWebService * sharedService = nil;

+ (AktnrListWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[AktnrListWebService alloc] init];
    }
    
    return sharedService;
}

- (CommMasterAndReportsRtnVO *) exec:(NSString *)xmlStr {
    NSDictionary *dict=[self execComm:FUNC_TYPE_HQ_PROMO_AKTNR xmlStr:xmlStr];
    
    return [self getCommMasterAndReportsRtnVO:dict];
}

@end
