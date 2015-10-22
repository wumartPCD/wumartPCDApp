//
//  CheckVersionWebService.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-20.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "CheckVersionWebService.h"

@implementation CheckVersionWebService

static CheckVersionWebService * sharedService = nil;

+ (CheckVersionWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[CheckVersionWebService alloc] init];
    }
    
    return sharedService;
}

- (AppVersionRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_CHECK_VERSION xmlStr:xmlStr];
    
    AppVersionRtnVO * rtnVO = [[AppVersionRtnVO alloc] init];
    rtnVO.ResultFlag=[[dict objectForKey:RESULT_FLAG] intValue];
    rtnVO.ResultMesg=[dict objectForKey:RESULT_MESG];
    rtnVO.VerCode=[dict objectForKey:APP_VER_CODE];
    rtnVO.VerIntro=[dict objectForKey:APP_VER_INTRO];
    
    return rtnVO;
}

@end
