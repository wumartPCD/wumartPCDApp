
#import "BaseLandscapeController.h"

@implementation BaseLandscapeController

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication]statusBarOrientation]))
    {
        [self.view setTransform:CGAffineTransformIdentity];
    }else{
        [self.view setTransform:CGAffineTransformMakeRotation(-M_PI/2)];
    }
}

@end
