//
//  ReportsWebService.m
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "RTSaleReportsWebService.h"

@implementation RTSaleReportsWebService

static RTSaleReportsWebService * sharedService = nil;

+ (RTSaleReportsWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[RTSaleReportsWebService alloc] init];
    }
    
    return sharedService;
}

- (CommReportsRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_RTSALE xmlStr:xmlStr];
    
    return [self getCommReportsRtnVO:dict];
}

@end
