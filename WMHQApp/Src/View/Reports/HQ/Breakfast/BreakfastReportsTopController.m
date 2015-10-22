
#import "BreakfastReportsTopController.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "GlobalApp.h"

@implementation BreakfastReportsTopController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    globalApp=[GlobalApp sharedInstance];
    
    //菜单栏,首页
    slideMenuController = [[BreakfastSlideMenuController alloc]init];
    
    breakfastController = [[BreakfastReportsController alloc]init];
    h111Controller = [[HQPromoH111Controller alloc]init];
    
    BaseReportsController *reportsController=[self getCurController];
    
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
    
    BaseReportsController *reportsController=[self getCurController];
    
    slideMenuController.mainCtrl=reportsController;
    [self setFrontViewController:reportsController animated:false];
    
    NSString *evnName=@"BreakfastReportsTopController.showSlideMenuView";
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

- (BaseReportsController *)getCurController {
    
    BaseReportsController *reportsController;
    
    NSString *curPMenuID= [globalApp getValue:CUR_SUPER_MENU_ID];
    if ([self isContainString:MENUID_HQ_PROMO_H111 subStr:curPMenuID]) {
        return reportsController = h111Controller;
    }else {
        return reportsController = breakfastController;
    }
}

@end
