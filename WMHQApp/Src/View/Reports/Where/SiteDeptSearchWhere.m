//
//  SitePerfmSearchWhere.m
//  MReports
//
//  Created by self on 14-7-24.
//  Copyright (c) 2014年 wumart. All rights reserved.
//

#import "SiteDeptSearchWhere.h"

@implementation SiteDeptSearchWhere

- (id) init {
    self = [super init];
    if(self)
    {
        _SiteList = [[NSMutableArray alloc] initWithCapacity:1];
        _SiteDeptList = [[NSMutableArray alloc] initWithCapacity:20];
        _DeptNameList = [[NSMutableArray alloc] initWithCapacity:20];
        
        _CurSiteNo=@"";
        _CurSiteDept=Nil;
        _PreSiteDept=Nil;
    }
    return self;
}

- (void) fetchSite:(LoginUserRtnVO *)rtnVO {
    [_SiteList removeAllObjects];
    
    if(rtnVO.SiteArr == Nil || rtnVO.SiteArr.count == 0){
        return;
    }
    
    for (id site in rtnVO.SiteArr) {
        [_SiteList addObject:site];
    }
    
    NSArray *sites = [[rtnVO.SiteArr objectAtIndex:0] componentsSeparatedByString:@"-"];
    _CurSiteNo=[sites objectAtIndex:0];
}

- (void) fetchSiteDept:(MasterDataRtnVO *)rtnVO {
    [_SiteDeptList removeAllObjects];
    
    if(rtnVO.Data == Nil){
        return;
    }
    
    NSArray *deptArr = [rtnVO.Data componentsSeparatedByString:@","];
    for (id dept in deptArr) {
        [_SiteDeptList addObject:dept];
    }
    
    NSArray *depts = [[deptArr objectAtIndex:0] componentsSeparatedByString:@"_"];
    if (_PreSiteDept != Nil && _CurSiteDept == Nil) {
        for (id dept in depts) {
            if ([dept isEqualToString:_PreSiteDept]) {
                _CurSiteDept=dept;
                break;
            }
        }
        if (_CurSiteDept == Nil) {
            _CurSiteDept=[depts objectAtIndex:0];
        }
    }else{
        _CurSiteDept=[depts objectAtIndex:0];
    }
}

- (NSMutableArray *) getDeptNameList {
    [_DeptNameList removeAllObjects];
    
    NSArray *deptArr;
    for (id dept in _SiteDeptList) {
        deptArr = [dept componentsSeparatedByString:@"_"];
        [_DeptNameList addObject:[deptArr objectAtIndex:1]];
    }
    
    return _DeptNameList;
}

- (NSString *) getDeptName:(NSString *)deptNo {
    NSString *deptName = @"全部";
    
    NSArray *deptArr;
    for (id dept in _SiteDeptList) {
        deptArr = [dept componentsSeparatedByString:@"_"];
        if([[deptArr objectAtIndex:0] isEqualToString: deptNo]){
            deptName=[deptArr objectAtIndex:1];
            break;
        }
    }
    
    return deptName;
}

- (NSString *) getSiteInfo:(NSString *)siteNo {
    NSString *siteInfo = @"全部";
    
    NSArray *siteArr;
    for (id siteStr in _SiteList) {
        siteArr = [siteStr componentsSeparatedByString:@"-"];
        if([[siteArr objectAtIndex:0] isEqualToString: siteNo]){
            siteInfo=siteStr;
            break;
        }
    }
    
    return siteInfo;
}

- (NSString *) getSiteDeptForSearch {
    NSString *siteDept=@"-全部";
    if (_CurSiteDept != Nil) {
        NSMutableString *strBuf = [[NSMutableString alloc] initWithCapacity:3];
        [strBuf appendString: _CurSiteDept];
        [strBuf appendString: @"-"];
        [strBuf appendString: [self getDeptName:_CurSiteDept]];
        siteDept=[NSString stringWithString:strBuf];
    }else if(_PreSiteDept != Nil){
        if ([_PreSiteDept rangeOfString:@"-"].location == NSNotFound) {
            siteDept=[_PreSiteDept stringByAppendingString:siteDept];
        }else{
            siteDept=_PreSiteDept;
        }
    }
    return siteDept;
}

@end
