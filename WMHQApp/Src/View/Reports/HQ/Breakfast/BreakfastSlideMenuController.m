
#import "BreakfastSlideMenuController.h"
#import "BreakfastReportsTopController.h"
#import "BreakfastReportsController.h"
#import "GlobalApp.h"
#import "CommConst.h"
#import "MenusVO.h"

@implementation BreakfastSlideMenuController

- (id) init {
    self = [super init];
    if (self) {
        sysDao=[[SysMangDao alloc] init];
        //mainCtrl = [[BreakfastReportsController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    
    CGRect bounds = CGRectMake(0, 41, 220, mainSize.height);
    
    //创建一个导航栏
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 40)];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"android_title_bg.9"] forBarMetrics:UIBarMetricsDefault];
    
    [navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIColor whiteColor], UITextAttributeTextColor,
                                           nil]];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"导航菜单"];
    
    //把导航栏集合添加入导航栏中，设置动画关闭
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    //把导航栏添加到视图中
    [self.view addSubview:navigationBar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view setBackgroundColor: [UIColor whiteColor]];
   
    NSString *evnName=@"BreakfastSlideMenuController.showSlideMenu";
    [[NSNotificationCenter defaultCenter] removeObserver:self name:evnName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showSlideMenu)
                                                 name:evnName
                                               object:nil];
    
    [[GlobalApp sharedInstance] putValue:CUR_SHOW_SLIDE_MENU_EVN_NM value:evnName];
    
    [self showSlideMenu];
}

- (void)showSlideMenu {
    
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    
    CGRect bounds = CGRectMake(0, 41, 220, mainSize.height-100);
    
    GlobalApp *globalApp=[GlobalApp sharedInstance];
    NSString *curMenuID= [globalApp getValue:CUR_SUPER_MENU_ID];
    
    NSMutableArray *menusArr=[sysDao findChildMenus:curMenuID];
    NSMutableArray *gridItems = [NSMutableArray array];
    MenusVO *menu;
    for (int i = 0; i < menusArr.count; i++) {
        menu=[menusArr objectAtIndex:i];
        [gridItems addObject: [GridMenuItemView initWithTitle:menu.MenuID title:menu.MenuName imgName:@"grid_item_icon_small.png" uiCtrl: self.mainCtrl]];
    }
    
    if(!board){
        board = [GridMenuView initWithTitle:bounds items:gridItems fontSize:11 colNum:3  homeCtrler:self];
        board.isSubMenu=true;
        [self.view addSubview:board];
    }else{
        [board refresh:bounds :gridItems];
    }
}

@end
