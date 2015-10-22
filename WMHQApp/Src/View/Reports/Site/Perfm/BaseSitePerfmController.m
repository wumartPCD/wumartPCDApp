//
//  BreakfastViewController.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseSitePerfmController.h"
#import "PopMenu.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "GlobalApp.h"
#import "XWAlterview.h"
#import "SiteDeptSearchWhere.h"

@implementation BaseSitePerfmController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadReports)
                                                 name:@"BaseSitePerfmController.loadReports"
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *pMenuID = [[GlobalApp sharedInstance] getValue:CUR_SUPER_MENU_ID];
    NSMutableArray *childMenusArr=[sysDao findChildMenus : pMenuID];
    NSString *curMenuID = [[childMenusArr objectAtIndex:0] MenuID];
    [globalApp putValue:CUR_MENU_ID value:curMenuID];
    
    if (searchView!=Nil) {
        [searchView setPreSiteDept: [sysDao getKeyValues:[self getSiteDeptKey]]];
    }
    
    [self loadReportsByFuncNo:curMenuID];
}

-(BOOL)isSearchBtnShow{
    return true;
}

-(void)loadReports
{
    [self loadReportsByFuncNo:Nil];
}

-(NSString *)getSiteDeptKey
{
    NSString *curMenuID=[globalApp getValue:CUR_MENU_ID];
    
    return [CUR_SITE_DEPT stringByAppendingString:curMenuID];
}

@end

