
#import "SitePerfmReportsTopController.h"
#import "SitePerfmS101Controller.h"
#import "SitePerfmS107Controller.h"
#import "SitePerfmTop10Controller.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "GlobalApp.h"
#import "BreakfastReportsController.h"

@implementation SitePerfmReportsTopController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    globalApp=[GlobalApp sharedInstance];
    
    //菜单栏,首页
    slideMenuController = [[SitePerfmSlideMenuController alloc]init];
    
    s101Controller = [[SitePerfmS101Controller alloc]init];
    s107Controller = [[SitePerfmS107Controller alloc]init];
    top10Controller = [[SitePerfmTop10Controller alloc]init];
    s108Controller = [[SitePerfmS108Controller alloc]init];
    
    BaseSitePerfmController *reportsController=[self getCurController];
    
    slideMenuController.mainCtrl=reportsController;
    
    [self initWithRearViewController:slideMenuController frontViewController:reportsController];
    
    //浮动层离左边距的宽度
    self.rearViewRevealWidth = 230;
    
    //是否让浮动层弹回原位
    [self setFrontViewPosition:FrontViewPositionLeft animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BaseSitePerfmController *reportsController=[self getCurController];
    
    slideMenuController.mainCtrl=reportsController;
    [self setFrontViewController:reportsController animated:false];
    
    NSString *evnName=@"BaseSitePerfmController.showSlideMenuView";
    [[NSNotificationCenter defaultCenter] removeObserver:self name:evnName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showSlideMenuView)
                                                 name:evnName
                                               object:nil];
    
    [[GlobalApp sharedInstance] putValue:CUR_SHOW_SLIDE_MENU_VIEW_EVN_NM value:evnName];
}

- (void)showSlideMenuView {
    
    [self revealToggleAnimated:YES];
}

- (BaseSitePerfmController *)getCurController {
    
    BaseSitePerfmController *reportsController;
    
    NSString *curPMenuID= [globalApp getValue:CUR_SUPER_MENU_ID];
    if ([self isContainString:MENUID_SITE_PERFM_S101 subStr:curPMenuID]) {
        return  reportsController = s101Controller;
    }else  if ([self isContainString:MENUID_SITE_PERFM_S107 subStr:curPMenuID]) {
        return  reportsController = s107Controller;
    }else  if ([self isContainString:MENUID_SITE_PERFM_S108 subStr:curPMenuID]) {
        return  reportsController = s108Controller;
    }else {
        return reportsController = top10Controller;
    }
}

@end
