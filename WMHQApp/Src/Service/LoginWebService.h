//
//  LoginWebService.h
//  WMHQApp
//
//  Created by self on 14-7-29.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseWebService.h"
#import "LoginUserRtnVO.h"

@interface LoginWebService : BaseWebService

+ (LoginWebService *) sharedInstance;

- (LoginUserRtnVO *) exec: (NSString *)xmlStr;

@end
