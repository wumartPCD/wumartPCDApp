//
//  BreakfastViewController.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseReportsController.h"
#import "PopMenu.h"
#import "BreakfastReportsWebService.h"
#import "XMLHandleHelper.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "GlobalApp.h"
#import "XWAlterview.h"

@implementation BaseReportsController

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    //return UIInterfaceOrientationMaskAll;
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sysDao=[[SysMangDao alloc] init];
    globalApp=[GlobalApp sharedInstance];
    siteWhere=[globalApp getValue:CUR_SITE_DEPT_WHERE];
    
    escapeMenuIDStr=[MENUID_HQ_PROMO_H111 stringByAppendingString:@"|"];
    escapeMenuIDStr=[escapeMenuIDStr stringByAppendingString:MENUID_KEY_MERCH];
    escapeMenuIDStr=[escapeMenuIDStr stringByAppendingString:@"|"];
    escapeMenuIDStr=[escapeMenuIDStr stringByAppendingString:MENUID_SITE_PERFM_S101];
    escapeMenuIDStr=[escapeMenuIDStr stringByAppendingString:MENUID_SITE_PERFM_S107];
    escapeMenuIDStr=[escapeMenuIDStr stringByAppendingString:MENUID_SITE_PERFM_TOP10];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,mainSize.height,mainSize.width)];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
    
    [self showBtnBarView];
    
}

- (void)onBackBtnClick: (id) sender {
    
    if(isFromPortrait)
    {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    }else
    {
        //状态栏旋转
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
    }
    
    [super onBackBtnClick:sender];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    isFromPortrait=UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication]statusBarOrientation]);
    
    NSString *pMenuID = [[GlobalApp sharedInstance] getValue:CUR_SUPER_MENU_ID];
    NSMutableArray *childMenusArr=[sysDao findChildMenus : pMenuID];
    NSString *curMenuID = [[childMenusArr objectAtIndex:0] MenuID];
    [globalApp putValue:CUR_MENU_ID value:curMenuID];
    
    if ([self isSearchBtnShow]) {
        [self.view addSubview:searchBtn];
    }else{
        [searchBtn removeFromSuperview];
    }
    menusArr = nil;
    
    [self resizeView];
}

- (void) onBtnBarClick:(id)sender
{
    if([sender tag] == FuncBarBack)
    {
        [self onBackBtnClick:sender];
    }else if([sender tag] == FuncBarMenu)
    {
        NSString *evnName=[[GlobalApp sharedInstance] getValue:CUR_SHOW_SLIDE_MENU_VIEW_EVN_NM];
        [[NSNotificationCenter defaultCenter] postNotificationName:evnName object:nil];
    }else if([sender tag] == FuncBarSearch)
    {
        [self onSearchBtnClick:sender];
        
    }else if([sender tag] == RollBarPrev)
    {
        [self rollPage:-1];
    }else if([sender tag] == RollBarRefresh)
    {
        [self loadReportsByFuncNo: [self getCurFuncNo]];
    }else if([sender tag] == RollBarNext)
    {
        [self rollPage:1];
    }
}

//-(BOOL)isSearchBtnShow{
//    return false;
//}

-(void)onSearchBtnClick:(id)sender{
}

- (void) rollPage:(int)param {
    NSString *funcNo;
    if (menusArr == nil) {
        menusArr=[sysDao findMenus:[globalApp getValue:CUR_APP_ID] mandt:[globalApp getValue:CUR_MANDT] level:MENU_LEVEL_CHILD];
    }
    if (param == 0) {
        funcNo = [[menusArr objectAtIndex:param] MenuID];
    } else if (param == -2) {
        funcNo = [[menusArr objectAtIndex:menusArr.count-1] MenuID];
    } else {
        int index = 0;
        for (int i = 0; i < menusArr.count; i++) {
            if ([[[menusArr objectAtIndex:i] MenuID] isEqualToString:[self getCurFuncNo]]) {
                index = i + param;
                break;
            }
        }
        if (index < 0) {
            [self displayHintInfo: @"前面没有了！"];
            return;
        } else if (index >= menusArr.count) {
            [self displayHintInfo: @"后面没有了！"];
            return;
        } else {
            funcNo = [[menusArr objectAtIndex:index] MenuID];
        }
    }
    
    [self loadReportsByFuncNo:funcNo];
}

