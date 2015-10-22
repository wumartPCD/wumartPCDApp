//
//  Conconst.h
//  MReports
//
//  Created by self on 14-8-3.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    FuncSitePerfmS101 = 0,
    FuncSitePerfmS107,
    FuncSitePerfmTop10
};

extern NSString* const APP_ID_BREAKFAST;
extern NSString* const APP_ID_RTSALE;
extern NSString* const APP_ID_SITE_PERFM;
extern NSString* const APP_ID_PCD_STAND;

extern NSString* const MANDT_300;
extern NSString* const MANDT_305;
extern NSString* const MANDT_307;

extern NSString* const REPORTS_MENU_100; // 销售毛利总表
extern NSString* const REPORTS_MENU_200; // 大卖场区本销售毛利
extern NSString* const REPORTS_MENU_300; // 采购线销售毛利
extern NSString* const REPORTS_MENU_400; // 采购线赞返
extern NSString* const REPORTS_MENU_500; // 招商部业绩
extern NSString* const REPORTS_MENU_600; // 团购业绩
extern NSString* const REPORTS_MENU_700; // 大卖场门店销售毛利
extern NSString* const REPORTS_MENU_800; // 购物中心采购线

extern NSString* const MENU_LEVEL_GROUP;
extern NSString* const MENU_LEVEL_CHILD;

extern NSString* const MENUID_KEY_MERCH;
extern NSString* const MENUID_KEY_MERCH_SITE;

extern NSString* const MENUID_PCD_PROMO_INPUT_NAVI;
extern NSString* const MENUID_PCD_VIEW_NAVI;

extern NSString* const MENUID_HQ_PROMO_H111;
extern NSString* const MENUID_SITE_PERFM_S101;
extern NSString* const MENUID_SITE_PERFM_S107;
extern NSString* const MENUID_SITE_PERFM_TOP10;
extern NSString* const MENUID_SITE_PERFM_S108;

@interface MenuConst : NSObject

@end
