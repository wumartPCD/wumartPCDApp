//
//  BaseReportsRtnVO.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-11.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "CommPcdNaviWhere.h"
#import "EnumConst.h"
#import "CommConst.h"

@implementation CommPcdNaviWhere

- (id) init {
    self = [super init];
    if (self) {
        _CurStandNo = @"";
        _CurAktnr = @"";
        _CurOper = @"";
        _CurPuunit = @"";
        _CurTheme = @"";
        _CurAbsort = @"";
        _CurMerchCode = @"";
        _CurSiteTmpl = @"";
        _CurPcdType = @"";
        _CurPcdNum = @"";
        _CurPcdNo = @"";
        
        _AktnrList = [[NSMutableArray alloc] init];
        _OperList = [[NSMutableArray alloc] init];
        _PromoTypeList = [[NSMutableArray alloc] init];
        _PuunitList = [[NSMutableArray alloc] init];
        _ThemeList = [[NSMutableArray alloc] init];
        _AbsortList = [[NSMutableArray alloc] init];
        _SiteTmplList = [[NSMutableArray alloc] init];
        _PcdTypeList = [[NSMutableArray alloc] init];
        _PcdNumList = [[NSMutableArray alloc] init];
        _PcdNoList = [[NSMutableArray alloc] init];
        
        _ImgInfoList = [[NSMutableArray alloc] init];
        _ImgUrlList = [[NSMutableArray alloc] init];
        _MerchList = [[NSMutableArray alloc] init];
        _PcdStandList = [[NSMutableArray alloc] init];
        
        _IsInited = FALSE;
    }
    return self;
}

- (id) initWithType:(BOOL)isFirstBlank {
    self = [self init];
    if (self) {
        if (isFirstBlank) {
            // _SiteTmplList addObject:@""];
        }
        [_SiteTmplList addObject:SITE_TMPL_BIG];
        [_SiteTmplList addObject:SITE_TMPL_MEDIUM];
        [_SiteTmplList addObject:SITE_TMPL_SMALL];
        [_SiteTmplList addObject:SITE_TMPL_SMALL_SIX];
        
        [_PromoTypeList addObject:PCD_PROMO_TYPE_1];
        [_PromoTypeList addObject:PCD_PROMO_TYPE_2];
        
        if (isFirstBlank) {
            [_ThemeList addObject:@""];
        }
        [_ThemeList addObject:THEME_HY];
        [_ThemeList addObject:THEME_QD];
        [_ThemeList addObject:THEME_ZH];
        [_ThemeList addObject:THEME_BH];
        
        if (isFirstBlank) {
            [_PcdTypeList addObject:@""];
        }
        [_PcdTypeList addObject:PCD_TYPE_P];
        [_PcdTypeList addObject:PCD_TYPE_T];
        [_PcdTypeList addObject:PCD_TYPE_PT];
        [_PcdTypeList addObject:PCD_TYPE_L];
        
        [_PcdNumList addObject:PCD_NUM_1];
        [_PcdNumList addObject:PCD_NUM_2];
        [_PcdNumList addObject:PCD_NUM_3];
    }
    return self;
}

- (NSString *) getWhere:(NSString *)whereStr {
    if (whereStr == Nil || [whereStr length] == 0) {
        return @"";
    } else {
        NSArray *strArr = [whereStr componentsSeparatedByString:@"-"];
        return [strArr objectAtIndex:0];
    }
}

- (void) reInit {
    _CurStandNo = @"";
    _CurPcdNo = @"";
    _CurPcdNum = @"";
    [_PcdNoList removeAllObjects];
    [_ImgInfoList removeAllObjects];
    [_MerchList removeAllObjects];
}

- (NSString *) getNewPcdNo {
    if ([_PcdNoList count] == 0) {
        return @"01";
    } else {
        NSInteger maxIndex = [_PcdNoList count] -1 ;
        NSString *maxPcdNoStr = [_PcdNoList objectAtIndex:maxIndex];
        @try {
            int newPcdNo = [maxPcdNoStr intValue]+1;
            if (newPcdNo < 10) {
                return [@"0" stringByAppendingString:[NSString stringWithFormat:@"%d",newPcdNo]];
            } else {
                return [NSString stringWithFormat:@"%d",newPcdNo];
            }
        } @catch (NSException *exp) {
            return @"01";
        }
    }
}

