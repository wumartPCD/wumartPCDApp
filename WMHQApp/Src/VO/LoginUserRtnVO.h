//
//  LoginUserVO.h
//  MReports
//
//  Created by self on 14-7-24.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "BaseRtnVO.h"

@interface LoginUserRtnVO : BaseRtnVO

@property(strong, nonatomic) NSString *UserId;

@property(strong, nonatomic) NSString *UserCode;

@property(strong, nonatomic) NSString *UserName;

@property(strong, nonatomic) NSString *Password;

@property(strong, nonatomic) NSMutableArray *AppSysVOArr;

@property(strong, nonatomic) NSMutableArray *AppAreaVOArr;

@property(strong, nonatomic) NSMutableArray *SiteArr;

@property(strong, nonatomic) NSMutableArray *MenusArr;

@end
