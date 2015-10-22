//
//  NetworkHelper.h
//  WMHQApp
//
//  Created by laisl_mac on 15-2-15.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkHelper : NSObject

+ (NetworkHelper *) sharedInstance;

//获取设备UUID
+(NSString *)GetDeviceUUID;

@end
