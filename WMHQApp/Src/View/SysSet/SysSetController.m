//
//  SysSetViewController.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-29.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "SysSetController.h"
#import "SQLiteHelper.h"
#import "XWAlterview.h"
#import "CommConst.h"
#import "XMLHandleHelper.h"
#import "CheckVersionWebService.h"
#import "AppVersionRtnVO.h"
#import "ChangePswdController.h"

@interface SysSetController ()

@end

@implementation SysSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super showNavigationBar:@"系统设置" isLandscape:FALSE showBackBtn:TRUE];
    
    UIColor* mainColor = [UIColor colorWithRed:134.0/255 green:176.0/255 blue:216.0/255 alpha:1.0f];
    
    self.view.backgroundColor = mainColor;
    
    CGFloat btnLeft=12.0f;
    CGFloat btnWidth=0.0f;
    CGFloat btnHeight=45.0f;
    
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    btnWidth = mainSize.width - 2*btnLeft;
    
    // ===================
    UIImage *checkBtnImg=[UIImage imageNamed:@"profile_pop_button_background_top"];
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkBtn setBackgroundImage:checkBtnImg forState:UIControlStateNormal];
    [checkBtn setFrame:CGRectMake(btnLeft, 80, btnWidth, btnHeight)];
    [checkBtn addTarget:self action:@selector(checkVersion:)forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    [checkBtn setTitle:[@"新版本检测  " stringByAppendingString:app_Version] forState:UIControlStateNormal];
    checkBtn.titleLabel.font=[UIFont systemFontOfSize: 16.0];
    [checkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    checkBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    checkBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 50, 0, 0);
    
    [self.view addSubview:checkBtn];
    
    UIImageView  *checkIcon=[[UIImageView alloc] initWithFrame:CGRectMake(btnLeft + 10, 90, 25, 25)];
    [checkIcon setImage:[UIImage imageNamed:@"main_menu_check_version"]];
    [self.view addSubview:checkIcon];
    
    UIImageView  *checkArrow=[[UIImageView alloc] initWithFrame:CGRectMake(mainSize.width-btnLeft-30, 91, 14, 25)];
    [checkArrow setImage:[UIImage imageNamed:@"android_list_index"]];
    [self.view addSubview:checkArrow];
    // ===================
    
    // ===================
    UIImage *logoutBtnImg=[UIImage imageNamed:@"profile_pop_button_background_bottom"];
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutBtn setBackgroundImage:logoutBtnImg forState:UIControlStateNormal];
    [logoutBtn setFrame:CGRectMake(btnLeft, 124, btnWidth, btnHeight)];
    [logoutBtn addTarget:self action:@selector(quitCurrentAccount:)forControlEvents:UIControlEventTouchUpInside];
    
    [logoutBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
    logoutBtn.titleLabel.font=[UIFont systemFontOfSize: 16.0];
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    logoutBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    logoutBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 50, 0, 0);
    
    [self.view addSubview:logoutBtn];
    
    UIImageView  *logoutIcon=[[UIImageView alloc] initWithFrame:CGRectMake(btnLeft + 10, 134, 25, 25)];
    [logoutIcon setImage:[UIImage imageNamed:@"settings_signout_icon"]];
    [self.view addSubview:logoutIcon];
    
    UIImageView  *logoutArrow=[[UIImageView alloc] initWithFrame:CGRectMake(mainSize.width-btnLeft-30, 135, 14, 25)];
    [logoutArrow setImage:[UIImage imageNamed:@"android_list_index"]];
    [self.view addSubview:logoutArrow];
    // ===================
    
    // ===================
    /*
    UIImage *changePswdImg=[UIImage imageNamed:@"profile_pop_button_background_bottom"];
    UIButton *changePswd = [UIButton buttonWithType:UIButtonTypeCustom];
    [changePswd setBackgroundImage:changePswdImg forState:UIControlStateNormal];
    [changePswd setFrame:CGRectMake(btnLeft, 124, btnWidth, btnHeight)];
    [changePswd addTarget:self action:@selector(changePswd:)forControlEvents:UIControlEventTouchUpInside];
    
    [changePswd setTitle:@"密码变更" forState:UIControlStateNormal];
    changePswd.titleLabel.font=[UIFont systemFontOfSize: 16.0];
    [changePswd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    changePswd.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    changePswd.contentEdgeInsets=UIEdgeInsetsMake(0, 50, 0, 0);
    
    [self.view addSubview:changePswd];
    
    UIImageView  *changePswdIcon=[[UIImageView alloc] initWithFrame:CGRectMake(btnLeft + 10, 134, 25, 25)];
    [changePswdIcon setImage:[UIImage imageNamed:@"icon_login_psw"]];
    [self.view addSubview:changePswdIcon];
    
    UIImageView  *changePswdArrow=[[UIImageView alloc] initWithFrame:CGRectMake(mainSize.width-btnLeft-30, 135, 14, 25)];
    [changePswdArrow setImage:[UIImage imageNamed:@"android_list_index"]];
    [self.view addSubview:changePswdArrow];
    
    // ===================
    
    // ===================
    UIImage *logoutBtnImg=[UIImage imageNamed:@"settingButtonNormal"];
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutBtn setBackgroundImage:logoutBtnImg forState:UIControlStateNormal];
    [logoutBtn setFrame:CGRectMake(btnLeft, 190, btnWidth, btnHeight)];
    [logoutBtn addTarget:self action:@selector(quitCurrentAccount:)forControlEvents:UIControlEventTouchUpInside];
    
    [logoutBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
    logoutBtn.titleLabel.font=[UIFont systemFontOfSize: 16.0];
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    logoutBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    logoutBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 50, 0, 0);
    
    [self.view addSubview:logoutBtn];
    
    UIImageView  *logoutIcon=[[UIImageView alloc] initWithFrame:CGRectMake(btnLeft + 10, 200, 25, 25)];
    [logoutIcon setImage:[UIImage imageNamed:@"settings_signout_icon"]];
    [self.view addSubview:logoutIcon];
    
    UIImageView  *logoutArrow=[[UIImageView alloc] initWithFrame:CGRectMake(mainSize.width-btnLeft-30, 201, 14, 25)];
    [logoutArrow setImage:[UIImage imageNamed:@"android_list_index"]];
    [self.view addSubview:logoutArrow];
    // ===================
      */
}

- (void)checkVersion: (id) sender {
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
            XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"发现新版本" contentText:[@"升级内容：" stringByAppendingString:rtnVO.VerIntro] leftButtonTitle:@"确认" rightButtonTitle:@"取消"];
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

- (void)changePswd: (id) sender {
    [self.navigationController pushViewController:[[ChangePswdController alloc] init] animated:true];
}

- (void)quitCurrentAccount: (id) sender {
    
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
