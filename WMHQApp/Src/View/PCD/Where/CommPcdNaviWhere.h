//
//  BaseReportsRtnVO.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-11.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRtnVO.h"

@interface CommPcdNaviWhere : BaseRtnVO

@property(strong, nonatomic) NSMutableArray *AktnrList;
@property(strong, nonatomic) NSMutableArray *OperList;
@property(strong, nonatomic) NSMutableArray *PromoTypeList;
@property(strong, nonatomic) NSMutableArray *PuunitList;
@property(strong, nonatomic) NSMutableArray *ThemeList;
@property(strong, nonatomic) NSMutableArray *AbsortList;
@property(strong, nonatomic) NSMutableArray *SiteTmplList;
@property(strong, nonatomic) NSMutableArray *PcdTypeList;
@property(strong, nonatomic) NSMutableArray *PcdNumList;
@property(strong, nonatomic) NSMutableArray *PcdNoList;

@property(strong, nonatomic) NSMutableArray *ImgInfoList;
@property(strong, nonatomic) NSMutableArray *ImgUrlList;
@property(strong, nonatomic) NSMutableArray *MerchList;
@property(strong, nonatomic) NSMutableArray *PcdStandList;

@property(strong, nonatomic) NSString *CurStandNo;
@property(strong, nonatomic) NSString *CurAktnr;
@property(strong, nonatomic) NSString *CurOper;
@property(strong, nonatomic) NSString *CurPuunit;
@property(strong, nonatomic) NSString *CurTheme;
@property(strong, nonatomic) NSString *CurAbsort;
@property(strong, nonatomic) NSString *CurMerchCode;
@property(strong, nonatomic) NSString *CurSiteTmpl;
@property(strong, nonatomic) NSString *CurPcdType;
@property(strong, nonatomic) NSString *CurPcdNum;
@property(strong, nonatomic) NSString *CurPcdNo;

@property(assign, nonatomic) BOOL IsInited;

- (id) initWithType:(BOOL)isFirstBlank;

- (NSString *) getWhere:(NSString *)whereStr;
- (void) reInit;- (NSString *) getNewPcdNo;
- (BOOL) isPcdNoExists:(NSString *)newPcdNo;
- (NSMutableArray *) getImgUrlList;
- (NSString *) getPuunitName:(NSString *)puunit;
- (NSString *) getThemeName:(NSString *)theme ;
- (NSString *) getSiteTmplName:(NSString *)siteTmpl;
- (NSString *) getPcdTypeName:(NSString *)pcdType;
- (NSString *) getPcdNumName:(NSString *)pcdNum;
- (CommPcdNaviWhere *) cloneWhere;

@end
