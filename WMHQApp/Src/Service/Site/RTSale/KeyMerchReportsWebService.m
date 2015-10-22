//
//  ReportsWebService.m
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "KeyMerchReportsWebService.h"

@implementation KeyMerchReportsWebService

static KeyMerchReportsWebService * sharedService = nil;

+ (KeyMerchReportsWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[KeyMerchReportsWebService alloc] init];
    }
    
    return sharedService;
}

- (CommMasterAndReportsRtnVO *) exec:(NSString *)xmlStr {
    NSDictionary *dict=[self execComm:FUNC_TYPE_KEY_MERCH xmlStr:xmlStr];
    
    return [self getCommMasterAndReportsRtnVO:dict];
}

@end