- (void) onRtnMainPageClick:(id)sender
{
    //状态栏旋转
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL) onReportsPageRoll :(NSString *)funcNo
{
    NSString *pMenuID = [sysDao getPMenuID:funcNo];
    
    NSString *curPMenuID= [globalApp getValue:CUR_SUPER_MENU_ID];
    
    BOOL canRoll = true;
    if ([self isContainString:escapeMenuIDStr subStr:curPMenuID]
        && ![pMenuID isEqualToString:curPMenuID]) {
        canRoll=false;
    }else{
        NSString * oldPMenuID=[sysDao getPMenuID:[globalApp getValue:CUR_MENU_ID]];
        if ([self isContainString:escapeMenuIDStr subStr:pMenuID]
            && ![pMenuID isEqualToString:oldPMenuID]) {
            canRoll=false;
        }
    }
    if(canRoll){
        [globalApp putValue:CUR_SUPER_MENU_ID value:pMenuID];
        
        NSString *evnName=[[GlobalApp sharedInstance] getValue:CUR_SHOW_SLIDE_MENU_EVN_NM];
        [[NSNotificationCenter defaultCenter] postNotificationName:evnName object:nil];
    }
    return canRoll;
}

-(void)makeReportsHtml :(CommReportsRtnVO *)rtnVO {
    if([rtnVO ResultFlag] == 0){
        if(rtnVO.ReportHint != nil && [rtnVO.ReportHint length] >0){
            [self displayHintInfo:rtnVO.ReportHint];
        }
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        
        NSString *funcNo = [globalApp getValue:CUR_MENU_ID];
        NSMutableString *strBuf = [[NSMutableString alloc] initWithCapacity:10];
        [strBuf setString: @"<html>"];
        [strBuf appendString: @"<head>"];
        if([funcNo isEqualToString:@"601"]){
            [strBuf appendString: @"<meta name='viewport' content='device-width,initial-scale=0.4,minimum-scale=0.1'/>"];
        }else{
            [strBuf appendString: @"<meta name='viewport' content='device-width,initial-scale=0.6,minimum-scale=0.1'/>"];
        }
        [strBuf appendString: @"<link rel='stylesheet' href='ReportsTable.css'/>"];
        [strBuf appendString: @"</head><body>"];
        [strBuf appendString: @"<div class='text_center'>"];
        [strBuf appendString: @"<h1 class='report_title'>"];
        [strBuf appendString: rtnVO.ReportTitle];
        [strBuf appendString: @"</h1>"];
        [strBuf appendString: @"</div>"];
        [strBuf appendString: rtnVO.ReportHtml];
        [strBuf appendString: @"</body>"];
        [strBuf appendString: @"</html>"];
        
        NSString *html =[NSString stringWithString:strBuf];
        html = [html stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        html = [html stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        html = [html stringByReplacingOccurrencesOfString:@"&quot;" withString:@"'"];
        
        [webView loadHTMLString:html baseURL:baseURL];
    }else{
        [self displayHintInfo:rtnVO.ResultMesg];
    }
}

-(void)loadReportsByFuncNo:(NSString *)funcNo
{
    if(funcNo != Nil) {
        if(![self onReportsPageRoll:funcNo]){
            [self displayHintInfo:@"过不去了！"];
            return;
        }
        [globalApp putValue:CUR_MENU_ID value:funcNo];
    }
}

-(NSString *)getCurFuncNo {
    return [globalApp getValue:CUR_MENU_ID];
}

-(void)showBtnBarView {
    
    CGFloat mainWidth=[self getScreenHeight];
    CGFloat topDiff=3;
    CGFloat leftDiff=5;
    CGFloat width=55;
    CGFloat height=38;
    CGFloat rightDiff=mainWidth-width-4;
    
    UIImage *backBtnImg=[UIImage imageNamed:@"goback_icon"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:backBtnImg forState:UIControlStateNormal];
    [backBtn setFrame:CGRectMake(leftDiff, topDiff, width, height)];
    [backBtn addTarget:self action:@selector(onBtnBarClick:)forControlEvents:UIControlEventTouchUpInside];
    backBtn.tag=FuncBarBack;
    [self.view addSubview:backBtn];
    
    leftDiff=leftDiff+width+5;
    
    UIImage *menuBtnImg=[UIImage imageNamed:@"left_menu_icon"];
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setBackgroundImage:menuBtnImg forState:UIControlStateNormal];
    [menuBtn setFrame:CGRectMake(leftDiff, topDiff, width, height)];
    [menuBtn addTarget:self action:@selector(onBtnBarClick:)forControlEvents:UIControlEventTouchUpInside];
    menuBtn.tag=FuncBarMenu;
    [self.view addSubview:menuBtn];
    
    leftDiff=leftDiff+width+5;
    
    UIImage *searchBtnImg=[UIImage imageNamed:@"search_dialog_icon"];
    searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:searchBtnImg forState:UIControlStateNormal];
    [searchBtn setFrame:CGRectMake(leftDiff, topDiff, width, height)];
    [searchBtn addTarget:self action:@selector(onBtnBarClick:)forControlEvents:UIControlEventTouchUpInside];
    searchBtn.tag=FuncBarSearch;
    
    UIImage *nextBtnImg=[UIImage imageNamed:@"next_page_icon"];
    nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setBackgroundImage:nextBtnImg forState:UIControlStateNormal];
    [nextBtn setFrame:CGRectMake(rightDiff, topDiff, width, height)];
    [nextBtn addTarget:self action:@selector(onBtnBarClick:)forControlEvents:UIControlEventTouchUpInside];
    nextBtn.tag=RollBarNext;
    [self.view addSubview:nextBtn];
    
    rightDiff=rightDiff-width-5;
    
    UIImage *refreshBtnImg=[UIImage imageNamed:@"refresh_page_icon"];
    refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshBtn setBackgroundImage:refreshBtnImg forState:UIControlStateNormal];
    [refreshBtn setFrame:CGRectMake(rightDiff, topDiff, width, height)];
    [refreshBtn addTarget:self action:@selector(onBtnBarClick:)forControlEvents:UIControlEventTouchUpInside];
    refreshBtn.tag=RollBarRefresh;
    [self.view addSubview:refreshBtn];
    
    rightDiff=rightDiff-width-5;
    
    UIImage *prevBtnImg=[UIImage imageNamed:@"prev_page_icon"];
    prevBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [prevBtn setBackgroundImage:prevBtnImg forState:UIControlStateNormal];
    [prevBtn setFrame:CGRectMake(rightDiff, topDiff, width, height)];
    [prevBtn addTarget:self action:@selector(onBtnBarClick:)forControlEvents:UIControlEventTouchUpInside];
    prevBtn.tag=RollBarPrev;
    [self.view addSubview:prevBtn];
}

-(void)resizeView{
    
    int sWidth=[self getScreenWidth];
    int sHeight=[self getScreenHeight];
    if ([self isPortrait]) {
        sWidth=[self getScreenHeight];
        sHeight=[self getScreenHeight];
    }
    
    [webView setFrame:CGRectMake(0, 0, sWidth, sHeight)];
    
    CGFloat mainWidth=sWidth;
    CGFloat topDiff=3;
    CGFloat width=55;
    CGFloat height=38;
    CGFloat rightDiff=mainWidth-width-4;
    
    [nextBtn setFrame:CGRectMake(rightDiff, topDiff, width, height)];
    
    rightDiff=rightDiff-width-5;
    
    [refreshBtn setFrame:CGRectMake(rightDiff, topDiff, width, height)];
    
    rightDiff=rightDiff-width-5;
    
    [prevBtn setFrame:CGRectMake(rightDiff, topDiff, width, height)];
}

@end

