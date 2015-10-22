//
//  KeyMerchSearchWhere.m
//  MReports
//
//  Created by self on 14-7-24.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "KeyMerchSearchWhere.h"
#import "CommMasterAndReportsRtnVO.h"

@implementation KeyMerchSearchWhere

- (id) init {
    self = [super init];
    if(self)
    {
        _KeyMerchList = [[NSMutableArray alloc] initWithCapacity:10];
        
        _CurKeyMerch=@"";
    }
    return self;
}

- (void) fetchKeyMerch:(CommMasterAndReportsRtnVO *)rtnVO {
    [_KeyMerchList removeAllObjects];
    
    if(rtnVO.Data == Nil || rtnVO.Data.length==0){
        _CurKeyMerch=@"";
        return;
    }
    
    NSArray *dataArr = [rtnVO.Data componentsSeparatedByString:@","];
    for (id item in dataArr) {
        [_KeyMerchList addObject:item];
    }
    NSArray *datas = [[dataArr objectAtIndex:0] componentsSeparatedByString:@"-"];
    _CurKeyMerch=[datas objectAtIndex:0];
}

@end
