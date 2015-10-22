
#import "SysSetMainController.h"
#import "SQLiteHelper.h"
#import "XWAlterview.h"
#import "CommConst.h"
#import "XMLHandleHelper.h"
#import "CheckVersionWebService.h"
#import "AppVersionRtnVO.h"
#import "ChangePswdController.h"

@interface SysSetMainController ()

@end

@implementation SysSetMainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [super showNavigationBar:@"系统设置" isLandscape:FALSE showBackBtn:TRUE];
}

- (IBAction)checkVersion:(id)sender{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *curVersion = [infoDict objectForKey:@"CFBundleVersion"];
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:APP_TYPE, AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:@"AppType", AUTH_KEY, nil];
    
    XMLHandleHelper* xmlHelper = [XMLHandleHelper sharedInstance];
    
    CheckVersionWebService * service = [CheckVersionWebService sharedInstance];
    AppVersionRtnVO* rtnVO = [service exec: [xmlHelper createParamXmlStr:valArr colName:colNameArr]];
    if(rtnVO.ResultFlag == 0){
        
        if([curVersion isEqualToString:rtnVO.VerCode]){
            [self displayHintInfo:@"当前是最新版本！"];
        }else{
            XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"新版本提示" contentText:[@"升级内容：" stringByAppendingString:rtnVO.VerIntro] leftButtonTitle:@"确认" rightButtonTitle:@"取消"];
            alter.rightBlock=^() { };
            alter.leftBlock=^()
            {
                NSURL *url = [NSURL URLWithString:@"http://fir.im/WMHQApp"];
                [[UIApplication sharedApplication]openURL:url];
            };
            alter.dismissBlock=^() { };
            [alter show];
        }
    }else{
        [self displayHintInfo:rtnVO.ResultMesg];
    }
}

- (IBAction)changePswd:(id)sender{
    [self.navigationController pushViewController:[[ChangePswdController alloc] init] animated:true];
}

- (IBAction)quitCurrentAccount:(id)sender {
    
    XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"提示" contentText:@"确认清除登录信息并退出吗?" leftButtonTitle:@"确认" rightButtonTitle:@"取消"];
    alter.rightBlock=^() { };
    alter.leftBlock=^()
    {
        SQLiteHelper *dbHelper = [SQLiteHelper sharedInstance];
        
        [dbHelper openDB];
        [dbHelper clearDB];
        [dbHelper closeDB];
        
        exit(0);
    };
    alter.dismissBlock=^() { };
    [alter show];
}
@end
