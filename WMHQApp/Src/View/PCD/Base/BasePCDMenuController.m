
#import "BasePCDMenuController.h"
#import "RTSaleReportsTopController.h"
#import "CommConst.h"
#import "AppAreaVO.h"
#import "MenuConst.h"
#import "GlobalApp.h"

@implementation BasePCDMenuController

- (id) init {
    self = [super init];
    if (self) {
        globalApp=[GlobalApp sharedInstance];
        sysDao=[[SysMangDao alloc] init];
        gridMenuView=Nil;
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    UINavigationItem *navigationItem = [super showNavigationBar:[self getNaviTitle] isLandscape:FALSE showBackBtn:TRUE];
    
    areaIDArr=[[NSMutableArray alloc] init];
    NSMutableArray *areaNameArr=[[NSMutableArray alloc] init];
    
    NSMutableArray *appAreaArr=[sysDao findAreaMenus : [self getCurAppID]];
    AppAreaVO *appArea;
    for (int i = 0; i < appAreaArr.count; i++) {
        appArea=[appAreaArr objectAtIndex:i];
        [areaIDArr addObject:appArea.Mandt];
        [areaNameArr addObject:appArea.MandtName];
    }
    
    areaBtn=[[ComboBoxButton alloc] initWithFrame:CGRectMake([self getScreenWidth]-100, -20, 85, 38)];
    areaBtn.showRowCount=1;
    
    areaBtn.delegate=self;
    areaBtn.tableArray= areaNameArr;
    UIBarButtonItem *showLauncher = [[UIBarButtonItem alloc] initWithCustomView:areaBtn.btn];
    
    navigationItem.rightBarButtonItem = showLauncher;
    [self.view addSubview:areaBtn];
    
    logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, [self getScreenWidth], 110)];
    logoImage.image = [UIImage imageNamed:[self getLogoImgName]];
    
    [self.view addSubview:logoImage];
    [areaBtn.btn setTitle:[areaNameArr objectAtIndex:0] forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [globalApp putValue:CUR_APP_ID value:[self getCurAppID]];
    
    [self showMainView];
    
    [self autoResizeView];
}

-(BOOL) needAutoResizeView
{
    return FALSE;
}

- (void)showMainView {
    int index = -1;
    NSString *val = [sysDao getKeyValues:[self getCurMandtKey]];
    if(val != nil){
        for (NSString *item in areaIDArr) {
            index++;
            if([item isEqualToString:val]){
                break;
            }
        }
    }
    if (index==-1) {
        index=0;
    }
    [self launch:index];
}

- (void)launch:(int)index{
    
    CGRect bounds = CGRectMake(0, 160, [self getScreenWidth], [self getScreenHeight]);
    
    NSString *curMandt = [areaIDArr objectAtIndex:index];
    NSString *curMandtName = [areaBtn.tableArray objectAtIndex:index];
    
    [areaBtn.btn setTitle:curMandtName forState:UIControlStateNormal];
    
    [globalApp putValue:CUR_MANDT value:curMandt];
    
    [sysDao updateKeyValues:[self getCurMandtKey] val:curMandt];
    
    NSMutableArray *menusArr=[sysDao findMenus:[self getCurAppID] mandt:curMandt level:MENU_LEVEL_GROUP escapeMenuID: [self getEscapeMenuID]];
    NSMutableArray *itemArr = [NSMutableArray array];
    MenusVO *menu;
    NSString *imageName;
    for (int i = 0; i < menusArr.count; i++) {
        menu=[menusArr objectAtIndex:i];
        imageName=[baseImageMap objectForKey:menu.MenuID];
        if(imageName == nil)
        {
            imageName=@"reports_menu_icon.png";
        }
        if ([MENUID_PCD_PROMO_INPUT_NAVI isEqualToString:menu.MenuID]) {
            [itemArr addObject: [GridMenuItemView initWithTitle:menu.MenuID title:menu.MenuName imgName:imageName uiCtrl:inputNaviCtrl]];
        } else if ([MENUID_PCD_VIEW_NAVI isEqualToString:menu.MenuID]) {
            [itemArr addObject: [GridMenuItemView initWithTitle:menu.MenuID title:menu.MenuName imgName:imageName uiCtrl:searchNaviCtrl]];
        }
    }
    
    if(gridMenuView==Nil){
        gridMenuView = [GridMenuView initWithTitle:bounds items:itemArr fontSize:14 colNum:4 homeCtrler:self];
        [self.view addSubview:gridMenuView];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self closeDropdown];
}

-(void)closeDropdown{
    [areaBtn closeDropdown];
}

-(NSString *) getCurAppID{
    return @"";
}
-(NSString *) getCurMandtKey{
    return @"";
}
-(NSString *) getNaviTitle{
    return @"";
}
-(NSString *) getLogoImgName{
    return @"";
}

-(NSString *) getEscapeMenuID{
    return Nil;
}

-(void)autoResizeView{
    [super autoResizeView];
    
    int posY=50;
    int imgHeight=0;
    if([self isPortrait]){
        if([self isPAD]){
            imgHeight=220;
        }else{
            imgHeight=110;
        }
    }
    
    int sWidth=[self getScreenWidth];
    int sHeight=[self getScreenHeight];
    
    [logoImage setFrame:CGRectMake(0, posY, sWidth, imgHeight)];
    
    [logoImage removeFromSuperview];
    if (imgHeight>0) {
        [self.view addSubview:logoImage];
    }
    
    posY=posY+imgHeight;
    
    if ([self isPortrait]) {
        gridMenuView.colNum=4;
    }else{
        gridMenuView.colNum=6;
    }
    
    if(gridMenuView != Nil){
        [gridMenuView setFrame:CGRectMake(0, posY, sWidth, sHeight)];
        [gridMenuView refresh:gridMenuView.frame :gridMenuView.items];
    }
}

@end
