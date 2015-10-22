//
//  HQPromoH111Controller.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "HQPromoH111Controller.h"
#import "PopMenu.h"
#import "HQPromoH111WebService.h"
#import "AktnrListWebService.h"
#import "XMLHandleHelper.h"
#import "CommReportsRtnVO.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "GlobalApp.h"
#import "XWAlterview.h"

@implementation HQPromoH111Controller

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadReportsByDefault];
}

-(BOOL)isSearchBtnShow{
    return true;
}

- (void) onSearchBtnClick:(id)sender
{
    NSMutableArray *menuItems = [[NSMutableArray alloc] initWithCapacity:2];
    for (NSString *item in aktnrList) {
        [menuItems addObject:[PopMenuItem menuItem:item image:nil target:self action:@selector(onSiteSelected:)]];
    }
    [PopMenu showMenuInView:self.view
                   fromRect:((UIButton *)sender).frame
                  menuItems:menuItems];
}

- (void) onSiteSelected:(id)sender
{
    PopMenuItem *item = (PopMenuItem *)sender;
    
    curAktnr = item.title;
    
    [self loadReportsByFuncNo:[self getCurFuncNo]];
}

-(void)loadReportsByDefault
{
    NSString *loginUserCode= [globalApp getValue:CUR_LOGIN_USER_NO];
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:loginUserCode, [self getCurFuncNo], AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, FUNC_MENU_ID, AUTH_KEY, nil];
    
    XMLHandleHelper* xmlHelper = [XMLHandleHelper sharedInstance];
    
    AktnrListWebService * service = [AktnrListWebService sharedInstance];
    CommMasterAndReportsRtnVO* rtnVO;
    @try {
        rtnVO = [service exec: [xmlHelper createParamXmlStr:valArr colName:colNameArr]];
        
        if([rtnVO ResultFlag] == 0){
            NSArray *dataArr = [rtnVO.Data componentsSeparatedByString:@","];
            aktnrList= [[NSMutableArray alloc] initWithCapacity:dataArr.count];
            for (id item in dataArr) {
                [aktnrList addObject:item];
            }
            [self makeReportsHtml:rtnVO];
        }else{
            [self displayHintInfo:rtnVO.ResultMesg];
        }
    } @catch (NSException *exp) {
        [self displayHintInfo:@"请检查您的网络是否正常！"];
    }
}

-(void)loadReportsByFuncNo:(NSString *)funcNo
{
    [super loadReportsByFuncNo:funcNo];
    
    NSString *loginUserCode= [globalApp getValue:CUR_LOGIN_USER_NO];
    
    NSMutableString *strBuf = [[NSMutableString alloc] initWithCapacity:2];
    [strBuf appendString: @"Aktnr="];
    [strBuf appendString: curAktnr];
    
    NSString *where= [NSString stringWithString:strBuf];
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:loginUserCode, [self getCurFuncNo], @"", @"", @"1", where, AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, FUNC_MENU_ID, CUR_PAGE_NO, PER_PAGE_SIZE, IS_HAS_WHERE, SEARCH_WHERE, AUTH_KEY, nil];
    
    XMLHandleHelper* xmlHelper = [XMLHandleHelper sharedInstance];
    
    HQPromoH111WebService * service = [HQPromoH111WebService sharedInstance];
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

