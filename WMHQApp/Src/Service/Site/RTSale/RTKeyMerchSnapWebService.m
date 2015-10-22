//
//  ReportsWebService.m
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "RTKeyMerchSnapWebService.h"

@implementation RTKeyMerchSnapWebService

static RTKeyMerchSnapWebService * sharedService = nil;

+ (RTKeyMerchSnapWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[RTKeyMerchSnapWebService alloc] init];
    }
    
    return sharedService;
}

- (CommReportsRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_RT_KEY_MERCH_SNAP xmlStr:xmlStr];
    
    return [self getCommReportsRtnVO:dict];
}

@end
