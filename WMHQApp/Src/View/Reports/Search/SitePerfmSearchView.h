
#import <UIKit/UIKit.h>
#import "ComboBoxList.h"
#import "PopoverView.h"
#import "GlobalApp.h"
#import "SiteDeptSearchWhere.h"

@interface SitePerfmSearchView : UIView<ComboBoxListDelegate>
{
    UILabel *siteLabel;
    UILabel *deptLabel;
    
    ComboBoxList *siteComboxList;
    ComboBoxList *deptComboxList;
    
    UIButton *siteComboxBtn;
    UIButton *deptComboxBtn;
    
    UIButton *cancelBtn;
    UIButton *searchBtn;
    
    GlobalApp *globalApp;
    SiteDeptSearchWhere *searchWhere;
}

@property (nonatomic,retain) PopoverView *popView;

+ (id)initView:(CGRect)bounds superFrame:(CGRect)superFrame;

- (void) resetCombobox;
- (void) refreshWhere;

- (SiteDeptSearchWhere *) getSearchWhere;

- (void) setPreSiteDept:(NSString *)siteDept;

- (void) setDataType:(NSString *)dataType;

@end
