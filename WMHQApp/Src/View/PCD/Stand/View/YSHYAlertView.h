//
//  YSHYAlertView.h
//  WMPCDApp
//
//  Created by 杨淑园 on 15/10/8.
//  Copyright © 2015年 yangshuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSHYListView.h"
@class YSHYAlertView;
#define kSCREENWIDTH  [[UIScreen mainScreen]bounds].size.width
#define kSCREENHEIGHT  [[UIScreen mainScreen]bounds].size.height

typedef enum {
    AlertViewTypeOnlyTextFiled        = 0,
    AlertViewTypeTextFiledAndComboBox = 1
}AlertViewType;

@protocol YSHYAlertViewDelegate <NSObject>

-(void)SelectedEnsureBtn:(YSHYAlertView *)alertView;

@end


@interface YSHYAlertView : UIView<YSHYListViewDelegate>
{
    CGFloat _height;
    UIView *_backgroundView;
    UIView *_alertView;
    YSHYListView *_list;
    UIButton *_button;//选择品项数按钮
}
@property (nonatomic, assign)AlertViewType type;
@property (nonatomic, strong) UILabel *titeLabel;
@property (nonatomic, assign) id<YSHYAlertViewDelegate>delegate;

-(void)CreatViewWithLableName:(NSString *)labelName placeholderText:(NSString *)placeholder;

-(void)CreatViewWithLableName:(NSString *)labelName Array:(NSArray *)array;


-(void)setTitle:(NSString *)title;
-(void)CreatButton;

-(void)show
;
@end
