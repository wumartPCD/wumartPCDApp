//
//  KeyMerchSearchWhere.h
//  MReports
//
//  Created by self on 14-7-24.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommMasterAndReportsRtnVO.h"

@interface KeyMerchSearchWhere : NSObject

@property(strong, nonatomic) NSMutableArray *KeyMerchList;

@property(strong, nonatomic) NSString *CurKeyMerch;

- (void) fetchKeyMerch:(CommMasterAndReportsRtnVO *)rtnVO;

@end
