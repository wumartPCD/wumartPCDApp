//
//  BaseReportsRtnVO.h
//  WMHQApp
//
//  Created by laisl_mac on 15-1-11.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRtnVO.h"

@interface CommReportsRtnVO : BaseRtnVO

@property(strong, nonatomic) NSString *ReportTitle;

@property(strong, nonatomic) NSString *ReportHtml;

@property(strong, nonatomic) NSString *ReportHint;

@end
