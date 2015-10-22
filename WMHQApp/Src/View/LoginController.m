
#import "LoginController.h"
#import "LoginWebService.h"
#import "XMLHandleHelper.h"
#import "FetchPswdWebService.h"
#import "LoginPswdRtnVO.h"
#import "SiteDeptSearchWhere.h"
#import "SQLiteHelper.h"
#import "CommConst.h"
#import "MenusVO.h"
#import "GlobalApp.h"
#import "NetworkHelper.h"

@interface LoginController ()

@end

@implementation LoginController

@synthesize usernameField, passwordField, loginBtn, fetchPswdBtn;

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
    
    CGFloat width=self.view.frame.size.width;
    
    UIColor* mainColor = [UIColor colorWithRed:134.0/255 green:176.0/255 blue:216.0/255 alpha:1.0f];
    UIColor* darkColor = [UIColor colorWithRed:7.0/255 green:61.0/255 blue:48.0/255 alpha:1.0f];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldFontName = @"Avenir-Black";
    
    self.view.backgroundColor = mainColor;
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [super showNavigationBar:@"用户登录" isLandscape:FALSE showBackBtn:FALSE];
    
    UIImageView* loginLogoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, width, 90)];
    loginLogoImage.image = [UIImage imageNamed:@"login_logo"];
    
    usernameField = [[UITextField alloc] initWithFrame:CGRectMake(30, 154, width-60, 41)];
    usernameField.backgroundColor = [UIColor whiteColor];
    usernameField.layer.cornerRadius = 3.0f;
    usernameField.placeholder = @"请输入账号";
    usernameField.font = [UIFont fontWithName:fontName size:16.0f];
    
    UIImageView* usernameIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    usernameIconImage.image = [UIImage imageNamed:@"icon_login_user"];
    UIView* usernameIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    usernameIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.2];
    [usernameIconContainer addSubview:usernameIconImage];
    
    usernameField.leftViewMode = UITextFieldViewModeAlways;
    usernameField.leftView = usernameIconContainer;
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(30, 200, width-60, 41)];
    passwordField.backgroundColor = [UIColor whiteColor];
    passwordField.layer.cornerRadius = 3.0f;
    passwordField.placeholder = @"请输入验证码";
    passwordField.font = [UIFont fontWithName:fontName size:16.0f];
    passwordField.secureTextEntry = YES;
    
    UIImageView* passwordIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    passwordIconImage.image = [UIImage imageNamed:@"icon_login_psw"];
    UIView* passwordIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    passwordIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.2];
    [passwordIconContainer addSubview:passwordIconImage];
    
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    passwordField.leftView = passwordIconContainer;
    
    fetchPswdBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 250, width/2-45, 45)];
    fetchPswdBtn.backgroundColor = darkColor;
    fetchPswdBtn.layer.cornerRadius = 3.0f;
    fetchPswdBtn.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [fetchPswdBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [fetchPswdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fetchPswdBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    [fetchPswdBtn addTarget:self action:@selector(doFetchPswd:) forControlEvents:UIControlEventTouchUpInside];
    
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(width/2+15, 250, width/2-45, 45)];
    loginBtn.backgroundColor = darkColor;
    loginBtn.layer.cornerRadius = 3.0f;
    loginBtn.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [loginBtn setTitle:@"登  陆" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(doLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginLogoImage];
    [self.view addSubview:self.usernameField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.fetchPswdBtn];
    [self.view addSubview:self.loginBtn];
}

- (void) doFetchPswd:(id) sender {
    [self hideKeybord];
    
    if(usernameField.text.length==0){
        [self displayHintInfo:@"请输入手机号！"];
        return;
    }
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:usernameField.text, AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, AUTH_KEY, nil];
    
    XMLHandleHelper *xmlHelper = [XMLHandleHelper sharedInstance];
    
    FetchPswdWebService *service = [FetchPswdWebService sharedInstance];
    LoginPswdRtnVO *rtnUser = [service exec:[xmlHelper createParamXmlStr:valArr colName:colNameArr]];
    if(rtnUser.ResultFlag == 0){
        //passwordField.text = rtnUser.LoginPswd;
        [self displayHintInfo:@"获取验证码成功，已发送短信！"];
    }else{
        [self displayHintInfo:rtnUser.ResultMesg];
    }
}

- (void) doLogin:(id) sender {
    [self hideKeybord];
    
    if(usernameField.text.length==0){
        [self displayHintInfo:@"请输入手机号！"];
        return;
    }else if(passwordField.text.length==0){
        [self displayHintInfo:@"请输入验证码！"];
        return;
    }
    
    LoginUserRtnVO *rtnUser = [self execLogin:usernameField.text pswd:passwordField.text];
    rtnUser.Password =passwordField.text;
    
    if(rtnUser.ResultFlag == 0){
        [self.navigationController popViewControllerAnimated:true];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeController.showMainView" object:nil];
    }else if(rtnUser.ResultFlag == -1){
        [self displayHintInfo:@"请检查您的网络是否正常！"];
    }else{
        [self displayHintInfo:rtnUser.ResultMesg];
    }
}

