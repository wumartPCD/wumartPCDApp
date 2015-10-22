//
//  YSHYImagePickerController.m
//  WMPCDApp
//
//  Created by 杨淑园 on 15/9/23.
//  Copyright © 2015年 yangshuyuan. All rights reserved.
//

#import "PCDStandPromoController.h"
#import "YSHYAlertView.h"
#import "UIView+Frame.h"
#import "XMLHandleHelper.h"
#import "MBProgressHUD.h"
#import "GlobalUtil.h"
#import "LoadPcdStandWebService.h"
#import "EnumConst.h"
#import "PcdStandRtnVO.h"
#import "MerchListViewCell.h"
#import "PCDStandImgViewController.h"
#import "MerchListViewCell.h"

@interface PCDStandPromoController ()

@end

@implementation PCDStandPromoController

@synthesize naviWhere;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    globalApp=[GlobalApp sharedInstance];
    
    UINavigationItem *navigationItem = [super showNavigationBar:@"陈列标准详细" isLandscape:FALSE showBackBtn:TRUE];
    
    UIImage *launcherImage=[UIImage imageNamed:@"btn_title_search"];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:launcherImage forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake([self getScreenWidth]-55, 0, 48, 38)];
    [rightBtn addTarget:self action:@selector(onBackBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *showLauncher = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    navigationItem.rightBarButtonItem = showLauncher;
    
    [self loadDetailView];
    
    [self createTopFuncBar];
    [self showTopFuncBar];
    [self createImgGridView];
    [self createBottomFuncBar];
    [self createMerchListView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void) createTopFuncBar
{
    CGFloat top = 50 +3;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 50, [self getScreenWidth], 42)];
    view.backgroundColor = RGB_COLOR(BtnBarColor);
    NSString* fontName = @"Avenir-Black";
    
    puunitThemeLbl = [[UILabel alloc] initWithFrame:CGRectMake(2, top, 75, 36)];
    puunitThemeLbl.backgroundColor = RGB_COLOR(LabelColor);
    puunitThemeLbl.font = [UIFont fontWithName:fontName size:13.0f];
    puunitThemeLbl.textColor=[UIColor whiteColor];
    [self.view addSubview: puunitThemeLbl];
    
    pcdNumLbl = [[UILabel alloc] initWithFrame:CGRectMake(79, top, 50, 36)];
    pcdNumLbl.backgroundColor = RGB_COLOR(LabelColor);
    pcdNumLbl.font = [UIFont fontWithName:fontName size:13.0f];
    pcdNumLbl.textColor=[UIColor whiteColor];
    [self.view addSubview: pcdNumLbl];
    
    int pcdNoWidth = [self getScreenWidth] - 131 - 106 - 2;
    UIImage *textBgImg=[UIImage imageNamed:@"text_bg_img.png"];
    pcdNoCbxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pcdNoCbxBtn.tag = TAG_SITE_TMPL;
    [pcdNoCbxBtn setBackgroundImage:textBgImg forState:UIControlStateNormal];
    [pcdNoCbxBtn setFrame:CGRectMake(131, top, pcdNoWidth, 36)];
    [pcdNoCbxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pcdNoCbxBtn.titleLabel setFont:[UIFont fontWithName:fontName size:14.0f]];
    pcdNoCbxBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    pcdNoCbxBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
    [pcdNoCbxBtn addTarget:self action:@selector(onComboBoxBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: pcdNoCbxBtn];
    
    //if(self.IsReadonly == READ_ONLY_FALSE)
    {
        addStandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addStandBtn setFrame:CGRectMake([self getScreenWidth]-106, top, 50, 36)];
        [addStandBtn addTarget:self action:@selector(selectedAddBtn:) forControlEvents:UIControlEventTouchUpInside];
        [addStandBtn setTitle:@"增加" forState:UIControlStateNormal];
        [addStandBtn setBackgroundColor:RGB_COLOR(ButtonColor)];
        [addStandBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addStandBtn.layer.cornerRadius = 5;
        [self.view addSubview:addStandBtn];
        
        delStandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [delStandBtn setFrame:CGRectMake([self getScreenWidth]-54, top, 50, 36)];
        [delStandBtn setTitle:@"删除" forState:UIControlStateNormal];
        [delStandBtn addTarget:self action:@selector(selectedDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [delStandBtn setBackgroundColor:RGB_COLOR(ButtonColor)];
        [delStandBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        delStandBtn.layer.cornerRadius = 5;
        [self.view addSubview:delStandBtn];
    }
//    [self.view addSubview:view];
}

-(void) showTopFuncBar
{
    puunitThemeLbl.text = [[naviWhere getPuunitName:naviWhere.CurPuunit] stringByAppendingString:[naviWhere getThemeName:naviWhere.CurTheme]];
    pcdNumLbl.text = [naviWhere getPcdNumName:naviWhere.CurPcdNum];
    
    if (naviWhere.PcdNoList.count>0) {
        [pcdNoCbxBtn setTitle:naviWhere.PcdNoList[0] forState:UIControlStateNormal];
    }
}

- (void) createImgGridView {
    
    CGRect bounds = CGRectMake(0, 92, [self getScreenWidth], [self getScreenHeight]);
    
    PCDStandImgViewController *imgCtrl = [[PCDStandImgViewController alloc] init];
    imgCtrl.arrayOK = naviWhere.ImgInfoList;
    NSMutableArray *itemArr = [NSMutableArray array];
    NSArray *imgArr;
    for (NSString *url in naviWhere.ImgInfoList)
    {
        imgArr = [url componentsSeparatedByString:@"-"];
        [itemArr addObject: [GridMenuItemView initWithTitle:imgArr[0] title:Nil imgName: [PCD_IMG_URL stringByAppendingString:imgArr[1]] uiCtrl:imgCtrl]];
    }
    
    if(gridMenuView==Nil){
        gridMenuView = [GridMenuView initWithTitle:bounds items:itemArr fontSize:14
                                            colNum:(naviWhere.ImgInfoList.count>=2 ? 2 : 1) homeCtrler:self];
        [self.view addSubview:gridMenuView];
    }
}

-(void) createBottomFuncBar
{
    //if(self.IsReadonly == READ_ONLY_TRUE)
    //    {
    //        return;
    //    }
    
    int merchRow = naviWhere.MerchList.count;
    int posY = [self getScreenHeight] - (merchRow+1)*25 - 42;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, posY, [self getScreenWidth], 42)];
    view.backgroundColor = RGB_COLOR(BtnBarColor);
    
    addImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addImgBtn setFrame:CGRectMake(2, 3, 50, 36)];
    //[addImgBtn addTarget:self action:@selector(selectedAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [addImgBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [addImgBtn setBackgroundColor:RGB_COLOR(ButtonColor)];
    [addImgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addImgBtn.layer.cornerRadius = 5;
    [view addSubview:addImgBtn];
    
    uploadImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [uploadImgBtn setFrame:CGRectMake(54, 3, 75, 36)];
    [uploadImgBtn setTitle:@"图片上传" forState:UIControlStateNormal];
    [uploadImgBtn addTarget:self action:@selector(selectedDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [uploadImgBtn setBackgroundColor:RGB_COLOR(ButtonColor)];
    [uploadImgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    uploadImgBtn.layer.cornerRadius = 5;
    [view addSubview:uploadImgBtn];
    
    addMerchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addMerchBtn setFrame:CGRectMake([self getScreenWidth]-156, 3, 75, 36)];
    [addMerchBtn addTarget:self action:@selector(selectedAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [addMerchBtn setTitle:@"录入商品" forState:UIControlStateNormal];
    [addMerchBtn setBackgroundColor:RGB_COLOR(ButtonColor)];
    [addMerchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addMerchBtn.layer.cornerRadius = 5;
    [view addSubview:addMerchBtn];
    
    scanMerchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanMerchBtn setFrame:CGRectMake([self getScreenWidth]-79, 3, 75, 36)];
    [scanMerchBtn setTitle:@"商品扫码" forState:UIControlStateNormal];
    [scanMerchBtn addTarget:self action:@selector(selectedDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scanMerchBtn setBackgroundColor:RGB_COLOR(ButtonColor)];
    [scanMerchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    scanMerchBtn.layer.cornerRadius = 5;
    [view addSubview:scanMerchBtn];
    
    [self.view addSubview:view];
}

-(void) createMerchListView
{
    int merchHeight = (naviWhere.MerchList.count+1) * 25;
    merchListView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getScreenHeight]-merchHeight, [self getScreenWidth], merchHeight)];
    merchListView.delegate = self;
    merchListView.dataSource = self;
    [self.view addSubview:merchListView];
}

- (void) onComboBoxBtnClick:(id) sender {
    UIView *superView = [pcdNoCbxBtn superview];
    
    if(pcdNoCbxList == Nil) {
        NSArray *dataArr = naviWhere.PcdNoList;
        
        NSUInteger len =dataArr.count;
        CGFloat f = (len>3?3:len)*39;
        
        pcdNoCbxList = [[ComboBoxList alloc]showDropDown:sender :&f :dataArr :Nil :@"down"];
        pcdNoCbxList.delegate = self;
        
        [pcdNoCbxList bringSubviewToFront:gridMenuView];

    } else {
        [pcdNoCbxList hideDropDown:pcdNoCbxBtn.frame];
        pcdNoCbxList=Nil;
    }
}

- (void) onComboBoxListSelect:(id)sender index:(int)index {
    pcdNoCbxList=Nil;
}

#pragma  mark - 设置商品表信息
-(void)loadDetailView
{
    NSString *loginUserCode= [globalApp getValue:CUR_LOGIN_USER_NO];
    NSString *funcNo= [globalApp getValue:CUR_SUPER_MENU_ID];
    
    @try {
        NSArray* valArr = [[NSArray alloc] initWithObjects:loginUserCode, funcNo, self.StandNo, AUTH_KEY_VAL, nil];
        NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, FUNC_MENU_ID, STAND_NO, AUTH_KEY, nil];
        
        XMLHandleHelper *xmlHelper = [XMLHandleHelper sharedInstance];
        
        LoadPcdStandWebService *service = [LoadPcdStandWebService sharedInstance];
        
        PcdStandRtnVO *rtnVO = [service exec:[xmlHelper createParamXmlStr:valArr colName:colNameArr]];
        
        if (rtnVO.ResultFlag == 0) {
            naviWhere.CurStandNo = rtnVO.StandNo;
            naviWhere.CurPuunit = rtnVO.Puunit;
            naviWhere.CurTheme = rtnVO.Theme;
            naviWhere.CurPcdNum = rtnVO.PcdNum;
            naviWhere.PcdNoList = rtnVO.PcdNoList;
            naviWhere.ImgInfoList = rtnVO.ImgInfoList;
            naviWhere.MerchList = rtnVO.MerchList;
        } else if (rtnVO.ResultFlag == 6) {
            [naviWhere reInit];
            [self displayHintInfo:rtnVO.ResultMesg];
        } else {
            [self displayHintInfo:rtnVO.ResultMesg];
        }
    } @catch (NSException *exp) {
        [self displayHintInfo:[exp reason]];
    }
}

#pragma  maek - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return naviWhere.MerchList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellId";
    MerchListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[MerchListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell loadData:naviWhere.MerchList[indexPath.row] index:indexPath.row sWidth:[self getScreenWidth]];
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 50;
    }else{
        return 25;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    int i=0;
}

/*
 ////点击查询按钮
 //-(void)SelectedRightBtn:(UIButton *)button
 //{
 //    NSLog(@"点击查询按钮");
 //    [self.navigationController popViewControllerAnimated:YES];
 //}
 ////添加
 //-(void)selectedAddBtn:(UIButton *)button
 //{
 //    NSLog(@"点击添加按钮");
 //    YSHYAlertView * alertView = [[YSHYAlertView alloc]initWithFrame:CGRectMake(0 , 100, KSCREEN_WIDTH, 100)];
 //    [alertView setCenter:self.view.center];
 //    alertView.delegate = self;
 //    alertView.type = AlertViewTypeTextFiledAndComboBox;
 //    [alertView setTitle:@"陈列标准录入"];
 //    [alertView CreatViewWithLableName:@"陈列编号" placeholderText:[NSString stringWithFormat:@"%.2d",[_itemsArray.lastObject intValue]+1]];
 //    [alertView CreatViewWithLableName:@"品项数" Array:@[@"1-一品堆",@"2-二品堆",@"3-多品堆"]];;
 //    [alertView CreatButton];
 //    [self.view addSubview:alertView];
 //    [alertView show];
 //
 //}
 
 
 #pragma mark - 点击删除按钮
 -(void)selectedDeleteBtn:(UIButton *)button
 {
 //    NSLog(@"点击删除按钮");
 //
 //    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
 //    [hud setLabelText:@"正在删除"];
 //    [self.view addSubview:hud];
 //
 //    dispatch_async(dispatch_get_main_queue(), ^{
 //        [hud show:YES];
 //    });
 //
 //    NSArray* valArr = [[NSArray alloc] initWithObjects:@"test", @"100",_detailsInfo.StandNo,@"WMHQApp", nil];
 //    NSArray* colNameArr = [[NSArray alloc] initWithObjects:@"CurLoginUserNo", @"FuncMenuID",@"StandNo", @"AuthKey", nil];
 //    NSDictionary * para = @{@"valArr":valArr,@"colNameArr":colNameArr};
 //    [ServiceManager DeleteScheduInfoWithPara:para ResponseHandler:^(id data) {
 //        BaseRtnVO * rtnVO = (BaseRtnVO *)data;
 //        if(data)
 //        {//操作成功
 //            dispatch_async(dispatch_get_main_queue(), ^{
 //                [hud hide:YES];
 //                [self.navigationController popViewControllerAnimated:YES];
 //            });
 //        }
 //        else
 //        {
 //            dispatch_async(dispatch_get_main_queue(), ^{
 //                [hud hide:YES];
 //                [self.view makeToast:rtnVO.ResultMesg duration:2.0 position:nil];
 //            });
 //        }
 //
 //    } errorHandler:^(NSException *exception) {
 //        dispatch_async(dispatch_get_main_queue(), ^{
 //            [hud hide:YES];
 //            [self.view makeToast:exception.description duration:2.0 position:nil];
 //
 //        });
 //
 //    }];
 }
 
 #pragma mark -UIImagePickerControllerDelegate
 //拍照完成 点击上传按钮
 //-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
 //{
 //    //获取图片信息
 //    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
 //    //保存图片
 //    UIImage * tempImage= [self saveImage:image withName:@"test.png"];
 //    [picker dismissViewControllerAnimated:YES completion:^{
 //        //上传图片
 //        [GlobalUtil upLoadImages:@[tempImage]];
 //
 //    }];
 //}
 
 //下面三个方法 用于修改系统相机按钮的title
 //-(UIView *)findView:(UIView *)aView withName:(NSString *)name{
 //    Class cl = [aView class];
 //    NSString *desc = [cl description];
 //    if ([name isEqualToString:desc])
 //        return aView;
 //    for (UIView *view in aView.subviews) {
 //        Class cll = [view class];
 //        NSString *stringl = [cll description];
 //        if ([stringl isEqualToString:name]) {
 //            return view;
 //        }
 //    }
 //    return nil;
 //}
 //
 //-(void)addSomeElements:(UIViewController *)viewController{
 //    UIView *PLCameraView = [self findView:viewController.view withName:@"PLCameraView"];
 //    UIView *PLCropOverlay = [self findView:PLCameraView withName:@"PLCropOverlay"];
 //    UIView *bottomBar = [self findView:PLCropOverlay withName:@"PLCropOverlayBottomBar"];
 //    UIImageView *bottomBarImageForSave = [bottomBar.subviews objectAtIndex:0];
 //
 //    UIButton *retakeButton=[bottomBarImageForSave.subviews objectAtIndex:0];
 //    [retakeButton setTitle:@"重拍"  forState:UIControlStateNormal];
 //    UIButton *useButton=[bottomBarImageForSave.subviews objectAtIndex:1];
 //    [useButton setTitle:@"上传" forState:UIControlStateNormal];
 //}
 //
 //- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
 //{
 //    [self addSomeElements:viewController];
 //}
 */

@end
