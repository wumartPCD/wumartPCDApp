
#import "BasePortraitController.h"
#import "CommConst.h"
#import "GlobalApp.h"

@implementation BasePortraitController

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIDeviceOrientationLandscapeLeft | UIDeviceOrientationPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if ([self isPAD]) {
        return [super preferredInterfaceOrientationForPresentation];
    }else{
        return UIInterfaceOrientationPortrait;
    }
}

-(BOOL) needAutoResizeView
{
    return TRUE;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationItem setHidesBackButton:YES];
    
    //隐藏navigationController
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    if ([self needAutoResizeView]) {
        [self autoResizeView];
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    [self autoResizeView];
}

@end
