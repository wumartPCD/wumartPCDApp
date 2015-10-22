
#import <UIKit/UIKit.h>
#import "BaseSlideViewController.h"
#import "SitePerfmS101Controller.h"
#import "SitePerfmS107Controller.h"
#import "SitePerfmTop10Controller.h"
#import "SitePerfmS108Controller.h"
#import "SitePerfmSlideMenuController.h"
#import "GlobalApp.h"

@interface SitePerfmReportsTopController : BaseSlideViewController {
    
    SitePerfmSlideMenuController *slideMenuController;
    
    SitePerfmS101Controller *s101Controller;
    SitePerfmS107Controller *s107Controller;
    SitePerfmTop10Controller *top10Controller;
    SitePerfmS108Controller *s108Controller;
    GlobalApp *globalApp;
}

@end
