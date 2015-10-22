
#import <UIKit/UIKit.h>
#import "BasePortraitController.h"
#import "BaseSlideViewController.h"
#import "BreakfastSlideMenuController.h"
#import "BreakfastReportsController.h"
#import "HQPromoH111Controller.h"
#import "GlobalApp.h"

@interface BreakfastReportsTopController : BaseSlideViewController {
    BreakfastSlideMenuController *slideMenuController;
    
    BreakfastReportsController *breakfastController;
    HQPromoH111Controller *h111Controller;
    GlobalApp *globalApp;
}


@end
