//
//  MOAControllerViewController.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-15.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseEmbedController.h"
#import "HyperlinksButton.h"

@interface BaseEmbedController ()

@end

@implementation BaseEmbedController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showNavigationBar: [self getNaviTitle]];
    
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,50,mainSize.width,mainSize.height-50)];
    [webView setScalesPageToFit:YES];
    
    NSURL *url = [[NSURL alloc] initWithString: [self getEmbedUrl]];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:webView];
}

- (UINavigationItem *)showNavigationBar:(NSString *) title
{
    [self.navigationController setNavigationBarHidden:YES];
    
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    
    CGFloat width = mainSize.width;
    
    //创建一个导航栏
    curNaviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
    [curNaviBar setBackgroundImage:[UIImage imageNamed:@"android_title_bg.9"] forBarMetrics:UIBarMetricsDefault];
    
    [curNaviBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIColor whiteColor], UITextAttributeTextColor,
                                           nil]];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:title];
    
    
    UIImage *launcherImage=[UIImage imageNamed:@"btn_title_back"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:launcherImage forState:UIControlStateNormal];
    [backBtn setFrame:CGRectMake(0, 0, 60, 38)];
    [backBtn addTarget:self action:@selector(onBackBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    HyperlinksButton *prevBtn = [HyperlinksButton hyperlinksButton];
    [prevBtn setTitle:@"上一页" forState:UIControlStateNormal];
    [prevBtn setFrame:CGRectMake(0, 0, 70, 38)];
    [prevBtn addTarget:self action:@selector(onPrevBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *prevBarBtn = [[UIBarButtonItem alloc] initWithCustomView:prevBtn];
    
    navigationItem.leftBarButtonItem = backBarBtn;
    navigationItem.rightBarButtonItem = prevBarBtn;
    
    //把导航栏集合添加入导航栏中，设置动画关闭
    [curNaviBar pushNavigationItem:navigationItem animated:NO];
    
    //把导航栏添加到视图中
    [self.view addSubview:curNaviBar];
    
    return navigationItem;
}

- (void)onPrevBtnClick: (id) sender
{
    [webView goBack];
}

-(NSString *) getNaviTitle {
    return @"";
}

-(NSString *) getEmbedUrl {
    return @"";
}

-(void)autoResizeView{
    [super autoResizeView];
    
    [webView setFrame:CGRectMake(0, 50, [self getScreenWidth], [self getScreenHeight]-50)];
}

@end
