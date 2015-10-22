//
//  GlobalApp.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-11.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "GlobalApp.h"
#import "AppDelegate.h"

@implementation GlobalApp

static GlobalApp *sharedGlobalApp = nil;

+ (GlobalApp *) sharedInstance {
    if (sharedGlobalApp == nil) {
        sharedGlobalApp = [[GlobalApp alloc] init];
    }
    
    return sharedGlobalApp;
}

- (void) putValue:(NSString *)key value:(id)value{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.globleDict setValue:value forKey:key];
}

- (id) getValue:(NSString *)key{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return [appDelegate.globleDict objectForKey:key];
}

@end
