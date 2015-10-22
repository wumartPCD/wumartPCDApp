//
//  MenusVO.h
//  MReports
//
//  Created by self on 14-8-3.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRtnVO.h"

@interface MenusVO : BaseRtnVO

@property(strong, nonatomic) NSString *MenuID;

@property(strong, nonatomic) NSString *ParentMenuID;

@property(strong, nonatomic) NSString *MenuName;

@property(strong, nonatomic) NSString *Mandt;

@property(strong, nonatomic) NSString *AppID;

@property(nonatomic) int Level;

@property(strong, nonatomic) NSString *IconUrl;

@property(strong, nonatomic) NSMutableArray *SubMenusArr;

@end
