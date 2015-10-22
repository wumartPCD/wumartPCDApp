
#import "ChangePswdController.h"
#import "ChangePswdWebService.h"
#import "XMLHandleHelper.h"
#import "CommConst.h"
#import "MenusVO.h"
#import "SysMangDao.h"
#import "GlobalApp.h"

@interface ChangePswdController ()

@end

@implementation ChangePswdController

@synthesize oldPswdField, setPswdField, cfrmPswdField;

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
    
    [super showNavigationBar:@"登录密码变更" isLandscape:FALSE showBackBtn:TRUE];
    [self.navigationController setNavigationBarHidden:YES];
    
    CGFloat width=self.view.frame.size.width;
    
    UIColor* mainColor = [UIColor colorWithRed:134.0/255 green:176.0/255 blue:216.0/255 alpha:1.0f];
    UIColor* darkColor = [UIColor colorWithRed:7.0/255 green:61.0/255 blue:48.0/255 alpha:1.0f];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldFontName = @"Avenir-Black";
    
    self.view.backgroundColor = mainColor;

    self.oldPswdField = [[UITextField alloc] initWithFrame:CGRectMake(30, 70, width-60, 41)];
    self.oldPswdField.backgroundColor = [UIColor whiteColor];
    self.oldPswdField.layer.cornerRadius = 3.0f;
    self.oldPswdField.placeholder = @"旧密码";
    self.oldPswdField.font = [UIFont fontWithName:fontName size:16.0f];
    
    self.oldPswdField.leftViewMode = UITextFieldViewModeAlways;
    self.oldPswdField.leftView = [self getPswdContainer];
    
    self.setPswdField = [[UITextField alloc] initWithFrame:CGRectMake(30, 130, width-60, 41)];
    self.setPswdField.backgroundColor = [UIColor whiteColor];
    self.setPswdField.layer.cornerRadius = 3.0f;
    self.setPswdField.placeholder = @"新密码";
    self.setPswdField.font = [UIFont fontWithName:fontName size:16.0f];
    
    self.setPswdField.leftViewMode = UITextFieldViewModeAlways;
    self.setPswdField.leftView = [self getPswdContainer];
    
    self.cfrmPswdField = [[UITextField alloc] initWithFrame:CGRectMake(30, 190, width-60, 41)];
    self.cfrmPswdField.backgroundColor = [UIColor whiteColor];
    self.cfrmPswdField.layer.cornerRadius = 3.0f;
    self.cfrmPswdField.placeholder = @"确认密码";
    self.cfrmPswdField.font = [UIFont fontWithName:fontName size:16.0f];
    
    self.cfrmPswdField.leftViewMode = UITextFieldViewModeAlways;
    self.cfrmPswdField.leftView = [self getPswdContainer];
    
    UIImage *launcherImage=[UIImage imageNamed:@"btn_title_back"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:launcherImage forState:UIControlStateNormal];
    
    self.submitBtn  = [[UIButton alloc] initWithFrame:CGRectMake(30, 250, width-60, 45)];
    self.submitBtn.backgroundColor = darkColor;
    self.submitBtn.layer.cornerRadius = 3.0f;
    self.submitBtn.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [self.submitBtn setTitle:@"变  更" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    [self.submitBtn addTarget:self action:@selector(doChangePswd:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.oldPswdField];
    [self.view addSubview:self.setPswdField];
    [self.view addSubview:self.cfrmPswdField];
    [self.view addSubview:self.submitBtn];
}

- (void) doChangePswd:(id) sender {
    
    if (self.oldPswdField.text.length==0) {
        [self displayHintInfo:@"请输入旧密码！"];
        return;
    }else if (self.setPswdField.text.length==0) {
        [self displayHintInfo:@"请输入新密码！"];
        return;
    }else if (self.cfrmPswdField.text.length==0) {
        [self displayHintInfo:@"请输入确认密码！"];
        return;
    }
    
    SysMangDao *sysDao = [[SysMangDao alloc] init];
    LoginUserRtnVO *loingUser=[sysDao getLoginUser];
    
    if (![self.oldPswdField.text isEqualToString:loingUser.Password]) {
        [self displayHintInfo:@"旧密码不正确！"];
        return;
    }else if (![self.setPswdField.text isEqualToString:self.cfrmPswdField.text ]) {
        [self displayHintInfo:@"新密码与确认密码不一致！"];
        return;
    }
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:loingUser.UserCode, oldPswdField.text, setPswdField.text, AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, OLD_PASSWORD, NEW_PASSWORD, AUTH_KEY, nil];
    
    XMLHandleHelper *xmlHelper = [XMLHandleHelper sharedInstance];
    
    ChangePswdWebService *service = [ChangePswdWebService sharedInstance];
    BaseRtnVO *rtnUser = [service exec:[xmlHelper createParamXmlStr:valArr colName:colNameArr]];
    
    if(rtnUser.ResultFlag == 0){
        [sysDao changePswd:loingUser.UserCode pswd:self.setPswdField.text];
        [self displayHintInfo:@"您的密码变更成功！"];
    }else{
        [self displayHintInfo:rtnUser.ResultMesg];
    }
}

-(UIView *) getPswdContainer {
    UIImageView *pswdImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    pswdImage.image = [UIImage imageNamed:@"icon_login_psw"];
    UIView *pswdContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    pswdContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.2];
    [pswdContainer addSubview:pswdImage];
    return pswdContainer;
}
@end
