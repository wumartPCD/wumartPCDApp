//
//  CheckVersionWebService.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-20.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseWebService.h"
#import "AppVersionRtnVO.h"

@interface CheckVersionWebService : BaseWebService

+ (CheckVersionWebService *) sharedInstance;

- (AppVersionRtnVO *) exec:(NSString *)xmlStr;

@end
