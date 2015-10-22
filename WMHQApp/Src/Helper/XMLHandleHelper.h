//
//  XMLHandleHelper.h
//  MReports
//
//  Created by self on 14-7-17.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLHandleHelper : NSObject

+ (XMLHandleHelper *) sharedInstance;

- (NSString *) createParamXmlStr: (NSArray *)valArr colName: (NSArray *)colNameArr;

@end
