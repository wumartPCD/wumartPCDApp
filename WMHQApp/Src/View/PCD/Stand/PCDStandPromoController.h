//
//  YSHYImagePickerController.h
//  WMPCDApp
//
//  Created by 杨淑园 on 15/9/23.
//  Copyright © 2015年 yangshuyuan. All rights reserved.
//
#import "BasePortraitController.h"
#import "CommPcdNaviWhere.h"
#import "ComboBoxButton.h"
#import "ComboBoxList.h"
#import "GridMenuView.h"
#define BtnBarColor @"#ecfaff"
#define LabelColor @"#9fe7ba"
#define ButtonColor @"#F6B2A0"

@interface PCDStandPromoController : BasePortraitController<ComboBoxButtonDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UILabel *puunitThemeLbl;       //品项数
    UILabel *pcdNumLbl;       //品项数
    
    ComboBoxList *pcdNoCbxList;
    UIButton *pcdNoCbxBtn;
    
    UIButton *addStandBtn;
    UIButton *delStandBtn;
    
    GridMenuView *gridMenuView;
    
    UIButton *addImgBtn;
    UIButton *uploadImgBtn;
    UIButton *addMerchBtn;
    UIButton *scanMerchBtn;
    
    UITableView *merchListView;
    
    GlobalApp *globalApp;
    
}
@property (nonatomic, strong) NSArray * _UArray;       //U课列表
@property (nonatomic, strong) NSArray * _themeArray;  //主题列表
@property (nonatomic, strong) UIView  *sectionView ;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, assign) int IsReadonly;
@property (nonatomic, strong) NSString *StandNo;
@property (nonatomic, strong) CommPcdNaviWhere *naviWhere;

@end
