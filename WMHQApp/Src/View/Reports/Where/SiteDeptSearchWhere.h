//
//  SitePerfmSearchWhere.h
//  MReports
//
//  Created by self on 14-7-24.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginUserRtnVO.h"
#import "MasterDataRtnVO.h"

@interface SiteDeptSearchWhere : NSObject

@property(strong, nonatomic) NSMutableArray *SiteList;
@property(strong, nonatomic) NSMutableArray *SiteDeptList;
@property(strong, nonatomic) NSMutableArray *DeptNameList;

@property(strong, nonatomic) NSString *CurSiteNo;
@property(strong, nonatomic) NSString *CurSiteDept;

@property(strong, nonatomic) NSString *PreSiteDept;
@property(strong, nonatomic) NSString *DataType;

- (void) fetchSite:(LoginUserRtnVO *)rtnVO;
- (void) fetchSiteDept:(MasterDataRtnVO *)rtnVO;

- (NSMutableArray *) getDeptNameList;
- (NSString *) getDeptName:(NSString *)deptNo;
- (NSString *) getSiteInfo:(NSString *)siteNo;
- (NSString *) getSiteDeptForSearch;

@end
