//
//  ReportsWebService.m
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "RTSaleSnapReportsWebService.h"

@implementation RTSaleSnapReportsWebService

static RTSaleSnapReportsWebService * sharedService = nil;

+ (RTSaleSnapReportsWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[RTSaleSnapReportsWebService alloc] init];
    }
    
    return sharedService;
}

- (CommReportsRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_RTSALE_SNAP xmlStr:xmlStr];
    
    return [self getCommReportsRtnVO:dict];
}

@end
