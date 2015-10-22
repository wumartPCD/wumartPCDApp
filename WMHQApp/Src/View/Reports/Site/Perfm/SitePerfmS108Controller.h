//
//  BreakfastViewController.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseSitePerfmController.h"
#import "PopoverView.h"
#import "S108SearchView.h"

@interface SitePerfmS108Controller : BaseSitePerfmController {
    S108SearchView *s108View;
}

-(void)loadReportsByFuncNo:(NSString *)funcNo;

@end
