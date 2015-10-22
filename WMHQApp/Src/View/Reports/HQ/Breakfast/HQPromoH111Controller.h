//
//  HQPromoH111Controller.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseReportsController.h"
#import "PopoverView.h"

@interface HQPromoH111Controller : BaseReportsController {
    NSMutableArray *aktnrList;
    NSString *curAktnr;
}

-(void)loadReportsByFuncNo:(NSString *)funcNo;
-(BOOL)isSearchBtnShow;

@end
