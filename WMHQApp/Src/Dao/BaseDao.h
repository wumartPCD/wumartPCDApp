//
//  BaseDao.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-11.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteHelper.h"

@interface BaseDao : NSObject

- (SQLiteHelper *) dbHelper;

@end
