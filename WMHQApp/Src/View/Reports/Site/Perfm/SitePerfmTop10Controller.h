//
//  BreakfastViewController.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseSitePerfmController.h"
#import "PopoverView.h"

@interface SitePerfmTop10Controller : BaseSitePerfmController{
}

-(void)loadReportsByFuncNo:(NSString *)funcNo;
- (void) onSearchBtnClick:(id)sender;

@end
