//
//  ReportsWebService.h
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "BaseWebService.h"

@interface HQPromoH111WebService : BaseWebService

+ (HQPromoH111WebService *) sharedInstance;

- (CommReportsRtnVO *) exec:(NSString *)xmlStr;
    
@end