- (BOOL) isPcdNoExists:(NSString *)newPcdNo {
    BOOL flag = FALSE;
    for (NSString *pcdNo in _PcdNoList) {
        if ([pcdNo isEqualToString:newPcdNo]) {
            flag = TRUE;
            break;
        }
    }
    return flag;
}

- (NSMutableArray *) getImgUrlList {
    [_ImgUrlList removeAllObjects];
    
    NSArray *imgArr;
    for (NSString *imgInfo in _ImgInfoList) {
        imgArr = [imgInfo componentsSeparatedByString:@"-"];
        [_ImgUrlList addObject:[PCD_IMG_URL stringByAppendingString:imgArr[1]]];
    }
    return _ImgUrlList;
}

- (NSString *) getPuunitName:(NSString *)puunit {
    NSString *name = puunit;
    if (puunit != Nil && [puunit length] > 0) {
        NSArray *arr;
        for (NSString *str in _PuunitList) {
            arr = [str componentsSeparatedByString:@"-"];
            if ([str isEqualToString:puunit] || [[arr objectAtIndex:0] isEqualToString:puunit]) {
                name = [arr objectAtIndex:1];
                break;
            }
        }
    }
    return name;
}

- (NSString *) getThemeName:(NSString *)theme {
    NSString *name = theme;
    if (theme != Nil && [theme length] > 0) {
        NSArray *arr;
        for (NSString *str in _ThemeList) {
            arr = [str componentsSeparatedByString:@"-"];
            if ([str isEqualToString:theme] || [[arr objectAtIndex:0] isEqualToString:theme]) {
                name = [arr objectAtIndex:1];
                break;
            }
        }
    }
    return name;
}

- (NSString *) getSiteTmplName:(NSString *)siteTmpl {
    NSString *name = siteTmpl;
    if (siteTmpl != Nil && [siteTmpl length] > 0) {
        NSArray *arr;
        for (NSString *str in _SiteTmplList) {
            arr = [str componentsSeparatedByString:@"-"];
            if ([str isEqualToString:siteTmpl] || [[arr objectAtIndex:0] isEqualToString:siteTmpl]) {
                name = [arr objectAtIndex:1];
                break;
            }
        }
    }
    return name;
}

- (NSString *) getPcdTypeName:(NSString *)pcdType {
    NSString *name = pcdType;
    if (pcdType != Nil && [pcdType length] > 0) {
        NSArray *arr;
        for (NSString *str in _PcdTypeList) {
            arr = [str componentsSeparatedByString:@"-"];
            if ([str isEqualToString:pcdType] || [[arr objectAtIndex:0] isEqualToString:pcdType]) {
                name = [arr objectAtIndex:1];
                break;
            }
        }
    }
    return name;
}

- (NSString *) getPcdNumName:(NSString *)pcdNum {
    NSString *name = pcdNum;
    if (pcdNum != Nil && [pcdNum length] > 0) {
        NSArray *arr;
        for (NSString *str in _PcdNumList) {
            arr = [str componentsSeparatedByString:@"-"];
            if ([str isEqualToString:pcdNum] || [[arr objectAtIndex:0] isEqualToString:pcdNum]) {
                name = [arr objectAtIndex:1];
                break;
            }
        }
    }
    return name;
}

- (CommPcdNaviWhere *) cloneWhere {
    
    CommPcdNaviWhere *where = [[CommPcdNaviWhere alloc] init] ;
    where.CurStandNo=_CurStandNo;
    where.CurAktnr  =_CurAktnr;
    where.CurOper =_CurOper;
    where.CurPuunit =_CurPuunit;
    where.CurTheme =_CurTheme;
    where.CurAbsort =_CurAbsort;
    where.CurMerchCode =_CurMerchCode;
    where.CurSiteTmpl =_CurSiteTmpl;
    where.CurPcdType =_CurPcdType;
    where.CurPcdNum =_CurPcdNum;
    where.CurPcdNo =_CurPcdNo;
    return where;
}

@end
