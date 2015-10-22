//
//  BreakfastViewController.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "SitePerfmS101Controller.h"
#import "PopMenu.h"
#import "SitePerfmS101WebService.h"
#import "XMLHandleHelper.h"
#import "CommReportsRtnVO.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "GlobalApp.h"
#import "XWAlterview.h"
#import "SiteDeptSearchWhere.h"

@implementation SitePerfmS101Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize popViewSize=CGSizeMake(300,200);
    
    int sWidth=[self getScreenWidth];
    int sHeight=[self getScreenHeight];
    if (sWidth<sHeight) {
        sWidth=[self getScreenHeight];
        sHeight=[self getScreenWidth];
    }
    
    float x = (sWidth-popViewSize.width)/2;
    float y = (sHeight-popViewSize.height)/2;
    
    searchView=[SitePerfmSearchView initView:CGRectMake(x, y, 300, 200) superFrame:CGRectMake(0, 0, sWidth, sHeight)];
    searchView.hidden=true;
    
    popSearchView=[[PopoverView alloc] initWithFrame:popViewSize superView:self.view subView:searchView];
    
    searchView.popView=popSearchView;
    [self.view addSubview:searchView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [searchView setDataType:DATA_TYPE_TREE];
    
    [searchView resetCombobox];
}

- (void) onSearchBtnClick:(id)sender
{
    [searchView refreshWhere];
    
    [popSearchView show];
}

-(void)loadReportsByFuncNo:(NSString *)funcNo
{
    [super loadReportsByFuncNo:funcNo];
    
    SiteDeptSearchWhere *searchWhere = [searchView getSearchWhere];
    NSString *loginUserCode= [globalApp getValue:CUR_LOGIN_USER_NO];
    
    NSMutableString *strBuf = [[NSMutableString alloc] initWithCapacity:10];
    [strBuf appendString: @"SiteNo="];
    [strBuf appendString: searchWhere.CurSiteNo];
    [strBuf appendString: @","];
    [strBuf appendString: @"Dept="];
    [strBuf appendString: [searchWhere getSiteDeptForSearch]];
    
    //NSString *where= @"SiteNo=1019,Dept=1019-全店";
    NSString *where= [NSString stringWithString:strBuf];
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:loginUserCode, [self getCurFuncNo], @"", @"", @"1", where, AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, FUNC_MENU_ID, CUR_PAGE_NO, PER_PAGE_SIZE, IS_HAS_WHERE, SEARCH_WHERE, AUTH_KEY, nil];
    
    XMLHandleHelper* xmlHelper = [XMLHandleHelper sharedInstance];
    
    SitePerfmS101WebService * service = [SitePerfmS101WebService sharedInstance];
    CommReportsRtnVO* rtnVO;
    @try {
        rtnVO = [service exec: [xmlHelper createParamXmlStr:valArr colName:colNameArr]];
    } @catch (NSException *exp) {
        [self displayHintInfo:@"请检查您的网络是否正常！"];
        return;
    }
    if([rtnVO ResultFlag] == 0){
        [sysDao updateKeyValues:[self getSiteDeptKey] val:[searchWhere getSiteDeptForSearch]];
    }
    [self makeReportsHtml:rtnVO];
}

@end

