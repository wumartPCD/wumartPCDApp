
#import "HomeController.h"
#import "GridMenuView.h"
#import "MenuConst.h"
#import "CommConst.h"
#import "LoginController.h"
#import "PCDStandMenuController.h"
#import "SysSetController.h"
#import "GlobalApp.h"
#import "XMLHandleHelper.h"
#import "CheckVersionWebService.h"
#import "XWAlterview.h"

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"HomeController.showMainView"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showMainView)
                                                 name:@"HomeController.showMainView"
                                               object:nil];
    
    sysDao = [[SysMangDao alloc] init];
    
    LoginUserRtnVO *loingUser=[sysDao getLoginUser];
    if(loingUser==nil || loingUser.UserCode==nil){
        [self showLoginView];
    }else{
        LoginController *loginCtrl=[[LoginController alloc] init];
        LoginUserRtnVO *rtnUser = [loginCtrl execLogin:loingUser.UserCode pswd:loingUser.Password];
        
        if(rtnUser.ResultFlag == -1 || rtnUser.ResultFlag == 4){
            [self showLoginView];
        }else if(rtnUser.ResultFlag == 0){
            [self showMainView];
        }else{
            [self displayHintInfo:rtnUser.ResultMesg];
        }
    }
}

- (void)showMainView {
    
    [super showNavigationBar:@"陈列标准化管理" isLandscape:FALSE showBackBtn:FALSE];
    
    logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, [self getScreenWidth], 110)];
    logoImage.image = [UIImage imageNamed:@"index_image"];
    
    [self.view addSubview:logoImage];
    
    CGRect bounds = CGRectMake(0, 160, [self getScreenWidth], [self getScreenHeight]);
    sysDao = [[SysMangDao alloc] init];
    NSMutableArray *menuArr = [[NSMutableArray alloc] initWithCapacity:4];
    //if ([sysDao hasAppAuth: APP_ID_BREAKFAST]){
        [menuArr addObject:[GridMenuItemView initWithTitle:APP_ID_BREAKFAST
                                                     title:@"陈列标准" imgName:@"index_pcd_stand_icon.png" uiCtrl:[[PCDStandMenuController alloc] init]]];
    //}
    /*
    if ([sysDao hasAppAuth: APP_ID_RTSALE]){
        [menuArr addObject:[GridMenuItemView initWithTitle:APP_ID_RTSALE
                                                     title:@"陈列执行" imgName:@"index_pcd_exec_icon.png" uiCtrl:[[RTSaleMenuController alloc] init]]];
        [menuArr addObject:[GridMenuItemView initWithTitle:APP_ID_RTSALE
                                                     title:@"陈列检核" imgName:@"index_pcd_check_icon.png" uiCtrl:[[RTSaleSnapMenuController alloc] init]]];
    }
*/
    [menuArr addObject:[GridMenuItemView initWithTitle:@""
                                                 title:@"设置" imgName:@"index_set_icon.png" uiCtrl:[[SysSetController alloc] init]]];
    
    gridMenuView = [GridMenuView initWithTitle:bounds items:menuArr fontSize:14 colNum:4 homeCtrler:self];
    [self.view addSubview:gridMenuView];
    
    bottomImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, [self getScreenHeight]-35, [self getScreenWidth], 35)];
    
    [self.view addSubview:bottomImage];
    
    [self checkVersion];
    
    [self autoResizeView];
}

- (void) showLoginView{
    
    [self.navigationController pushViewController:[[LoginController alloc] init] animated:true];
}

- (void) checkVersion {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *curVersion = [infoDict objectForKey:@"CFBundleVersion"];
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:APP_TYPE, AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:@"AppType", AUTH_KEY, nil];
    
    XMLHandleHelper* xmlHelper = [XMLHandleHelper sharedInstance];
    
    CheckVersionWebService * service = [CheckVersionWebService sharedInstance];
    AppVersionRtnVO* rtnVO = [service exec: [xmlHelper createParamXmlStr:valArr colName:colNameArr]];
    if(rtnVO.ResultFlag == 0){
        if([curVersion isEqualToString:rtnVO.VerCode]){
        }else{
            XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"发现新版本" contentText:[@"升级内容：" stringByAppendingString:rtnVO.VerIntro] leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
            alter.rightBlock=^() { };
            alter.leftBlock=^()
            {
                NSURL *url = [NSURL URLWithString:APP_UPDATE_URL];
                [[UIApplication sharedApplication]openURL:url];
            };
            alter.dismissBlock=^() { };
            [alter show];
        }
    }else{
        [self displayHintInfo:rtnVO.ResultMesg];
    }
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
    //    if ([self isPortrait]) {
    //        sWidth=[self getScreenHeight];
    //        sHeight=[self getScreenHeight];
    //    }
    
    [logoImage setFrame:CGRectMake(0, posY, sWidth, imgHeight)];
    
    [logoImage removeFromSuperview];
    if (imgHeight>0) {
        [self.view addSubview:logoImage];
    }
    
    if([self isPortrait]){
        bottomImage.image = [UIImage imageNamed:@"index_bottom_img_p"];
    }else{
        bottomImage.image = [UIImage imageNamed:@"index_bottom_img_l"];
    }
    posY=posY+imgHeight;
    [gridMenuView setFrame:CGRectMake(0, posY, sWidth, sHeight)];
    [bottomImage setFrame:CGRectMake(0, sHeight-35, sWidth, 35)];
    
    
    if ([self isPortrait]) {
        gridMenuView.colNum=4;
    }else{
        gridMenuView.colNum=6;
    }
    
    if(gridMenuView != Nil){
        [gridMenuView refresh:gridMenuView.bounds :gridMenuView.items];
    }
}

@end
