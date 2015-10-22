//
//  RTSaleViewController.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseRTSaleReportsController.h"
#import "PopMenu.h"
#import "KeyMerchReportsWebService.h"
#import "KeyMerchSearchWhere.h"
#import "XMLHandleHelper.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "GlobalApp.h"
#import "XWAlterview.h"

@implementation BaseRTSaleReportsController

- (void) onSearchBtnClick:(id)sender
{
    if ([self isKeyMerch]) {
        NSMutableArray *menuItems = [[NSMutableArray alloc] initWithCapacity:2];
        NSMutableArray *dataList;
        if ([self isKeyMerchSite]) {
            dataList=siteWhere.SiteList;
        }else{
            dataList=merchWhere.KeyMerchList;
        }
        for (NSString *item in dataList) {
            [menuItems addObject:[PopMenuItem menuItem:item image:nil target:self action:@selector(onSiteSelected:)]];
        }
        [PopMenu showMenuInView:self.view
                       fromRect:((UIButton *)sender).frame
                      menuItems:menuItems];
    }
}

- (void) onSiteSelected:(id)sender
{
    PopMenuItem *item = (PopMenuItem *)sender;
    
    if ([self isKeyMerchSite]) {
        NSArray *sites = [item.title componentsSeparatedByString:@"-"];
        siteWhere.CurSiteNo = [sites objectAtIndex:0];
    }else{
        merchWhere.CurKeyMerch = item.title;
    }
    
    [self loadReportsByFuncNo:nil];
}

- (BOOL) isKeyMerch
{
    NSString *pMenuID = [globalApp getValue:CUR_SUPER_MENU_ID];
    if ([MENUID_KEY_MERCH isEqualToString: pMenuID]) {
        return true;
    }else{
        return false;
    }
}

- (BOOL) isKeyMerchSite
{
    NSString *menuID = [globalApp getValue:CUR_MENU_ID];
    if ([MENUID_KEY_MERCH_SITE isEqualToString: menuID]) {
        return true;
    }else{
        return false;
    }
}

-(NSString *)fetchKeyMerchList:(NSString *)isSnap {
    
    NSString *loginUserCode= [globalApp getValue:CUR_LOGIN_USER_NO];
    
    merchWhere = [globalApp getValue:CUR_KEY_MERCH_WHERE];
    if (merchWhere == Nil) {
        merchWhere = [[KeyMerchSearchWhere alloc] init];
        [globalApp putValue:CUR_KEY_MERCH_WHERE value:merchWhere];
    }
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:loginUserCode, [self getCurFuncNo], isSnap, AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, FUNC_MENU_ID, IS_SNAP, AUTH_KEY, nil];
    
    XMLHandleHelper* xmlHelper = [XMLHandleHelper sharedInstance];
    
    KeyMerchReportsWebService * service = [KeyMerchReportsWebService sharedInstance];
    CommMasterAndReportsRtnVO* rtnVO;
    @try {
        rtnVO = [service exec: [xmlHelper createParamXmlStr:valArr colName:colNameArr]];
        
        if([rtnVO ResultFlag] == 0){
            [merchWhere fetchKeyMerch:rtnVO];
            [self makeReportsHtml:rtnVO];
        }else{
            [self displayHintInfo:rtnVO.ResultMesg];
        }
    } @catch (NSException *exp) {
        [self displayHintInfo:@"请检查您的网络是否正常！"];
    }
    
    return @"";
}

@end

