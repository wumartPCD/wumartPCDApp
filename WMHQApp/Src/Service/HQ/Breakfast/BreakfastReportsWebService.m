//
//  ReportsWebService.m
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "BreakfastReportsWebService.h"

@implementation BreakfastReportsWebService

static BreakfastReportsWebService * sharedService = nil;

+ (BreakfastReportsWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[BreakfastReportsWebService alloc] init];
    }
    
    return sharedService;
}

- (CommReportsRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_BREAKFAST xmlStr:xmlStr];
    
    return [self getCommReportsRtnVO:dict];
}

@end
