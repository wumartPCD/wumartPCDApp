
#import <UIKit/UIKit.h>
#import "BasePortraitController.h"
#import "GridMenuView.h"
#import "ComboBoxButton.h"
#import "SysMangDao.h"
#import "GlobalApp.h"

@interface BasePCDMenuController : BasePortraitController<ComboBoxButtonDelegate>
{
    NSMutableArray *areaIDArr;
    NSDictionary *baseImageMap;
    GridMenuView *gridMenuView;
    SysMangDao *sysDao;
    
    ComboBoxButton *areaBtn;
    GlobalApp *globalApp;
    UIImageView* logoImage;
    NSMutableArray *gridItems;
    
    UIViewController *inputNaviCtrl;
    UIViewController *searchNaviCtrl;
}

-(NSString *) getCurAppID;
-(NSString *) getCurMandtKey;
-(NSString *) getNaviTitle;
-(NSString *) getLogoImgName;

-(NSString *) getEscapeMenuID;

-(void)closeDropdown;
    
@end
