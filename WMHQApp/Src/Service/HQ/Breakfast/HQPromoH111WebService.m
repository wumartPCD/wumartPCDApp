//
//  ReportsWebService.m
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "HQPromoH111WebService.h"

@implementation HQPromoH111WebService

static HQPromoH111WebService * sharedService = nil;

+ (HQPromoH111WebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[HQPromoH111WebService alloc] init];
    }
    
    return sharedService;
}

- (CommReportsRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_HQ_PROMO_H111 xmlStr:xmlStr];
    
    return [self getCommReportsRtnVO:dict];
}

@end
