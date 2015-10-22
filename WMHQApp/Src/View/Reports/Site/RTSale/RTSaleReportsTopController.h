
#import <UIKit/UIKit.h>
#import "BasePortraitController.h"
#import "BaseSlideViewController.h"
#import "RTSaleSlideMenuController.h"
#import "RTSaleReportsController.h"
#import "RTKeyMerchController.h"
#import "GlobalApp.h"

@interface RTSaleReportsTopController : BaseSlideViewController {
    RTSaleSlideMenuController *slideMenuController;
    
    RTSaleReportsController *rtSaleController;
    RTKeyMerchController *keyMerchController;
    GlobalApp *globalApp;
}

@end
