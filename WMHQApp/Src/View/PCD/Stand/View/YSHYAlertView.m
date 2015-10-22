//
//  YSHYAlertView.m
//  WMPCDApp
//
//  Created by 杨淑园 on 15/10/8.
//  Copyright © 2015年 yangshuyuan. All rights reserved.
//

#import "YSHYAlertView.h"
#import "UIView+Frame.h"
#import "GlobalUtil.h"

@implementation YSHYAlertView

#define RGB_COLOR(_STR_) ([UIColor colorWithRed:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(1, 2)] UTF8String], 0, 16)] intValue] / 255.0 green:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(3, 2)] UTF8String], 0, 16)] intValue] / 255.0 blue:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(5, 2)] UTF8String], 0, 16)] intValue] / 255.0 alpha:1.0])

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT)];
        [self setupBackground];
        [self setupAlertView];
    }
    return  self;
}

-(void)setTitle:(NSString *)title
{
    if(!self.titeLabel)
    {
        self.titeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH - 20, 30)];
        [self.titeLabel setTextAlignment:NSTextAlignmentCenter];
        [_alertView setSize:CGSizeMake(kSCREENWIDTH - 20, 0)];
        self.titeLabel.textColor = [UIColor whiteColor];
        [_alertView addSubview:self.titeLabel];
    }
    self.titeLabel.text = title;
    [self.titeLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0]];
    _height = _height + self.titeLabel.height;
    
}

-(void)CreatViewWithLableName:(NSString *)labelName placeholderText:(NSString *)placeholder
{
    UIView *lastView = _alertView.subviews.lastObject;
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20,lastView.bottom + 2, 80, 25)];
    [label setText:labelName];
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [_alertView addSubview:label];
    
    
    UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(label.right + 5, label.top, _alertView.width - 120, 25)];
    textField.placeholder =placeholder;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [textField setBackgroundColor:[UIColor whiteColor]];
    [_alertView addSubview:textField];
    
    _height = _height + textField.height;
}

-(void)CreatViewWithLableName:(NSString *)labelName Array:(NSArray *)array
{
    
   UIView *lastView = _alertView.subviews.lastObject;
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20,lastView.bottom + 2, 80, 25)];
    [label setText:labelName];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.textColor = [UIColor whiteColor];
    [_alertView addSubview:label];
    
    UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(label.right + 5, label.top, _alertView.width - 120, 25)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [textField setBackgroundColor:[UIColor whiteColor]];
    [_alertView addSubview:textField];
    
    
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button setFrame:CGRectMake(label.right + 5, label.top, _alertView.width - 120, 25)];
    [_button setBackgroundColor:[UIColor whiteColor]];
    [_button addTarget:self action:@selector(showListView) forControlEvents:UIControlEventTouchUpInside];
    _button.layer.cornerRadius = 5.0;
    [_button setTitle:array[0] forState:UIControlStateNormal];
    
    [_alertView addSubview:_button];
    
    //选择列表
    _list = [[YSHYListView alloc]init];
    _list.delegate = self;
    _list.hidden = YES;
    [_list ConfigTableViewData:array];
    [self addSubview:_list];

}


-(void)CreatButton
{
    UIView *view = _alertView.subviews.lastObject;
    CGFloat top = view.bottom + 5;
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(0, top, _alertView.width/2, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(selectedCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:cancelBtn];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, cancelBtn.top, _alertView.width, 1)];
    [line1 setBackgroundColor:[UIColor whiteColor]];
    [_alertView addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(cancelBtn.right, cancelBtn.top, 1, cancelBtn.height)];
    [line2 setBackgroundColor:[UIColor whiteColor]];
    [_alertView addSubview:line2];
    
    UIButton * ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureBtn setFrame:CGRectMake(_alertView.width/2, top, _alertView.width/2, 30)];
    [ensureBtn setTitle:@"好" forState:UIControlStateNormal];
    [ensureBtn addTarget:self action:@selector(selectedEnsureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:ensureBtn];
    
    _height = ensureBtn.bottom;
    
}

-(void)show
{
    [_alertView setSize:CGSizeMake(kSCREENWIDTH - 20, _height)];
    [self showAlertView];
    
}


-(void)selectedCancelBtn:(UIButton *)button
{
    //点击取消
    [self dismiss];
}

-(void)selectedEnsureBtn:(UIButton*)button
{
    //点击好
        [self dismiss];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.delegate SelectedEnsureBtn:self];
    });
    
}

-(void)hidden
{
   
    self.hidden = YES;
}


- (void)setupBackground {
    UIView *v = [UIView new];
    v.translatesAutoresizingMaskIntoConstraints = NO;
    [v setFrame:self.frame];
    v.backgroundColor = [UIColor blackColor];
    
    [self addSubview:v];
    _backgroundView = v;
}

-(void)setupAlertView
{
    _alertView = [[UIView alloc]init];
    [_alertView setBackgroundColor:RGB_COLOR(@"#858381")];
    [self addSubview:_alertView];

}

- (void)showAlertView {
    // init state
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat y = -(CGRectGetHeight(screenBounds) + CGRectGetHeight(_alertView.frame)/2);
    
    _backgroundView.alpha = 0.5;
    _alertView.center = CGPointMake(_alertView.center.x, y);
    _alertView.transform = CGAffineTransformMakeRotation(45);
    
    // animation
    [UIView animateWithDuration:0.6
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.9
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _backgroundView.alpha = 0.6;
                         _alertView.transform = CGAffineTransformMakeRotation(0);
                         _alertView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                         CGRectGetMidY(self.bounds));
                     } completion:^(BOOL finished) {
                     }];
    
    
}

- (void)dismiss {
    
    UIView *view = [GlobalUtil FindFirstResponder:self];
    [view resignFirstResponder];
    
    [UIView animateWithDuration:0.6f
                          delay:0.0f
         usingSpringWithDamping:1.0f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _backgroundView.alpha = 0.0;
                         _alertView.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}


-(void)showListView
{
    // 如果textField 做为第一响应者的话  收起软键盘
    UIView *view = [GlobalUtil FindFirstResponder:self];
    if(view)
    {
        [view resignFirstResponder];
    }
    
    _list.hidden = NO;
    [_list show];
}

-(void)SelectedTableViewRow:(NSString *)string
{
    _list.hidden = YES;
    [_button setTitle:string forState:UIControlStateNormal];

}


@end
