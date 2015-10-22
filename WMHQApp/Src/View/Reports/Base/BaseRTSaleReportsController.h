//
//  RTSaleViewController.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-14.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseReportsController.h"
#import "KeyMerchSearchWhere.h"

@interface BaseRTSaleReportsController : BaseReportsController {
    KeyMerchSearchWhere *merchWhere;
}

-(BOOL)isKeyMerch;
-(BOOL)isKeyMerchSite;
-(NSString *)fetchKeyMerchList:(NSString *)isSnap;
    
@end
