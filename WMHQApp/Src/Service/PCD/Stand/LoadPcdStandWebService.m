//
//  FeedbackWebService.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-16.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "LoadPcdStandWebService.h"
#import "PcdStandRtnVO.h"

@implementation LoadPcdStandWebService

static LoadPcdStandWebService * sharedService = nil;

+ (LoadPcdStandWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[LoadPcdStandWebService alloc] init];
    }
    
    return sharedService;
}

- (PcdStandRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_STAND_DETAIL xmlStr:xmlStr];
    
    return [self getPcdStandRtnVO:dict];
}

- (PcdStandRtnVO *) getPcdStandRtnVO: (NSDictionary *)dict {
    PcdStandRtnVO *rtnVo = [[PcdStandRtnVO alloc] init];
    rtnVo.ResultFlag=[[dict objectForKey:RESULT_FLAG] intValue];
    rtnVo.ResultMesg=[dict objectForKey:RESULT_MESG];
    
    rtnVo.StandNo=[dict objectForKey:STAND_NO];
    rtnVo.Puunit=[dict objectForKey:STAND_PUUNIT];
    rtnVo.Theme=[dict objectForKey:STAND_THEME];
    rtnVo.PcdNum=[dict objectForKey:STAND_PCD_NUM];
    
    NSArray *pcdNoStrArr = [[dict objectForKey:PCD_NO_STR] componentsSeparatedByString:@","];
    NSArray *merchStrArr = [[dict objectForKey:MERCH_STR] componentsSeparatedByString:@","];
    NSArray *imgInfoStrArr = [[dict objectForKey:IMG_INFO_STR] componentsSeparatedByString:@","];
    
    rtnVo.PcdNoList = [pcdNoStrArr mutableCopy];
    rtnVo.MerchList = [merchStrArr mutableCopy];
    rtnVo.ImgInfoList = [imgInfoStrArr mutableCopy];
    
    return rtnVo;
}

@end
