//
//  FeedbackController.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-16.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "FeedbackController.h"
#import "CommConst.h"
#import "XMLHandleHelper.h"
#import "FeedbackWebService.h"
#import "BaseRtnVO.h"
#import "GlobalApp.h"

@interface FeedbackController ()

@end

@implementation FeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super showNavigationBar:@"意见反馈" isLandscape:FALSE showBackBtn:true];
    
    UIColor* mainColor = [UIColor colorWithRed:134.0/255 green:176.0/255 blue:216.0/255 alpha:1.0f];
    UIColor* darkColor = [UIColor colorWithRed:7.0/255 green:61.0/255 blue:48.0/255 alpha:1.0f];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldFontName = @"Avenir-Black";
    
    self.view.backgroundColor = mainColor;
    
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    
    feedbackView = [[UITextView alloc] init];
    feedbackView.frame = CGRectMake(5,55,mainSize.width-10,160); // 设置位置
    feedbackView.backgroundColor = [UIColor whiteColor]; // 设置背景色
    feedbackView.alpha = 1.0; // 设置透明度
    feedbackView.textAlignment = NSTextAlignmentLeft; // 设置字体对其方式
    feedbackView.font = [UIFont fontWithName:fontName size:20.0f]; // 设置字体大小
    [feedbackView setEditable:YES]; // 设置时候可以编辑
    feedbackView.dataDetectorTypes = UIDataDetectorTypeAll; // 显示数据类型的连接模式（如电话号码、网址、地址等）
    feedbackView.keyboardType = UIKeyboardTypeDefault; // 设置弹出键盘的类型
    feedbackView.returnKeyType = UIReturnKeySearch; // 设置键盘上returen键的类型
    feedbackView.scrollEnabled = YES; // 当文字宽度超过UITextView的宽度时，是否允许滑动
    
    submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 225, mainSize.width-10, 45)];
    submitBtn.backgroundColor = darkColor;
    submitBtn.layer.cornerRadius = 3.0f;
    submitBtn.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [submitBtn setTitle:@"提  交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    [submitBtn addTarget:self action:@selector(doSubmit:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:feedbackView];
    [self.view addSubview:submitBtn];
}

- (void) doSubmit:(id) sender {
    [feedbackView resignFirstResponder];
    
    NSArray* valArr = [[NSArray alloc] initWithObjects:[[GlobalApp sharedInstance] getValue:CUR_LOGIN_USER_NO], feedbackView.text, AUTH_KEY_VAL, nil];
    NSArray* colNameArr = [[NSArray alloc] initWithObjects:CUR_LOGIN_USER_NO, CONTENT, AUTH_KEY, nil];
    
    XMLHandleHelper *xmlHelper = [XMLHandleHelper sharedInstance];
    
    FeedbackWebService *service = [FeedbackWebService sharedInstance];
    BaseRtnVO *rtnUser = [service exec:[xmlHelper createParamXmlStr:valArr colName:colNameArr]];
    
    if(rtnUser.ResultFlag == 0){
        [self displayHintInfo: @"提交成功，感谢您的宝贵建议！"];
    }else{
        [self displayHintInfo:rtnUser.ResultMesg];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [feedbackView resignFirstResponder];
}

-(void)autoResizeView{
    [super autoResizeView];
    
    [feedbackView setFrame:CGRectMake(5,55,[self getScreenWidth]-10,160)];
    
    [submitBtn setFrame:CGRectMake(5, 225, [self getScreenWidth]-10, 45)];
}

@end
