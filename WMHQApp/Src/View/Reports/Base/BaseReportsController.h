//
//  BreakfastViewController.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseViewController.h"
#import "SysMangDao.h"
#import "CommReportsRtnVO.h"
#import "GlobalApp.h"
#import "SiteDeptSearchWhere.h"

typedef enum {
    FuncBarBack,
    FuncBarMenu,
    FuncBarSearch,

    RollBarPrev,
    RollBarRefresh,
    RollBarNext,
} BarBtnEnum;

@interface BaseReportsController : BaseViewController <UIGestureRecognizerDelegate>{
    UIWebView *webView ;
    SysMangDao *sysDao;
    GlobalApp *globalApp;
    SiteDeptSearchWhere *siteWhere;
    
    UIButton *searchBtn;
    
    NSMutableArray *menusArr;
    NSMutableArray *menus;
    NSString *escapeMenuIDStr;
    
    BOOL isFromPortrait;
    
    UIButton *nextBtn;
    UIButton *refreshBtn;
    UIButton *prevBtn;
}

-(void)loadReportsByFuncNo:(NSString *)funcNo;
-(BOOL)onReportsPageRoll :(NSString *)funcNo;
-(void)makeReportsHtml :(CommReportsRtnVO *)rtnVO;
-(NSString *)getCurFuncNo;
-(BOOL)isSearchBtnShow;
-(void)onSearchBtnClick:(id)sender;

@end
