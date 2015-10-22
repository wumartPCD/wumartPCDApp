//
//  SysMnagDao.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-11.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "SysMangDao.h"

@implementation SysMangDao

- (LoginUserRtnVO *) getLoginUser {
    
    SQLiteHelper *dbHelper = [self dbHelper];
    [dbHelper openDB];
    
    FMResultSet *rs;
    rs= [[dbHelper getDB] executeQuery:@"SELECT COUNT(*) AS Num FROM sqlite_master WHERE type='table' AND name='LoginUser'"];
    if ([rs next]) {
        if([rs intForColumnIndex:0]==0)
        {
            [dbHelper createDB];
            return nil;
        }
    }
    
    rs = [[dbHelper getDB] executeQuery:@"SELECT * FROM LoginUser"];
    
    LoginUserRtnVO *user=Nil;
    
    if ([rs next]) {
        user=[[LoginUserRtnVO alloc] init];
        user.UserId = [rs stringForColumn:@"UserId"];
        user.UserCode = [rs stringForColumn:@"UserCode"];
        user.UserName = [rs stringForColumn:@"UserName"];
        user.Password = [rs stringForColumn:@"Password"];
    }
    
    [dbHelper closeDB];
    
    return user;
}

- (BOOL) hasAppAuth :(NSString *)appID{
    BOOL hasAuth = false;
    SQLiteHelper *dbHelper = [self dbHelper];
    [dbHelper openDB];
    
    FMResultSet *rs = [[dbHelper getDB] executeQuery:@"SELECT * FROM AppSys WHERE AppID=?", appID];
    while ([rs next]) {
        hasAuth = true;
    }
    
    [dbHelper closeDB];
    
    return hasAuth;
}

- (NSMutableArray *) findAreaMenus :(NSString *)appID{
    SQLiteHelper *dbHelper = [self dbHelper];
    [dbHelper openDB];
    
    NSMutableArray *appAreaArr=[[NSMutableArray alloc] init];
    AppAreaVO *appArea=Nil;
    
    FMResultSet *rs = [[dbHelper getDB] executeQuery:@"SELECT Mandt,MandtName FROM AppArea WHERE AppID=? ORDER BY Mandt ASC", appID];
    while ([rs next]) {
        appArea=[[AppAreaVO alloc] init];
        appArea.AppID = appID;
        appArea.Mandt = [rs stringForColumnIndex:0];
        appArea.MandtName = [rs stringForColumnIndex:1];
        [appAreaArr addObject:appArea];
    }
    
    [dbHelper closeDB];
    
    return appAreaArr;
}

- (NSMutableArray *) findMenus:(NSString *)appID mandt:(NSString *)mandt level:(NSString *)level {
    
    return [self findMenus:appID mandt:mandt level:level escapeMenuID:Nil];
}

- (NSMutableArray *) findMenus:(NSString *)appID mandt:(NSString *)mandt level:(NSString *)level escapeMenuID:(NSString *)escapeMenuID {
    SQLiteHelper *dbHelper = [self dbHelper];
    [dbHelper openDB];
    
    FMResultSet *rs;
    if (escapeMenuID==Nil) {
        rs = [[dbHelper getDB] executeQuery:@"SELECT MenuID,MenuName FROM Menus WHERE AppID=? AND Mandt=? AND Level=?", appID,mandt,level];
    }else{
        rs = [[dbHelper getDB] executeQuery:@"SELECT MenuID,MenuName FROM Menus WHERE AppID=? AND Mandt=? AND Level=? AND MenuID NOT IN (?)", appID,mandt,level,escapeMenuID];
    }
    
    NSMutableArray *menusArr=[[NSMutableArray alloc] init];
    MenusVO *menu=Nil;
    
    while ([rs next]) {
        menu=[[MenusVO alloc] init];
        menu.AppID = appID;
        menu.Mandt = mandt;
        menu.MenuID = [rs stringForColumnIndex:0];
        menu.MenuName = [rs stringForColumnIndex:1];
        [menusArr addObject:menu];
    }
    
    [dbHelper closeDB];
    
    return menusArr;
}

