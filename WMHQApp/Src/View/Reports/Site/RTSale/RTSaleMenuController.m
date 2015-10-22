
#import "RTSaleMenuController.h"
#import "RTSaleReportsTopController.h"
#import "CommConst.h"
#import "AppAreaVO.h"
#import "MenuConst.h"
#import "GlobalApp.h"

@implementation RTSaleMenuController

- (id) init {
    self = [super init];
    if (self) {
        baseImageMap = [NSDictionary dictionaryWithObjectsAndKeys:
                        @"reports_menu_icon.png", REPORTS_MENU_100,
                        @"reports_menu_icon.png", REPORTS_MENU_200,
                        @"reports_menu_icon.png", REPORTS_MENU_300,
                        @"reports_menu_icon.png", REPORTS_MENU_400,
                        @"reports_menu_icon.png", REPORTS_MENU_500,
                        nil];
        mainCtrl = [[RTSaleReportsTopController alloc] init];
    }
    return self;
}

-(NSString *) getCurAppID{
    return APP_ID_RTSALE;
}
-(NSString *) getCurMandtKey{
    return CUR_RTSALE_MANDT;
}
-(NSString *) getNaviTitle{
    return @"实时业绩";
}
-(NSString *) getLogoImgName{
    return @"rtsale_menu_image";
}

@end
