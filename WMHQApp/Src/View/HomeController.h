
#import <UIKit/UIKit.h>
#import "BasePortraitController.h"
#import "SysMangDao.h"
#import "GridMenuView.h"

@interface HomeController : BasePortraitController{
    SysMangDao *sysDao;
    UIImageView *logoImage;
    UIImageView *bottomImage;
    GridMenuView *gridMenuView;
}

@end