- (NSMutableArray *) findChildMenus:(NSString *)pMenuID {
    
    SQLiteHelper *dbHelper = [self dbHelper];
    [dbHelper openDB];
    
    NSMutableArray *menusArr=[[NSMutableArray alloc] init];
    MenusVO *menu=Nil;
    
    FMResultSet *rs = [[dbHelper getDB] executeQuery:@"SELECT MenuID,MenuName FROM Menus WHERE PMenuID=?", pMenuID];
    while ([rs next]) {
        menu=[[MenusVO alloc] init];
        menu.MenuID = [rs stringForColumnIndex:0];
        menu.MenuName = [rs stringForColumnIndex:1];
        [menusArr addObject:menu];
    }
    
    [dbHelper closeDB];
    
    return menusArr;
}

- (NSString *) getPMenuID:(NSString *)menuID {
    
    SQLiteHelper *dbHelper = [self dbHelper];
    [dbHelper openDB];
    
    NSString *pMenuID;
    FMResultSet *rs = [[dbHelper getDB] executeQuery:@"SELECT PMenuID FROM Menus WHERE MenuID=?", menuID];
    while ([rs next]) {
        pMenuID=[rs stringForColumnIndex:0];
        break;
    }
    
    [dbHelper closeDB];
    
    return pMenuID;
}

- (void) changePswd:(NSString *)userCode pswd:(NSString *)pswd {
    
    SQLiteHelper *dbHelper = [self dbHelper];
    [dbHelper openDB];
    
    NSMutableString *strBuf = [[NSMutableString alloc] initWithCapacity:2];
    
    [strBuf setString: @""];
    [strBuf appendString: @"UPDATE LoginUser SET Password=?"];
    [strBuf appendString: @" WHERE UserCode=?"];
    
    [[dbHelper getDB] executeUpdate:[NSString stringWithString:strBuf],pswd,userCode];
    
    [dbHelper closeDB];
}

- (void) updateKeyValues:(NSString *)key val:(NSString *)val {
    SQLiteHelper *dbHelper = [self dbHelper];
    [dbHelper openDB];
    
    bool isExists=false;
    
    NSMutableString *strBuf = [[NSMutableString alloc] initWithCapacity:2];
    
    FMResultSet *rs = [[dbHelper getDB] executeQuery:@"SELECT Val FROM KeyValues WHERE Key=?", key];
    while ([rs next]) {
        isExists=true;
        break;
    }
    
    [strBuf setString: @""];
    if(isExists){
        [strBuf appendString: @"UPDATE KeyValues SET Val=?"];
        [strBuf appendString: @" WHERE Key=?"];
        
        [[dbHelper getDB] executeUpdate:[NSString stringWithString:strBuf],val,key];
    }else{
        [strBuf appendString: @"INSERT INTO KeyValues(Key,Val)"];
        [strBuf appendString: @" VALUES (?,?)"];
        [[dbHelper getDB] executeUpdate:[NSString stringWithString:strBuf],key,val];
    }
    
    [dbHelper closeDB];
}

- (NSString *) getKeyValues:(NSString *)key {
    SQLiteHelper *dbHelper = [self dbHelper];
    [dbHelper openDB];
    
    [[dbHelper getDB] executeUpdate:@"CREATE TABLE IF NOT EXISTS KeyValues(Key text,Val text)"];
    
    NSString *val = nil;
    FMResultSet *rs = [[dbHelper getDB] executeQuery:@"SELECT Val FROM KeyValues WHERE Key=?", key];
    while ([rs next]) {
        val=[rs stringForColumnIndex:0];
        break;
    }
    
    [dbHelper closeDB];
    
    return val;
}

@end
