

#import "BaseViewController.h"
#import "UIView+Toast.h"
#import "BaseLandscapeController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - Left cycle init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)onBackBtnClick: (id) sender {
    
    [self.navigationController popViewControllerAnimated:true];
}

- (UINavigationItem *)showNavigationBar:(NSString *) title isLandscape:(BOOL) isLandscape showBackBtn:(BOOL) showBackBtn
{
    [self.navigationController setNavigationBarHidden:YES];
    
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    
    CGFloat width = isLandscape?mainSize.height:mainSize.width;
    
    //创建一个导航栏
    curNaviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
    [curNaviBar setBackgroundImage:[UIImage imageNamed:@"android_title_bg.9"] forBarMetrics:UIBarMetricsDefault];
    
    [curNaviBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor whiteColor], UITextAttributeTextColor,
                                        nil]];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:title];
    
    if(showBackBtn){
        UIImage *launcherImage=[UIImage imageNamed:@"btn_title_back"];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:launcherImage forState:UIControlStateNormal];
        [backBtn setFrame:CGRectMake(0, 0, 60, 38)];
        [backBtn addTarget:self action:@selector(onBackBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *showLauncher = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        navigationItem.leftBarButtonItem = showLauncher;
    }
    
    //把导航栏集合添加入导航栏中，设置动画关闭
    [curNaviBar pushNavigationItem:navigationItem animated:NO];
    
    //把导航栏添加到视图中
    [self.view addSubview:curNaviBar];
    
    return navigationItem;
}

-(void)autoResizeView
{
    [curNaviBar setFrame:CGRectMake(0, 0, [self getScreenWidth], 50)];
}

#pragma mark - keyboard helper

- (void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

- (void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)sender
{
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
- (void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kXHOFFSET_FOR_KEYBOARD;
        rect.size.height += kXHOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kXHOFFSET_FOR_KEYBOARD;
        rect.size.height -= kXHOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

- (void)displayHintInfo:(NSString *) mesg
{
    [self.view makeToast:mesg];
}

- (BOOL)isContainString:(NSString *) str subStr:(NSString *) subStr
{
    subStr=[@"|" stringByAppendingString:subStr];
    subStr=[subStr stringByAppendingString:@"|"];
    
    return ([str rangeOfString:subStr].location!=NSNotFound);
}

-(BOOL)isPortrait
{
    return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation);
}

- (BOOL)isPAD
{
    NSString *deviceType=[[GlobalApp sharedInstance] getValue:DEVICE_TYPE];
    
    return [DEVICE_TYPE_PAD isEqualToString:deviceType];
}

- (int)getScreenWidth
{
    if ([self isPortrait]) {
        return kSCREEN_HEIGHT>kSCREEN_WIDTH ? kSCREEN_WIDTH : kSCREEN_HEIGHT;
    }else{
        return kSCREEN_WIDTH>kSCREEN_HEIGHT ? kSCREEN_WIDTH : kSCREEN_HEIGHT;
    }
}

- (int)getScreenHeight
{
    if ([self isPortrait]) {
        return kSCREEN_HEIGHT>kSCREEN_WIDTH ? kSCREEN_HEIGHT : kSCREEN_WIDTH;
    }else{
        return kSCREEN_WIDTH>kSCREEN_HEIGHT ? kSCREEN_HEIGHT : kSCREEN_WIDTH;
    }
}



@end
