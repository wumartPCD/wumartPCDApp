
#import <UIKit/UIKit.h>
#import "ComboBoxList.h"
#import "PopoverView.h"
#import "SysMangDao.h"
#import "GlobalApp.h"
#import "SiteDeptSearchWhere.h"

@interface S108SearchView : UIView<UIGestureRecognizerDelegate,ComboBoxListDelegate>
{
    UILabel *siteALabel;
    UILabel *siteBLabel;
    UILabel *siteCLabel;
    
    UITextField *siteAText;
    UITextField *siteCText;
    
    ComboBoxList *siteBComboxList;
    UIButton *siteBComboxBtn;
    
    GlobalApp *globalApp;
    
    SiteDeptSearchWhere *searchWhere;
    
    NSString *curSiteB;
    
    UIButton *cancelBtn;
    UIButton *searchBtn;
}

@property (nonatomic,retain) PopoverView *popView;

+ (id)initView:(CGRect)bounds superFrame:(CGRect)superFrame;
- (NSArray*)getSearchWhere;
- (void) initData:(SysMangDao *)sysDao;
- (void) saveData:(SysMangDao *)sysDao;

- (void) refreshWhere;

@end
