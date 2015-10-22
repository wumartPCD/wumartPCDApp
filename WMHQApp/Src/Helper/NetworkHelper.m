//
//  NetworkHelper.m
//  WMHQApp
//
//  Created by laisl_mac on 15-2-15.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "NetworkHelper.h"
#import "SSKeychain.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation NetworkHelper

static NetworkHelper * sharedNetHelper = nil;

+ (NetworkHelper *) sharedInstance {
    if (sharedNetHelper == nil) {
        sharedNetHelper = [[NetworkHelper alloc] init];
    }
    
    return sharedNetHelper;
}

//获取设备UUID
+(NSString *)GetDeviceUUID
{
    NSError *error;
    NSString *uuid = [SSKeychain passwordForService:@"wm.app.WMHQApp" account:@"wm.app" error:&error];
    
    if(uuid == nil || [uuid length] == 0)
    {
        CFStringRef uuidStr = CFUUIDCreateString(NULL, CFUUIDCreate(NULL));
        uuid=[NSString stringWithFormat:@"%@", uuidStr];
        [SSKeychain setPassword:uuid forService:@"wm.app.WMHQApp" account:@"wm.app"];
    }
    
    return uuid;
}

@end
