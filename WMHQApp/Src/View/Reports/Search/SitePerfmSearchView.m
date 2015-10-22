
#import "SitePerfmSearchView.h"
#import "CommConst.h"
#import "XMLHandleHelper.h"
#import "SiteDeptWebService.h"
#import "MasterDataRtnVO.h"

@interface SitePerfmSearchView()

@end

@implementation SitePerfmSearchView

@synthesize popView;

+ (id)initView:(CGRect)bounds superFrame:(CGRect)superFrame {
    SitePerfmSearchView *instance = [[SitePerfmSearchView alloc] initViewWithBounds:bounds superFrame:superFrame];
    
    return instance;
}

- (id)initViewWithBounds:(CGRect)bounds superFrame:(CGRect)superFrame {
    
    self = [super initWithFrame:superFrame];
    if (self) {
        globalApp=[GlobalApp sharedInstance];
        SiteDeptSearchWhere *siteWhere = [globalApp getValue:CUR_SITE_DEPT_WHERE];
        searchWhere = [[SiteDeptSearchWhere alloc] init];
        searchWhere.SiteList = siteWhere.SiteList;
        searchWhere.CurSiteNo = siteWhere.CurSiteNo;
        
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
        
        siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, 70, 38)];
        siteLabel.backgroundColor = [UIColor clearColor];
        siteLabel.font = [UIFont fontWithName:fontName size:16.0f];
        siteLabel.text=@"门店号：";
        
        UIImage *textBgImg=[UIImage imageNamed:@"text_bg_img.png"];
        siteComboxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [siteComboxBtn setBackgroundImage:textBgImg forState:UIControlStateNormal];
        [siteComboxBtn setFrame:CGRectMake(xPos+70, yPos, 165, 38)];
        [siteComboxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [siteComboxBtn.titleLabel setFont:[UIFont fontWithName:fontName size:15.0f]];
        siteComboxBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        siteComboxBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
        [siteComboxBtn addTarget:self action:@selector(onSiteComboBoxBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        
        deptLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos+46, 70, 38)];
        deptLabel.backgroundColor = [UIColor clearColor];
        deptLabel.font = [UIFont fontWithName:fontName size:16.0f];
        deptLabel.text=@"营运课：";
        
        deptComboxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deptComboxBtn setBackgroundImage:textBgImg forState:UIControlStateNormal];
        [deptComboxBtn setFrame:CGRectMake(xPos+70, yPos+46, 165, 38)];
        [deptComboxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [deptComboxBtn.titleLabel setFont:[UIFont fontWithName:fontName size:15.0f]];
        deptComboxBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        deptComboxBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
        [deptComboxBtn addTarget:self action:@selector(onDeptComboBoxBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        
        cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(xPos, 96+yPos, width/2-45, 45)];
        cancelBtn.backgroundColor = darkColor;
        cancelBtn.layer.cornerRadius = 3.0f;
        cancelBtn.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
        [cancelBtn setTitle:@"取  消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(onCancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(bounds.origin.x+width/2+15, 96+yPos, width/2-45, 45)];
        searchBtn.backgroundColor = darkColor;
        searchBtn.layer.cornerRadius = 3.0f;
        searchBtn.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
        [searchBtn setTitle:@"查  询" forState:UIControlStateNormal];
        [searchBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
        [searchBtn addTarget:self action:@selector(onSearchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:searchView];
        
        [self addSubview:siteLabel];
        [self addSubview:siteComboxBtn];
        
        [self addSubview:deptLabel];
        [self addSubview:deptComboxBtn];
        
        [self addSubview:cancelBtn];
        [self addSubview:searchBtn];
    }
    return self;
}

- (void) resetCombobox {
    
    NSString *curSite=[searchWhere getSiteInfo:searchWhere.CurSiteNo];
    [siteComboxBtn setTitle:curSite forState:UIControlStateNormal];
    
    NSString *curDept=[searchWhere getDeptName:searchWhere.CurSiteDept];
    [deptComboxBtn setTitle:curDept forState:UIControlStateNormal];
}

- (void) refreshWhere {
    if (searchWhere.CurSiteDept == Nil) {
        [self fetchSiteDeptList];
    }
}

- (SiteDeptSearchWhere *) getSearchWhere {
    return searchWhere;
}

- (void) setPreSiteDept:(NSString *)siteDept {
    searchWhere.PreSiteDept=siteDept;
}

- (void) setDataType:(NSString *)dataType {
    searchWhere.DataType=dataType;
}

- (void) onSiteComboBoxBtnClick:(id) sender {
    if(siteComboxList == Nil) {
        NSArray *dataArr = searchWhere.SiteList;
        NSUInteger len =dataArr.count;
        CGFloat f = (len>3?3:len)*39;
        
        siteComboxList = [[ComboBoxList alloc]showDropDown:sender :&f :dataArr :Nil :@"down"];
        siteComboxList.delegate = self;
    } else {
        [siteComboxList hideDropDown:((UIButton *)sender).frame];
        siteComboxList=Nil;
    }
}

- (void) onDeptComboBoxBtnClick:(id) sender {
    if(deptComboxList == Nil) {
        NSArray *dataArr = [searchWhere getDeptNameList];
        NSUInteger len =dataArr.count;
        CGFloat f = (len>3?3:len)*39;
        
        deptComboxList = [[ComboBoxList alloc]showDropDown:sender :&f :dataArr :Nil :@"down"];
        deptComboxList.delegate = self;
    }
    else {
        [deptComboxList hideDropDown:((UIButton *)sender).frame];
        deptComboxList=Nil;
    }
}

- (void) onCancelBtnClick:(id) sender {
    [popView hidden];
}

- (void) onSearchBtnClick:(id) sender {
    [popView hidden];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BaseSitePerfmController.loadReports" object:nil];
}

- (void) onComboBoxListSelect:(id)sender index:(int)index {
    
    if (sender == deptComboxBtn) {
        deptComboxList=Nil;
        
        NSArray *depts = [[searchWhere.SiteDeptList objectAtIndex:index] componentsSeparatedByString:@"_"];
        searchWhere.CurSiteDept = [depts objectAtIndex:0];
    } else if (sender == siteComboxBtn) {
        siteComboxList=Nil;
        
        NSArray *sites = [siteComboxBtn.currentTitle componentsSeparatedByString:@"-"];
        searchWhere.CurSiteNo = [sites objectAtIndex:0];
        
        [self fetchSiteDeptList];
    }
}

- (void)fetchSiteDeptList {
    
    NSString *loginUserCode = [globalApp getValue:CUR_LOGIN_USER_NO];
    NSString *curMenuID = [globalApp getValue:CUR_MENU_ID];
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:loginUserCode, curMenuID, searchWhere.CurSiteNo, searchWhere.DataType, AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, FUNC_MENU_ID, SITE_NO, DATA_TYPE, AUTH_KEY, nil];
    
    XMLHandleHelper* xmlHelper = [XMLHandleHelper sharedInstance];
    
    SiteDeptWebService *service = [SiteDeptWebService sharedInstance];
    MasterDataRtnVO* rtnVO;
    @try {
        rtnVO = [service exec: [xmlHelper createParamXmlStr:valArr colName:colNameArr]];
    } @catch (NSException *exp) {
        //[self displayHintInfo:@"请检查您的网络是否正常！"];
        return;
    }
    if([rtnVO ResultFlag] == 0) {
        [searchWhere fetchSiteDept:rtnVO];
        NSString *curDept=[searchWhere getDeptName:searchWhere.CurSiteDept];
        [deptComboxBtn setTitle:curDept forState:UIControlStateNormal];
    }else{
        //[self displayHintInfo:rtnVO.ResultMesg];
    }
}

@end
