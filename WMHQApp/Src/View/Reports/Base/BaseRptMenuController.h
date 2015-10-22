
#import <UIKit/UIKit.h>
#import "BasePortraitController.h"
#import "GridMenuView.h"
#import "ComboBoxButton.h"
#import "SysMangDao.h"
#import "GlobalApp.h"

@interface BaseRptMenuController : BasePortraitController<ComboBoxButtonDelegate>
{
    NSMutableArray *areaIDArr;
    NSDictionary *baseImageMap;
    GridMenuView *gridMenuView;
    SysMangDao *sysDao;
    UIViewController *mainCtrl;
    ComboBoxButton *areaBtn;
    GlobalApp *globalApp;
    UIImageView* logoImage;
    NSMutableArray *gridItems;
}

-(NSString *) getCurAppID;
-(NSString *) getCurMandtKey;
-(NSString *) getNaviTitle;
-(NSString *) getLogoImgName;

-(NSString *) getEscapeMenuID;

-(void)closeDropdown;
    
@end
