
#import "BasePCDStandNaviController.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "PcdNaviRtnVO.h"
#import "GlobalApp.h"
#import "SearchPcdNaviWebService.h"
#import "SearchPcdStandWebService.h"
#import "XMLHandleHelper.h"
#import "NetworkHelper.h"

@implementation BasePCDStandNaviController

- (id) init {
    self = [super init];
    if (self) {
        curPageNo=1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    globalApp=[GlobalApp sharedInstance];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) onComboBoxBtnClick:(id) sender {
//    UIButton *tempBtn = (UIButton *)sender;
    curBtnTag = ((UIButton *)sender).tag;
    if(commCbxList == Nil) {
        NSArray *dataArr;
        if (curBtnTag == TAG_SITE_TMPL) {
            dataArr = naviWhere.SiteTmplList;
        }else if (curBtnTag == TAG_OPER) {
            dataArr = naviWhere.OperList;
        }else if (curBtnTag == TAG_AKTNR) {
            dataArr = naviWhere.AktnrList;
        }else if (curBtnTag == TAG_PUUNIT) {
            dataArr = naviWhere.PuunitList;
        }else if (curBtnTag == TAG_THEME) {
            dataArr = naviWhere.ThemeList;
        }else if (curBtnTag == TAG_PCDTYPE) {
            dataArr = naviWhere.PcdTypeList;
        }else{
        }
        
        NSUInteger len =dataArr.count;
        CGFloat f = (len>3?3:len)*39;
        
        commCbxList = [[ComboBoxList alloc]showDropDown:sender :&f :dataArr :Nil :@"down"];
        commCbxList.delegate = self;
    } else {
        [commCbxList hideDropDown:((UIButton *)sender).frame];
        commCbxList=Nil;
    }
}

- (void) onComboBoxListSelect:(id)sender index:(int)index {
    commCbxList=Nil;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    [self.view.window endEditing:YES];
    if (commCbxList != Nil) {
        [commCbxList hideDropDown:CGRectMake(0, 0, 0, 0)];
        commCbxList=Nil;
    }
}

-(CommPcdNaviWhere *)getNaviWhere:(BOOL)isFirstBlank{
    CommPcdNaviWhere *where;
    if (isFirstBlank) {
        where = [globalApp getValue:CUR_PCD_NAVI_WHERE_BLANK];
        if (where == Nil) {
            where = [[CommPcdNaviWhere alloc] initWithType:isFirstBlank];
            [globalApp putValue:CUR_PCD_NAVI_WHERE_BLANK value:where];
        }
    } else {
        where = [globalApp getValue:CUR_PCD_NAVI_WHERE_NO_BLANK];
        if (where == Nil) {
            where = [[CommPcdNaviWhere alloc] initWithType:isFirstBlank];
            [globalApp putValue:CUR_PCD_NAVI_WHERE_NO_BLANK value:where];
        }
    }
    return where;
}

- (BOOL)searchNaviWhere:(BOOL)isFirstBlank funcNo:(NSString *)funcNo {
    
    NSString *loginUserCode= [globalApp getValue:CUR_LOGIN_USER_NO];
    
    @try {
        NSArray* valArr = [[NSArray alloc] initWithObjects:loginUserCode, funcNo, (isFirstBlank ? @"1" : @"0"), AUTH_KEY_VAL, nil];
        NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, FUNC_MENU_ID, IS_FIRST_BLANK, AUTH_KEY, nil];
        
        XMLHandleHelper *xmlHelper = [XMLHandleHelper sharedInstance];
        
        SearchPcdNaviWebService *service = [SearchPcdNaviWebService sharedInstance];
        
        PcdNaviRtnVO *rtnVO = [service exec:[xmlHelper createParamXmlStr:valArr colName:colNameArr]];
        
        if(rtnVO.ResultFlag == 0){
            naviWhere.AktnrList = rtnVO.AktnrList;
            naviWhere.OperList = rtnVO.OperList;
            naviWhere.PuunitList = rtnVO.PuunitList;
            naviWhere.IsInited = TRUE;
            
            return TRUE;
        }else{
            [self displayHintInfo:rtnVO.ResultMesg];
        }
    } @catch (NSException *exp) {
        [self displayHintInfo:[exp reason]];
    }
    
    return FALSE;
}

- (PcdStandListRtnVO *) commSearchPcdStand:(BOOL)isFirstBlank {
    NSString *loginUserCode= [globalApp getValue:CUR_LOGIN_USER_NO];
    NSString *funcNo = [globalApp getValue:CUR_SUPER_MENU_ID];
    
    CommPcdNaviWhere *where = [globalApp getValue:CUR_PCD_LIST_SEARCHING_WHERE];
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:loginUserCode, funcNo,
                       [where getWhere:where.CurSiteTmpl], where.CurMerchCode, [where getWhere:where.CurOper], where.CurAktnr,
                       [where getWhere:where.CurPuunit], [where getWhere:where.CurTheme],
                       [where getWhere:where.CurPcdType], [NSString stringWithFormat:@"%d",curPageNo], AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, FUNC_MENU_ID, STAND_SITE_TMPL, MERCH_CODE,
                           STAND_OPER, STAND_AKTNR,STAND_PUUNIT, STAND_THEME, STAND_PCD_TYPE, CUR_PAGE_NO, AUTH_KEY, nil];
    
    
    @try {
        XMLHandleHelper *xmlHelper = [XMLHandleHelper sharedInstance];
        
        SearchPcdStandWebService *service = [SearchPcdStandWebService sharedInstance];
        
        PcdStandListRtnVO *rtnVO = [service exec:[xmlHelper createParamXmlStr:valArr colName:colNameArr]];
        
        if(rtnVO.ResultFlag == 0){
            return rtnVO;
        }else{
            [self displayHintInfo:rtnVO.ResultMesg];
        }
    } @catch (NSException *exp) {
        [self displayHintInfo:[exp reason]];
    }
    return Nil;
}

@end
