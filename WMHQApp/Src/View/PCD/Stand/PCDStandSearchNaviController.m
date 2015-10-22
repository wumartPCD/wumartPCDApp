
#import "PCDStandSearchNaviController.h"
#import "CommConst.h"
#import "MenuConst.h"
#import "GlobalApp.h"
#import "PCDStandListController.h"

@implementation PCDStandSearchNaviController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    globalApp=[GlobalApp sharedInstance];
    
    naviWhere = [self getNaviWhere:TRUE];
    
    UINavigationItem *navigationItem = [super showNavigationBar:@"陈列标准查询" isLandscape:FALSE showBackBtn:TRUE];
    
    UIColor* mainColor = [UIColor colorWithRed:134.0/255 green:176.0/255 blue:216.0/255 alpha:1.0f];
    UIColor* darkColor = [UIColor colorWithRed:7.0/255 green:61.0/255 blue:48.0/255 alpha:1.0f];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldFontName = @"Avenir-Black";
    
    self.view.backgroundColor = mainColor;
    
    int sWidth = [self getScreenWidth];
    int lWidth = 70;
    int tWidth = 165;
    int xPos = (sWidth-lWidth-tWidth)/2 - 5;
    int yPos = 65;
    
    UIImage *textBgImg=[UIImage imageNamed:@"text_bg_img.png"];
    siteTmplLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, lWidth, 38)];
    siteTmplLabel.backgroundColor = [UIColor clearColor];
    siteTmplLabel.font = [UIFont fontWithName:fontName size:16.0f];
    siteTmplLabel.text=@"门店模板";
    siteTmplCbxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    siteTmplCbxBtn.tag = TAG_SITE_TMPL;
    [siteTmplCbxBtn setBackgroundImage:textBgImg forState:UIControlStateNormal];
    [siteTmplCbxBtn setFrame:CGRectMake(xPos+lWidth, yPos, tWidth, 38)];
    [siteTmplCbxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [siteTmplCbxBtn.titleLabel setFont:[UIFont fontWithName:fontName size:15.0f]];
    siteTmplCbxBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    siteTmplCbxBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
    [siteTmplCbxBtn addTarget:self action:@selector(onComboBoxBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    yPos=yPos+46;
    
    merchCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, lWidth, 38)];
    merchCodeLabel.backgroundColor = [UIColor clearColor];
    merchCodeLabel.font = [UIFont fontWithName:fontName size:16.0f];
    merchCodeLabel.text=@"商品编码";
    merchCodeText = [[UITextField alloc] initWithFrame:CGRectMake(xPos+lWidth, yPos, tWidth, 38)];
    merchCodeText.backgroundColor = [UIColor whiteColor];
    merchCodeText.layer.cornerRadius = 3.0f;
    merchCodeText.font = [UIFont fontWithName:fontName size:16.0f];
    merchCodeText.keyboardType= UIKeyboardTypeNumberPad;
    merchCodeText.clearButtonMode = UITextFieldViewModeAlways;
    yPos=yPos+46;
    
    operLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, lWidth, 38)];
    operLabel.backgroundColor = [UIColor clearColor];
    operLabel.font = [UIFont fontWithName:fontName size:16.0f];
    operLabel.text=@"营运课组";
    operCbxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    operCbxBtn.tag = TAG_OPER;
    [operCbxBtn setBackgroundImage:textBgImg forState:UIControlStateNormal];
    [operCbxBtn setFrame:CGRectMake(xPos+lWidth, yPos, tWidth, 38)];
    [operCbxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [operCbxBtn.titleLabel setFont:[UIFont fontWithName:fontName size:15.0f]];
    operCbxBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    operCbxBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
    [operCbxBtn addTarget:self action:@selector(onComboBoxBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    yPos=yPos+46;
    
    aktnrLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, lWidth, 38)];
    aktnrLabel.backgroundColor = [UIColor clearColor];
    aktnrLabel.font = [UIFont fontWithName:fontName size:16.0f];
    aktnrLabel.text=@"档       期";
    aktnrCbxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    aktnrCbxBtn.tag = TAG_AKTNR;
    [aktnrCbxBtn setBackgroundImage:textBgImg forState:UIControlStateNormal];
    [aktnrCbxBtn setFrame:CGRectMake(xPos+lWidth, yPos, tWidth, 38)];
    [aktnrCbxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aktnrCbxBtn.titleLabel setFont:[UIFont fontWithName:fontName size:15.0f]];
    aktnrCbxBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    aktnrCbxBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
    [aktnrCbxBtn addTarget:self action:@selector(onComboBoxBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    yPos=yPos+46;
    
    puunitLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, lWidth, 38)];
    puunitLabel.backgroundColor = [UIColor clearColor];
    puunitLabel.font = [UIFont fontWithName:fontName size:16.0f];
    puunitLabel.text=@"U        课";
    puunitCbxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    puunitCbxBtn.tag = TAG_PUUNIT;
    [puunitCbxBtn setBackgroundImage:textBgImg forState:UIControlStateNormal];
    [puunitCbxBtn setFrame:CGRectMake(xPos+lWidth, yPos, tWidth, 38)];
    [puunitCbxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [puunitCbxBtn.titleLabel setFont:[UIFont fontWithName:fontName size:15.0f]];
    puunitCbxBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    puunitCbxBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
    [puunitCbxBtn addTarget:self action:@selector(onComboBoxBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    yPos=yPos+46;
    
    themeLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, lWidth, 38)];
    themeLabel.backgroundColor = [UIColor clearColor];
    themeLabel.font = [UIFont fontWithName:fontName size:16.0f];
    themeLabel.text=@"主       题";
    themeCbxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    themeCbxBtn.tag = TAG_THEME;
    [themeCbxBtn setBackgroundImage:textBgImg forState:UIControlStateNormal];
    [themeCbxBtn setFrame:CGRectMake(xPos+lWidth, yPos, tWidth, 38)];
    [themeCbxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [themeCbxBtn.titleLabel setFont:[UIFont fontWithName:fontName size:15.0f]];
    themeCbxBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    themeCbxBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
    [themeCbxBtn addTarget:self action:@selector(onComboBoxBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    yPos=yPos+46;
    
    pcdTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, lWidth, 38)];
    pcdTypeLabel.backgroundColor = [UIColor clearColor];
    pcdTypeLabel.font = [UIFont fontWithName:fontName size:16.0f];
    pcdTypeLabel.text=@"促销资源";
    pcdTypeCbxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pcdTypeCbxBtn.tag = TAG_PCDTYPE;
    [pcdTypeCbxBtn setBackgroundImage:textBgImg forState:UIControlStateNormal];
    [pcdTypeCbxBtn setFrame:CGRectMake(xPos+lWidth, yPos, tWidth, 38)];
    [pcdTypeCbxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pcdTypeCbxBtn.titleLabel setFont:[UIFont fontWithName:fontName size:15.0f]];
    pcdTypeCbxBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    pcdTypeCbxBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
    [pcdTypeCbxBtn addTarget:self action:@selector(onComboBoxBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    yPos=yPos+46;
    
    UIImage *launcherImage=[UIImage imageNamed:@"btn_title_ok"];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:launcherImage forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake([self getScreenWidth]-55, 0, 48, 38)];
    [rightBtn addTarget:self action:@selector(onOKBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *showLauncher = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    navigationItem.rightBarButtonItem = showLauncher;
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view  addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    
    [self.view  addSubview:siteTmplLabel];
    [self.view  addSubview:siteTmplCbxBtn];
    
    [self.view  addSubview:merchCodeLabel];
    [self.view  addSubview:merchCodeText];
    
    [self.view  addSubview:operLabel];
    [self.view  addSubview:operCbxBtn];
    
    [self.view  addSubview:aktnrLabel];
    [self.view  addSubview:aktnrCbxBtn];
    
    [self.view  addSubview:puunitLabel];
    [self.view  addSubview:puunitCbxBtn];
    
    [self.view  addSubview:themeLabel];
    [self.view  addSubview:themeCbxBtn];
    
    [self.view  addSubview:pcdTypeLabel];
    [self.view  addSubview:pcdTypeCbxBtn];
    
    [self searchNaviWhere:TRUE funcNo:[globalApp getValue:CUR_SUPER_MENU_ID]];
    
    [self initInputValue];
}

-(void)initInputValue {
    
    [siteTmplCbxBtn setTitle:naviWhere.SiteTmplList[0] forState:UIControlStateNormal];
    merchCodeText.text = @"";
    [operCbxBtn setTitle:@"" forState:UIControlStateNormal];
    [aktnrCbxBtn setTitle:@"" forState:UIControlStateNormal];
    [puunitCbxBtn setTitle:@"" forState:UIControlStateNormal];
    [themeCbxBtn setTitle:@"" forState:UIControlStateNormal];
    [pcdTypeCbxBtn setTitle:@"" forState:UIControlStateNormal];
}

-(void)fetchInputValue {
    
    naviWhere.CurSiteTmpl = [naviWhere getWhere: siteTmplCbxBtn.currentTitle];
    naviWhere.CurMerchCode = merchCodeText.text;
    naviWhere.CurOper = [naviWhere getWhere: operCbxBtn.currentTitle];
    naviWhere.CurAktnr = [naviWhere getWhere: aktnrCbxBtn.currentTitle];
    naviWhere.CurPuunit = [naviWhere getWhere: puunitCbxBtn.currentTitle];
    naviWhere.CurTheme = [naviWhere getWhere: themeCbxBtn.currentTitle];
    naviWhere.CurPcdType = [naviWhere getWhere: pcdTypeCbxBtn.currentTitle];
    
    CommPcdNaviWhere *where = [naviWhere cloneWhere];
    [globalApp putValue:CUR_PCD_LIST_SEARCHING_WHERE value:where];
}

- (void) onOKBtnClick:(id)sender{
    [self fetchInputValue];
    
    PcdStandListRtnVO * rtnListVo = [self commSearchPcdStand:TRUE];
    if (rtnListVo != Nil) {
        PCDStandListController *listCtrl = [[PCDStandListController alloc] init];
        listCtrl.StandList = rtnListVo;
        [self.navigationController pushViewController:listCtrl animated:true];
    }
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    [self.view.window endEditing:YES];
}

@end
