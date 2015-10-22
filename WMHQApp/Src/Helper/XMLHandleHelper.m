//
//  XMLHandleHelper.m
//  MReports
//
//  Created by self on 14-7-17.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "XMLHandleHelper.h"
#import "CommConst.h"

@implementation XMLHandleHelper

static XMLHandleHelper * sharedHelper = nil;

+ (XMLHandleHelper *) sharedInstance {
    if (sharedHelper == nil) {
		sharedHelper = [[XMLHandleHelper alloc] init];
	}
	
	return sharedHelper;
}

- (NSString *) createParamXmlStr: (NSArray *)valArr colName: (NSArray *)colNameArr{
    int count = [valArr count];
    NSMutableString *strBuf = [[NSMutableString alloc] initWithCapacity:10];
    [strBuf setString: XML_DECLARATION_STR];
    [strBuf appendString: @"&lt;InputParam&gt;"];
    for (int i = 0; i < count ; i++) {
        [strBuf appendString: @"&lt;"];
        [strBuf appendString: [colNameArr objectAtIndex:i]];
        [strBuf appendString: @"&gt;"];
        [strBuf appendString: [valArr objectAtIndex:i]];
        [strBuf appendString: @"&lt;/"];
        [strBuf appendString: [colNameArr objectAtIndex:i]];
        [strBuf appendString: @"&gt;"];
    }
    [strBuf appendString: @"&lt;/InputParam&gt;"];
    
    
    return [NSString stringWithString:strBuf];
}
@end
