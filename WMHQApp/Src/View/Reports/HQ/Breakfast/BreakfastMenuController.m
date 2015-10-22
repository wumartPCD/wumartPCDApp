
#import "BreakfastMenuController.h"
#import "BreakfastReportsTopController.h"
#import "CommConst.h"
#import "AppAreaVO.h"
#import "MenuConst.h"
#import "GlobalApp.h"

@implementation BreakfastMenuController

- (id) init {
    self = [super init];
    if (self) {
        baseImageMap = [NSDictionary dictionaryWithObjectsAndKeys:
                        @"breakfast_1_icon.png", REPORTS_MENU_100,
                        @"breakfast_2_icon.png", REPORTS_MENU_200,
                        @"breakfast_3_icon.png", REPORTS_MENU_300,
                        @"breakfast_4_icon.png", REPORTS_MENU_400,
                        @"breakfast_5_icon.png", REPORTS_MENU_500,
                        @"breakfast_6_icon.png", REPORTS_MENU_600,
                        @"breakfast_7_icon.png", REPORTS_MENU_700,
                        @"breakfast_8_icon.png", REPORTS_MENU_800,
                        nil];
        mainCtrl = [[BreakfastReportsTopController alloc] init];
    }
    return self;
}

-(NSString *) getCurAppID{
    return APP_ID_BREAKFAST;
}
-(NSString *) getCurMandtKey{
    return CUR_BREAKFAST_MANDT;
}
-(NSString *) getNaviTitle{
    return @"业绩报表";
}
-(NSString *) getLogoImgName{
    return @"breakfast_menu_image";
}

@end
