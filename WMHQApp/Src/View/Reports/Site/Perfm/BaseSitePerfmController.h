//
//  BreakfastViewController.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseReportsController.h"
#import "SitePerfmSearchView.h"
#import "PopoverView.h"

@interface BaseSitePerfmController : BaseReportsController{
    SitePerfmSearchView *searchView;
    PopoverView *popSearchView;
    NSString *curSiteNo;
}

- (void) onSearchBtnClick:(id)sender;
-(NSString *)getSiteDeptKey;

@end
