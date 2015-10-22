//
//  FetchPswdWebService.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-27.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseWebService.h"
#import "LoginPswdRtnVO.h"

@interface FetchPswdWebService : BaseWebService

+ (FetchPswdWebService *) sharedInstance;

- (LoginPswdRtnVO *) exec: (NSString *)xmlStr;

@end
