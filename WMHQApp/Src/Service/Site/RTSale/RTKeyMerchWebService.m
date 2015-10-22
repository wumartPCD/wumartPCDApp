//
//  ReportsWebService.m
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "RTKeyMerchWebService.h"

@implementation RTKeyMerchWebService

static RTKeyMerchWebService * sharedService = nil;

+ (RTKeyMerchWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[RTKeyMerchWebService alloc] init];
    }
    
    return sharedService;
}

- (CommReportsRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_RT_KEY_MERCH xmlStr:xmlStr];
    
    return [self getCommReportsRtnVO:dict];
}

@end
