//
//  BreakfastViewController.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "SitePerfmS108Controller.h"
#import "PopMenu.h"
#import "SitePerfmS108WebService.h"
#import "XMLHandleHelper.h"
#import "CommReportsRtnVO.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "GlobalApp.h"
#import "XWAlterview.h"

@implementation SitePerfmS108Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize popViewSize=CGSizeMake(300,250);
    
    int sWidth=[self getScreenWidth];
    int sHeight=[self getScreenHeight];
    if (sWidth<sHeight) {
        sWidth=[self getScreenHeight];
        sHeight=[self getScreenWidth];
    }
    
    float x = (sWidth-popViewSize.width)/2;
    float y = (sHeight-popViewSize.height)/2;
    
    s108View=[S108SearchView initView:CGRectMake(x, y, 300, 250) superFrame:CGRectMake(0, 0, sWidth, sHeight)];
    s108View.hidden=true;
    [s108View initData:sysDao];
    
    popSearchView=[[PopoverView alloc] initWithFrame:popViewSize superView:self.view subView:s108View];
    
    s108View.popView=popSearchView;
    [self.view addSubview:s108View];
}

- (void) onSearchBtnClick:(id)sender
{
    [s108View refreshWhere];
    
    [popSearchView show];
}

-(void)loadReportsByFuncNo:(NSString *)funcNo
{
    [super loadReportsByFuncNo:funcNo];
    
    NSArray *wheres = [s108View getSearchWhere];
    NSString *loginUserCode= [globalApp getValue:CUR_LOGIN_USER_NO];
    
    NSMutableString *strBuf = [[NSMutableString alloc] initWithCapacity:10];
    [strBuf appendString: @"SiteNo="];
    [strBuf appendString: [wheres objectAtIndex:0]];
    [strBuf appendString: @","];
    [strBuf appendString: [wheres objectAtIndex:1]];
    [strBuf appendString: @","];
    [strBuf appendString: [wheres objectAtIndex:2]];
    
    NSString *where= [NSString stringWithString:strBuf];
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:loginUserCode, [self getCurFuncNo], @"", @"", @"1", where, AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, FUNC_MENU_ID, CUR_PAGE_NO, PER_PAGE_SIZE, IS_HAS_WHERE, SEARCH_WHERE, AUTH_KEY, nil];
    
    XMLHandleHelper* xmlHelper = [XMLHandleHelper sharedInstance];
    
    SitePerfmS108WebService * service = [SitePerfmS108WebService sharedInstance];
    CommReportsRtnVO* rtnVO;
    @try {
        rtnVO = [service exec: [xmlHelper createParamXmlStr:valArr colName:colNameArr]];
    } @catch (NSException *exp) {
        [self displayHintInfo:@"请检查您的网络是否正常！"];
        return;
    }
    if([rtnVO ResultFlag] == 0){
        [s108View saveData:sysDao];
    }
    
    [self makeReportsHtml:rtnVO];
}

@end

