//
//  MOAControllerViewController.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-15.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BasePortraitController.h"

@interface BaseEmbedController : BasePortraitController{
    UIWebView *webView ;
}

-(NSString *) getNaviTitle;
-(NSString *) getEmbedUrl;

@end
