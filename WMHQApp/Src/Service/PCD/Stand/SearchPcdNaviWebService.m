//
//  FeedbackWebService.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-16.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "SearchPcdNaviWebService.h"
#import "PcdNaviRtnVO.h"

@implementation SearchPcdNaviWebService

static SearchPcdNaviWebService * sharedService = nil;

+ (SearchPcdNaviWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[SearchPcdNaviWebService alloc] init];
    }
    
    return sharedService;
}

- (PcdNaviRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_STAND_NAVI_SEARCH xmlStr:xmlStr];
    
    return [self getPcdNaviRtnVO:dict];
}

- (PcdNaviRtnVO *) getPcdNaviRtnVO: (NSDictionary *)dict {
    
    PcdNaviRtnVO * rtnVO = [[PcdNaviRtnVO alloc] init];
    rtnVO.ResultFlag=[[dict objectForKey:RESULT_FLAG] intValue];
    rtnVO.ResultMesg=[dict objectForKey:RESULT_MESG];
    
    NSString *aktnrStr = [dict objectForKey:AKTNR_STR];
    NSString *operStr = [dict objectForKey:OPER_STR];
    NSString *puunitStr = [dict objectForKey:HAS_AUTH_PUUNIT_STR];
    
    NSArray *aktnrStrArr = [aktnrStr componentsSeparatedByString:@","];
    NSArray *operStrArr = [operStr componentsSeparatedByString:@","];
    NSArray *puunitStrArr = [puunitStr componentsSeparatedByString:@","];
    
    NSMutableArray *aktnrList = [[NSMutableArray alloc] init];
    NSMutableArray *operList = [[NSMutableArray alloc] init];
    NSMutableArray *puunitList = [[NSMutableArray alloc] init];
    
    for (NSString *str in aktnrStrArr) {
        [aktnrList addObject: [self getVal:str]];
    }
    for (NSString *str in operStrArr) {
        [operList addObject: [self getVal:str]];
    }
    for (NSString *str in puunitStrArr) {
        [puunitList addObject: [self getVal:str]];
    }
    
    rtnVO.AktnrList = aktnrList;
    rtnVO.OperList = operList;
    rtnVO.PuunitList = puunitList;
    
    return rtnVO;
}

@end
