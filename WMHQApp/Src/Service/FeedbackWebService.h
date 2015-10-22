//
//  FeedbackWebService.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-16.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseWebService.h"
#import "BaseRtnVO.h"

@interface FeedbackWebService : BaseWebService

+ (FeedbackWebService *) sharedInstance;

- (BaseRtnVO *) exec: (NSString *)xmlStr;

@end
