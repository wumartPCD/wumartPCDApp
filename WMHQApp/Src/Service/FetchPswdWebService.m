//
//  FetchPswdWebService.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-27.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "FetchPswdWebService.h"

@implementation FetchPswdWebService

static FetchPswdWebService * sharedService = nil;

+ (FetchPswdWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[FetchPswdWebService alloc] init];
    }
    
    return sharedService;
}

- (LoginPswdRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_FETCH_PSWD xmlStr:xmlStr];
    
    LoginPswdRtnVO * rtnVO = [[LoginPswdRtnVO alloc] init];
    rtnVO.ResultFlag=[[dict objectForKey:RESULT_FLAG] intValue];
    rtnVO.ResultMesg=[dict objectForKey:RESULT_MESG];
    rtnVO.LoginPswd=[dict objectForKey:LOGIN_PSWD];
    
    return rtnVO;
}

@end
