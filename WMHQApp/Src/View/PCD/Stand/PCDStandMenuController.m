
#import "PCDStandMenuController.h"
#import "PCDStandSearchNaviController.h"
#import "CommConst.h"
#import "MenuConst.h"

@implementation PCDStandMenuController

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
        searchNaviCtrl = [[PCDStandSearchNaviController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(NSString *) getCurAppID{
    return APP_ID_PCD_STAND;
}
-(NSString *) getCurMandtKey{
    return CUR_PCD_STAND_MANDT;
}
-(NSString *) getNaviTitle{
    return @"陈列标准";
}
-(NSString *) getLogoImgName{
    return @"breakfast_menu_image";
}

@end
