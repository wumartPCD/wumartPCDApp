//
//  FeedbackWebService.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-16.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "SearchPcdStandWebService.h"
#import "PcdStandRtnVO.h"
#import "PcdStandListRtnVO.h"

@implementation SearchPcdStandWebService

static SearchPcdStandWebService * sharedService = nil;

+ (SearchPcdStandWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[SearchPcdStandWebService alloc] init];
    }
    
    return sharedService;
}

- (PcdStandListRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_STAND_SEARCH xmlStr:xmlStr];
    
    return [self getPcdStandListRtnVO:dict];
}

- (PcdStandListRtnVO *) getPcdStandListRtnVO: (NSDictionary *)dict {
    PcdStandListRtnVO *rtnListVo = [[PcdStandListRtnVO alloc] init];
    rtnListVo.ResultFlag=[[dict objectForKey:RESULT_FLAG] intValue];
    rtnListVo.ResultMesg=[dict objectForKey:RESULT_MESG];
    
    NSArray *standNoStrArr = [[dict objectForKey:STAND_NO] componentsSeparatedByString:@","];
    NSArray *standCodeStrArr = [[dict objectForKey:STAND_CODE] componentsSeparatedByString:@","];
    NSArray *pcdNoStrArr = [[dict objectForKey:STAND_PCD_NO] componentsSeparatedByString:@","];
    NSArray *siteTmplStrArr = [[dict objectForKey:STAND_SITE_TMPL] componentsSeparatedByString:@","];
    NSArray *aktnrStrArr = [[dict objectForKey:STAND_AKTNR] componentsSeparatedByString:@","];
    NSArray *operStrArr = [[dict objectForKey:STAND_OPER] componentsSeparatedByString:@","];
    NSArray *puunitStrArr = [[dict objectForKey:STAND_PUUNIT] componentsSeparatedByString:@","];
    NSArray *themeStrArr = [[dict objectForKey:STAND_THEME] componentsSeparatedByString:@","];
    NSArray *pcdTypeStrArr = [[dict objectForKey:STAND_PCD_TYPE] componentsSeparatedByString:@","];
    NSArray *imgUrlStrArr = [[dict objectForKey:STAND_IMG_URL] componentsSeparatedByString:@","];
    
    NSMutableArray *standList = [[NSMutableArray alloc] init];
    PcdStandRtnVO *rtnVo;
    for (int index=0; index<standNoStrArr.count; index++) {
        rtnVo = [[PcdStandRtnVO alloc] init];
        rtnVo.StandNo = [self getVal:[standNoStrArr objectAtIndex:index]];
        rtnVo.StandCode = [self getVal:[standCodeStrArr objectAtIndex:index]];
        rtnVo.PcdNo = [self getVal:[pcdNoStrArr objectAtIndex:index]];
        rtnVo.SiteTmpl = [self getVal:[siteTmplStrArr objectAtIndex:index]];
        rtnVo.Aktnr = [self getVal:[aktnrStrArr objectAtIndex:index]];
        rtnVo.Oper = [self getVal:[operStrArr objectAtIndex:index]];
        rtnVo.Puunit = [self getVal:[puunitStrArr objectAtIndex:index]];
        rtnVo.Theme = [self getVal:[themeStrArr objectAtIndex:index]];
        rtnVo.PcdType = [self getVal:[pcdTypeStrArr objectAtIndex:index]];
        rtnVo.ImgUrl = [PCD_IMG_URL stringByAppendingString:[self getVal:[imgUrlStrArr objectAtIndex:index]]];
        [standList addObject:rtnVo];
    }

    rtnListVo.PcdStandList = standList;
    
    return rtnListVo;
}

@end
