//
//  SQLiteHelper.m
//  MReports
//
//  Created by self on 14-7-22.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "SQLiteHelper.h"
#define DB_NAME @"WMPCDApp.sqlite"

@implementation SQLiteHelper

static SQLiteHelper * sharedDB = nil;

+ (SQLiteHelper *) sharedInstance {
    if (sharedDB == nil) {
        sharedDB = [[SQLiteHelper alloc] init];
    }
    
    return sharedDB;
}

- (id) init {
    self = [super init];
    if (self) {
        NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbpath = [docsdir stringByAppendingPathComponent:DB_NAME];
        
        _database = [FMDatabase databaseWithPath:dbpath];
    }
    
    return self;
}

- (void) createDB {
    [self openDB];
    [[self getDB] executeUpdate:@"CREATE TABLE IF NOT EXISTS LoginUser(UserId text primary key,UserCode text,UserName text,Password text)"];
    [[self getDB] executeUpdate:@"CREATE TABLE IF NOT EXISTS AppSys(AppID text,AppName text)"];
    [[self getDB] executeUpdate:@"CREATE TABLE IF NOT EXISTS AppArea(AppID text,Mandt text,MandtName text)"];
    [[self getDB] executeUpdate:@"CREATE TABLE IF NOT EXISTS Site(SiteInfo text)"];
    [[self getDB] executeUpdate:@"CREATE TABLE IF NOT EXISTS Menus(MenuID text primary key,PMenuID text,MenuName text,Mandt text,AppID integer,Level integer,IconUrl text,No integer)"];
    
    [[self getDB] executeUpdate:@"CREATE TABLE IF NOT EXISTS KeyValues(Key text,Val text)"];
    
    [self closeDB];
}

- (void) clearDB{
    [self openDB];
    [[self getDB] executeUpdate:@"DELETE FROM LoginUser"];
    [[self getDB] executeUpdate:@"DELETE FROM AppSys"];
    [[self getDB] executeUpdate:@"DELETE FROM AppArea"];
    [[self getDB] executeUpdate:@"DELETE FROM Site"];
    [[self getDB] executeUpdate:@"DELETE FROM Menus"];
    [self closeDB];
}

- (void) refreshDB {
    [self openDB];
    [[self getDB] executeUpdate:@"DROP TABLE IF EXISTS LoginUser"];
    [[self getDB] executeUpdate:@"DROP TABLE IF EXISTS AppSys"];
    [[self getDB] executeUpdate:@"DROP TABLE IF EXISTS AppArea"];
    [[self getDB] executeUpdate:@"DROP TABLE IF EXISTS Site"];
    [[self getDB] executeUpdate:@"DROP TABLE IF EXISTS Menus"];
    [self closeDB];
    
    [self createDB];
}

- (FMDatabase *) getDB {
    return _database;
}

- (void) openDB {
    if(_database){
        [_database open];
    }
}

- (void) closeDB {
    if(_database){
        [_database close];
    }
}

@end
