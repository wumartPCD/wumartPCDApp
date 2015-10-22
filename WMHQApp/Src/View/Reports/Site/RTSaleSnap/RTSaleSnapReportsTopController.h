
#import <UIKit/UIKit.h>
#import "BasePortraitController.h"
#import "BaseSlideViewController.h"
#import "RTSaleSnapSlideMenuController.h"
#import "RTSaleSnapReportsController.h"
#import "RTKeyMerchSnapController.h"
#import "GlobalApp.h"

@interface RTSaleSnapReportsTopController : BaseSlideViewController {
    RTSaleSnapSlideMenuController *slideMenuController;
    
    RTSaleSnapReportsController *rtSaleController;
    RTKeyMerchSnapController *keyMerchController;
    GlobalApp *globalApp;
}

@end
