//
//  LoginWebService.m
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "LoginWebService.h"

#import "CommConst.h"
#import "SoapXmlParseHelper.h"
#import "AppSysVO.h"
#import "AppAreaVO.h"
#import "MenusVO.h"

@implementation LoginWebService

static LoginWebService * sharedService = nil;

+ (LoginWebService *) sharedInstance {
    if (sharedService == nil) {
        sharedService = [[LoginWebService alloc] init];
    }
    
    return sharedService;
}

- (LoginUserRtnVO *) exec:(NSString *)xmlStr{
    
    NSDictionary *dict=[self execComm:FUNC_TYPE_LOGIN xmlStr:xmlStr];
    
    LoginUserRtnVO * rtnVO = [[LoginUserRtnVO alloc] init];
    rtnVO.ResultFlag=[[dict objectForKey:RESULT_FLAG] intValue];
    rtnVO.ResultMesg=[dict objectForKey:RESULT_MESG];
    rtnVO.UserId=[dict objectForKey:LOGIN_USER_ID];
    rtnVO.UserName=[dict objectForKey:LOGIN_USER_NAME];
    
    NSString *appSysStr=[dict objectForKey:HAS_AUTH_APP_SYS_STR];
    NSString *appAreaStr=[dict objectForKey:HAS_AUTH_APP_AREA_STR];
    NSString *siteStr=[dict objectForKey:HAS_AUTH_SITE_STR];
    NSString *menusStr=[dict objectForKey:HAS_AUTH_MENUS_STR];
    
    NSArray *firstSplit = [appSysStr componentsSeparatedByString:@","];
    rtnVO.AppSysVOArr = [[NSMutableArray alloc] initWithCapacity:firstSplit.count];
    NSArray *secondSplit;
    AppSysVO *appSys;
    for (id itemStr in firstSplit) {
        secondSplit=[itemStr componentsSeparatedByString:@"_"];
        if ([secondSplit count]==2) {
            appSys =[[AppSysVO alloc] init];
            appSys.AppID=[secondSplit objectAtIndex:0];
            appSys.AppName=[secondSplit objectAtIndex:1];
            [rtnVO.AppSysVOArr addObject:appSys];
        }
    }
    firstSplit = [appAreaStr componentsSeparatedByString:@","];
    rtnVO.AppAreaVOArr = [[NSMutableArray alloc] initWithCapacity:firstSplit.count];
    AppAreaVO *appArea;
    for (id itemStr in firstSplit) {
        secondSplit=[itemStr componentsSeparatedByString:@"_"];
        if ([secondSplit count]==3) {
            appArea =[[AppAreaVO alloc] init];
            appArea.AppID=[secondSplit objectAtIndex:0];
            appArea.Mandt=[secondSplit objectAtIndex:1];
            appArea.MandtName=[secondSplit objectAtIndex:2];
            [rtnVO.AppAreaVOArr addObject:appArea];
        }
    }
    firstSplit = [siteStr componentsSeparatedByString:@","];
    rtnVO.SiteArr = [[NSMutableArray alloc] initWithCapacity:firstSplit.count];
    for (id itemStr in firstSplit) {
        if (((NSString *)itemStr).length>0) {
            [rtnVO.SiteArr addObject:itemStr];
        }
    }
    firstSplit = [menusStr componentsSeparatedByString:@","];
    rtnVO.MenusArr = [[NSMutableArray alloc] initWithCapacity:firstSplit.count];
    MenusVO *menus;
    for (id itemStr in firstSplit) {
        secondSplit=[itemStr componentsSeparatedByString:@"_"];
        if ([secondSplit count]==5) {
            menus =[[MenusVO alloc] init];
            menus.MenuID=[secondSplit objectAtIndex:0];
            menus.ParentMenuID=[secondSplit objectAtIndex:1];
            menus.MenuName=[secondSplit objectAtIndex:2];
            menus.Mandt=[secondSplit objectAtIndex:3];
            menus.AppID=[secondSplit objectAtIndex:4];
            [rtnVO.MenusArr addObject:menus];
        }
    }
    
    return rtnVO;
}

@end
