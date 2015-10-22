//
//  SQLiteHelper.h
//  MReports
//
//  Created by self on 14-7-22.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "LoginUserRtnVO.h"

@interface SQLiteHelper : NSObject{
    
}

@property(nonatomic, readonly) FMDatabase *database;

+ (SQLiteHelper *) sharedInstance;

- (void) createDB;
- (void) clearDB;
- (void) refreshDB;

- (FMDatabase *) getDB;
- (void) openDB;
- (void) closeDB;

@end
