
#import "S108SearchView.h"
#import "CommConst.h"
#import "XMLHandleHelper.h"
#import "S108SiteWebService.h"
#import "MasterDataRtnVO.h"
#import "UIView+Toast.h"

@interface S108SearchView()

@end

@implementation S108SearchView

@synthesize popView;

+ (id)initView:(CGRect)bounds superFrame:(CGRect)superFrame {
    S108SearchView *instance = [[S108SearchView alloc] initViewWithBounds:bounds superFrame:superFrame];
    
    return instance;
}

- (id)initViewWithBounds:(CGRect)bounds superFrame:(CGRect)superFrame {
    
    self = [super initWithFrame:superFrame];
    if (self) {
        
        globalApp=[GlobalApp sharedInstance];
        searchWhere=[globalApp getValue:CUR_SITE_DEPT_WHERE];
        curSiteB=[searchWhere getSiteInfo:searchWhere.CurSiteNo];
        NSArray *sites = [curSiteB componentsSeparatedByString:@"-"];
        curSiteB=sites[0];
        
        CGFloat width=bounds.size.width;
        
        UIColor* mainColor = [UIColor colorWithRed:134.0/255 green:176.0/255 blue:216.0/255 alpha:1.0f];
        UIColor* darkColor = [UIColor colorWithRed:7.0/255 green:61.0/255 blue:48.0/255 alpha:1.0f];
        
        NSString* fontName = @"Avenir-Book";
        NSString* boldFontName = @"Avenir-Black";
        
        self.backgroundColor = [UIColor clearColor];
        
        UIView *searchView = [[UIView alloc] initWithFrame:bounds];
        searchView.backgroundColor=mainColor;
        
        int xPos = 30 + bounds.origin.x;
        int yPos = 30 + bounds.origin.y;
        
        siteALabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, 70, 38)];
        siteALabel.backgroundColor = [UIColor clearColor];
        siteALabel.font = [UIFont fontWithName:fontName size:16.0f];
        siteALabel.text=@"A  店：";
        
        siteAText = [[UITextField alloc] initWithFrame:CGRectMake(xPos+70, yPos, 165, 38)];
        siteAText.backgroundColor = [UIColor whiteColor];
        siteAText.layer.cornerRadius = 3.0f;
        siteAText.font = [UIFont fontWithName:fontName size:16.0f];
        siteAText.keyboardType= UIKeyboardTypeNumberPad;
        siteAText.clearButtonMode = UITextFieldViewModeAlways;
        
        siteBLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos+46, 70, 38)];
        siteBLabel.backgroundColor = [UIColor clearColor];
        siteBLabel.font = [UIFont fontWithName:fontName size:16.0f];
        siteBLabel.text=@"B  店：";
        
        UIImage *textBgImg=[UIImage imageNamed:@"text_bg_img.png"];
        siteBComboxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [siteBComboxBtn setBackgroundImage:textBgImg forState:UIControlStateNormal];
        [siteBComboxBtn setFrame:CGRectMake(xPos+70, yPos+46, 165, 38)];
        [siteBComboxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [siteBComboxBtn.titleLabel setFont:[UIFont fontWithName:fontName size:15.0f]];
        siteBComboxBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        siteBComboxBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
        [siteBComboxBtn addTarget:self action:@selector(onSiteComboBoxBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        
        siteCLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos+92, 70, 38)];
        siteCLabel.backgroundColor = [UIColor clearColor];
        siteCLabel.font = [UIFont fontWithName:fontName size:16.0f];
        siteCLabel.text=@"C  店：";
        
        siteCText = [[UITextField alloc] initWithFrame:CGRectMake(xPos+70, yPos+92, 165, 38)];
        siteCText.backgroundColor = [UIColor whiteColor];
        siteCText.layer.cornerRadius = 3.0f;
        siteCText.font = [UIFont fontWithName:fontName size:16.0f];
        siteCText.keyboardType= UIKeyboardTypeNumberPad;
        siteCText.clearButtonMode = UITextFieldViewModeAlways;
        
        cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(xPos, 142+yPos, width/2-45, 45)];
        cancelBtn.backgroundColor = darkColor;
        cancelBtn.layer.cornerRadius = 3.0f;
        cancelBtn.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
        [cancelBtn setTitle:@"取  消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(onCancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(bounds.origin.x+width/2+15, 142+yPos, width/2-45, 45)];
        searchBtn.backgroundColor = darkColor;
        searchBtn.layer.cornerRadius = 3.0f;
        searchBtn.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
        [searchBtn setTitle:@"查  询" forState:UIControlStateNormal];
        [searchBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
        [searchBtn addTarget:self action:@selector(onSearchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleTap];
        singleTap.delegate = self;
        singleTap.cancelsTouchesInView = NO;
        
        [self addSubview:searchView];
        
        [self addSubview:siteALabel];
        [self addSubview:siteAText];
        
        [self addSubview:siteBLabel];
        [self addSubview:siteBComboxBtn];
        
        [self addSubview:siteCLabel];
        [self addSubview:siteCText];
        
        [self addSubview:cancelBtn];
        [self addSubview:searchBtn];
    }
    return self;
}

- (void) initData:(SysMangDao *)sysDao {
    NSString *siteA = [sysDao getKeyValues:CUR_S108_SITE_A];
    
    NSString *siteB = [sysDao getKeyValues:CUR_S108_SITE_B];
    if (siteB==Nil) {
        siteB=curSiteB;
    }else{
        NSString *siteInfo=[searchWhere getSiteInfo:siteB];
        if ([siteInfo isEqualToString:@"全部"]) {
            siteB=curSiteB;
        }else{
            curSiteB=siteB;
        }
    }
    
    NSString *siteC = [sysDao getKeyValues:CUR_S108_SITE_C];
    
    siteAText.text = (siteA==Nil ? @"":siteA);
    
    [siteBComboxBtn setTitle:[searchWhere getSiteInfo:siteB] forState:UIControlStateNormal];
    
    siteCText.text = (siteC==Nil ? @"":siteC);
}

- (void) onSiteComboBoxBtnClick:(id) sender {
    if(siteBComboxList == Nil) {
        NSArray *dataArr = searchWhere.SiteList;
        NSUInteger len =dataArr.count;
        CGFloat f = (len>3?3:len)*39;
        
        siteBComboxList = [[ComboBoxList alloc]showDropDown:sender :&f :dataArr :Nil :@"down"];
        siteBComboxList.delegate = self;
    } else {
        [siteBComboxList hideDropDown:((UIButton *)sender).frame];
        siteBComboxList=Nil;
    }
}

- (void) onComboBoxListSelect:(id)sender index:(int)index {
    
    siteBComboxList=Nil;
    
    NSArray *sites = [siteBComboxBtn.currentTitle componentsSeparatedByString:@"-"];
    curSiteB = [sites objectAtIndex:0];
    
    [self fetchS108Site];
}

- (void) onCancelBtnClick:(id) sender {
    
    [self.window endEditing:YES];
    
    [popView hidden];
}

- (void) refreshWhere {
    if ([siteCText.text length]==0) {
        [self fetchS108Site];
    }
}

- (void) saveData:(SysMangDao *)sysDao {
    
    NSArray *wheres = [self getSearchWhere];
    
    [sysDao updateKeyValues:CUR_S108_SITE_A val:[wheres objectAtIndex:0]];
    [sysDao updateKeyValues:CUR_S108_SITE_B val:[wheres objectAtIndex:1]];
    [sysDao updateKeyValues:CUR_S108_SITE_C val:[wheres objectAtIndex:2]];
}

- (void) onSearchBtnClick:(id) sender {
    
    [self.window endEditing:YES];

    [popView hidden];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BaseSitePerfmController.loadReports" object:nil];
}

- (NSArray*) getSearchWhere {
    NSArray *wheres = [NSArray arrayWithObjects:siteAText.text, curSiteB, siteCText.text, nil];
    return wheres;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    [self.window endEditing:YES];
}

- (void)fetchS108Site {
    
    NSString *loginUserCode = [globalApp getValue:CUR_LOGIN_USER_NO];
    NSString *curMenuID = [globalApp getValue:CUR_MENU_ID];
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:loginUserCode, curMenuID, curSiteB, AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, FUNC_MENU_ID, SITE_NO, AUTH_KEY, nil];
    
    XMLHandleHelper* xmlHelper = [XMLHandleHelper sharedInstance];
    
    S108SiteWebService *service = [S108SiteWebService sharedInstance];
    MasterDataRtnVO* rtnVO;
    @try {
        rtnVO = [service exec: [xmlHelper createParamXmlStr:valArr colName:colNameArr]];
    } @catch (NSException *exp) {
        //[self displayHintInfo:@"请检查您的网络是否正常！"];
        return;
    }
    if([rtnVO ResultFlag] == 0) {
        NSArray *siteArr=[rtnVO.Data componentsSeparatedByString:@","];
        siteAText.text = [siteArr objectAtIndex:0];
        siteCText.text = [siteArr objectAtIndex:1];
    }else{
        //[self displayHintInfo:rtnVO.ResultMesg];
    }
}

@end
