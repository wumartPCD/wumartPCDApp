//
//  FeedbackWebService.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-16.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "FeedbackWebService.h"

@implementation FeedbackWebService

static FeedbackWebService * sharedService = nil;

+ (FeedbackWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[FeedbackWebService alloc] init];
    }
    
    return sharedService;
}

- (BaseRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_FEEDBACK xmlStr:xmlStr];
    
    BaseRtnVO * rtnVO = [[BaseRtnVO alloc] init];
    rtnVO.ResultFlag=[[dict objectForKey:RESULT_FLAG] intValue];
    rtnVO.ResultMesg=[dict objectForKey:RESULT_MESG];
    
    return rtnVO;
}
@end
