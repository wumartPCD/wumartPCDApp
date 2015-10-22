
#import <UIKit/UIKit.h>
#import "BasePortraitController.h"
#import "GridMenuView.h"
#import "SysMangDao.h"

@interface SitePerfmSlideMenuController : BasePortraitController
{
    GridMenuView *board;
    SysMangDao *sysDao;
}

@property(strong, nonatomic) UIViewController *mainCtrl;

@end
