//
//  SysMnagDao.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-11.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseDao.h"
#import "LoginUserRtnVO.h"
#import "AppSysVO.h"
#import "AppAreaVO.h"
#import "MenusVO.h"

@interface SysMangDao : BaseDao

- (LoginUserRtnVO *) getLoginUser;
- (BOOL) hasAppAuth :(NSString *)appID;
- (NSMutableArray *) findAreaMenus:(NSString *)appID;
- (NSMutableArray *) findMenus:(NSString *)appID mandt:(NSString *)mandt level:(NSString *)level;
- (NSMutableArray *) findMenus:(NSString *)appID mandt:(NSString *)mandt level:(NSString *)level escapeMenuID:(NSString *)escapeMenuID;
- (NSMutableArray *) findChildMenus:(NSString *)pMenuID;
- (NSString *) getPMenuID:(NSString *)menuID;
- (void) changePswd:(NSString *)userCode pswd:(NSString *)pswd;
- (void) updateKeyValues:(NSString *)key val:(NSString *)val;
- (NSString *) getKeyValues:(NSString *)key;
@end
