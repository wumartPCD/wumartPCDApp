//
//  WMUINaviCtrler.m
//  WMHQApp
//
//  Created by laisl_mac on 15/9/26.
//  Copyright © 2015年 wumart. All rights reserved.
//

#import "WMUINaviCtrler.h"

@interface WMUINaviCtrler ()

@end

@implementation WMUINaviCtrler

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    if ([self.topViewController respondsToSelector:@selector(shouldAutorotate)]) {
        return [self.topViewController shouldAutorotate];
    }
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([self.topViewController respondsToSelector:@selector(supportedInterfaceOrientations)]) {
        return [self.topViewController supportedInterfaceOrientations];
    }
    return [super supportedInterfaceOrientations];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if ([self.topViewController respondsToSelector:@selector(preferredInterfaceOrientationForPresentation)]) {
        return [self.topViewController preferredInterfaceOrientationForPresentation];
    }
    return [super preferredInterfaceOrientationForPresentation];
}

@end
