//
//  RTSaleViewController.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "RTSaleReportsController.h"
#import "PopMenu.h"
#import "RTSaleReportsWebService.h"
#import "XMLHandleHelper.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "GlobalApp.h"
#import "XWAlterview.h"

@implementation RTSaleReportsController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self isKeyMerch]) {
        [self fetchKeyMerchList:@"0"];
    }else{
        [self loadReportsByFuncNo:nil];
    }
}

-(BOOL)isSearchBtnShow{
    return false;
}

-(void)loadReportsByFuncNo:(NSString *)funcNo
{
    [super loadReportsByFuncNo:funcNo];
    
    NSString *loginUserCode= [globalApp getValue:CUR_LOGIN_USER_NO];
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:loginUserCode, [self getCurFuncNo], @"", @"", @"0", @"", AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, FUNC_MENU_ID, CUR_PAGE_NO, PER_PAGE_SIZE, IS_HAS_WHERE, SEARCH_WHERE, AUTH_KEY, nil];
    
    XMLHandleHelper* xmlHelper = [XMLHandleHelper sharedInstance];
    
    RTSaleReportsWebService * service = [RTSaleReportsWebService sharedInstance];
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