- (LoginUserRtnVO *)execLogin:(NSString *) userCode pswd:(NSString *)pswd
{
    LoginUserRtnVO *rtnUser;
    
    @try {        
        NSArray* valArr = [[NSArray alloc] initWithObjects:userCode, pswd, [NetworkHelper GetDeviceUUID], AUTH_KEY_VAL, nil];
        NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, LOGIN_PSWD, MAC_ADDRESS, AUTH_KEY, nil];
        
        XMLHandleHelper *xmlHelper = [XMLHandleHelper sharedInstance];
        
        LoginWebService *service = [LoginWebService sharedInstance];
        
        rtnUser = [service exec:[xmlHelper createParamXmlStr:valArr colName:colNameArr]];
        rtnUser.Password =passwordField.text;
        
        if(rtnUser.ResultFlag == 0){
            [[GlobalApp sharedInstance] putValue:CUR_LOGIN_USER_NO value:userCode];
            
            SiteDeptSearchWhere *searchWhere = [[SiteDeptSearchWhere alloc] init];
            [searchWhere fetchSite:rtnUser];
            [[GlobalApp sharedInstance] putValue:CUR_SITE_DEPT_WHERE value:searchWhere];
            
            SQLiteHelper *dbHelper = [SQLiteHelper sharedInstance];
            
            [dbHelper refreshDB];
            [dbHelper openDB];
            
            NSMutableArray *appSysVOArr = [rtnUser AppSysVOArr];
            NSMutableArray *appAreaVOArr = [rtnUser AppAreaVOArr];
            NSMutableArray *menusVOArr = [rtnUser MenusArr];
            
            NSMutableString *strBuf = [[NSMutableString alloc] initWithCapacity:2];
            AppSysVO *appSys;
            for (int i = 0; i < appSysVOArr.count; i++) {
                appSys=[appSysVOArr objectAtIndex:i];
                [strBuf setString: @""];
                [strBuf appendString: @"INSERT INTO AppSys(AppID,AppName)"];
                [strBuf appendString: @" VALUES (?,?)"];
                [[dbHelper getDB] executeUpdate:[NSString stringWithString:strBuf],appSys.AppID,appSys.AppName];
            }
            AppAreaVO *appArea;
            for (int i = 0; i < appAreaVOArr.count; i++) {
                appArea=[appAreaVOArr objectAtIndex:i];
                [strBuf setString: @""];
                [strBuf appendString: @"INSERT INTO AppArea(AppID,Mandt,MandtName)"];
                [strBuf appendString: @" VALUES (?,?,?)"];
                [[dbHelper getDB] executeUpdate:[NSString stringWithString:strBuf],appArea.AppID,appArea.Mandt,appArea.MandtName];
            }
            MenusVO *menus;
            for (int i = 0; i < menusVOArr.count; i++) {
                menus=[menusVOArr objectAtIndex:i];
                [strBuf setString: @""];
                [strBuf appendString: @"INSERT INTO Menus(MenuID,PMenuID,MenuName,Mandt,AppID,Level,IconUrl,No)"];
                [strBuf appendString: @" VALUES (?,?,?,?,?,?,null,?)"];
                [[dbHelper getDB] executeUpdate:[NSString stringWithString:strBuf],menus.MenuID,menus.ParentMenuID,menus.MenuName,menus.Mandt,menus.AppID,([menus.ParentMenuID isEqualToString:@"0"])?@"1":@"2",menus.MenuID];
            }
            
            [strBuf setString: @""];
            [strBuf appendString: @"INSERT INTO LoginUser(UserId,UserCode,UserName,Password)"];
            [strBuf appendString: @" VALUES (?,?,?,?)"];
            [[dbHelper getDB] executeUpdate:[NSString stringWithString:strBuf],rtnUser.UserId,userCode,rtnUser.UserName,pswd];
            
            [dbHelper closeDB];
        }
    } @catch (NSException *exp) {
        rtnUser=[[LoginUserRtnVO alloc] init];
        rtnUser.ResultFlag=-1;
        rtnUser.ResultMesg=[exp reason];
    }
    return rtnUser;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hideKeybord];
}

-(void)hideKeybord{
    
    if(![usernameField isFirstResponder]){
        [passwordField resignFirstResponder];
    } else if(![passwordField isFirstResponder]){
        [usernameField resignFirstResponder];
    }
}

@end
