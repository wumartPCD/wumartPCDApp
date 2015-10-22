//
//  BreakfastViewController.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "SitePerfmS107Controller.h"
#import "PopMenu.h"
#import "SitePerfmS107WebService.h"
#import "XMLHandleHelper.h"
#import "CommReportsRtnVO.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "GlobalApp.h"
#import "XWAlterview.h"
#import "SiteDeptSearchWhere.h"

@implementation SitePerfmS107Controller

- (void) onSearchBtnClick:(id)sender
{
    NSMutableArray *menuItems = [[NSMutableArray alloc] initWithCapacity:2];
    
    SiteDeptSearchWhere *searchWhere = [globalApp getValue:CUR_SITE_DEPT_WHERE];
    for (NSString *item in searchWhere.SiteList) {
        [menuItems addObject:[PopMenuItem menuItem:item image:nil target:self action:@selector(onSiteSelected:)]];
    }
    
    [PopMenu showMenuInView:self.view
                   fromRect:((UIButton *)sender).frame
                  menuItems:menuItems];
}

- (void) onSiteSelected:(id)sender
{
    PopMenuItem *item = (PopMenuItem *)sender;
    NSArray *sites = [item.title componentsSeparatedByString:@"-"];
    
    SiteDeptSearchWhere *searchWhere = [globalApp getValue:CUR_SITE_DEPT_WHERE];
    searchWhere.CurSiteNo = [sites objectAtIndex:0];
    
    [self loadReportsByFuncNo:nil];
}

-(void)loadReportsByFuncNo:(NSString *)funcNo
{
    [super loadReportsByFuncNo:funcNo];

    NSString *loginUserCode= [globalApp getValue:CUR_LOGIN_USER_NO];
    
    NSMutableString *strBuf = [[NSMutableString alloc] initWithCapacity:10];
    [strBuf appendString: @"SiteNo="];
    [strBuf appendString: siteWhere.CurSiteNo];
    
    //NSString *where= @"SiteNo=1019,Dept=1019-全店";
    NSString *where= [NSString stringWithString:strBuf];
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:loginUserCode, [self getCurFuncNo], @"", @"", @"1", where, AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, FUNC_MENU_ID, CUR_PAGE_NO, PER_PAGE_SIZE, IS_HAS_WHERE, SEARCH_WHERE, AUTH_KEY, nil];
    
    XMLHandleHelper* xmlHelper = [XMLHandleHelper sharedInstance];
    
    SitePerfmS107WebService * service = [SitePerfmS107WebService sharedInstance];
    CommReportsRtnVO* rtnVO;
    @try {
        rtnVO = [service exec: [xmlHelper createParamXmlStr:valArr colName:colNameArr]];
    } @catch (NSException *exp) {
        [self displayHintInfo:@"请检查您的网络是否正常！"];
        return;
    }
    [self makeReportsHtml:rtnVO];
}

@end

