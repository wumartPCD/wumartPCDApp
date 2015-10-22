
#import "SitePerfmMenuController.h"
#import "SitePerfmReportsTopController.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "SiteDeptSearchWhere.h"
#import "XMLHandleHelper.h"

@implementation SitePerfmMenuController

- (id) init {
    self = [super init];
    if (self) {
        baseImageMap = [NSDictionary dictionaryWithObjectsAndKeys:
                        @"reports_menu_icon.png", REPORTS_MENU_100,
                        @"reports_menu_icon.png", REPORTS_MENU_200,
                        nil];
        mainCtrl = [[SitePerfmReportsTopController alloc] init];
    }
    return self;
}

-(NSString *) getCurAppID{
    return APP_ID_SITE_PERFM;
}
-(NSString *) getCurMandtKey{
    return CUR_SITE_PERFM_MANDT;
}
-(NSString *) getNaviTitle{
    return @"门店业绩";
}
-(NSString *) getLogoImgName{
    return @"site_perfm_menu_image";
}

@end
