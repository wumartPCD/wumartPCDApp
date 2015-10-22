//
//  BaseWebService.m
//  WMHQApp
//
//  Created by laisl_mac on 15-1-11.
//  Copyright (c) 2015年 wumart. All rights reserved.
//

#import "BaseWebService.h"

@implementation BaseWebService

- (NSDictionary *) execComm: (NSString *)funcCode xmlStr:(NSString *)xmlStr{
    
    @try {
        ServiceArgs *param = [[ServiceArgs alloc] init];
        param.serviceURL = WEB_SERVICE_URL;
        param.serviceNameSpace=WEB_SERVICE_NAMESPACE;
        param.methodName=@"Execute";
        param.soapParams=[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:funcCode,@"funcCode", nil],[NSDictionary dictionaryWithObjectsAndKeys:xmlStr,@"xmlStr", nil], nil];
        
        NSString *rtnStr=[[ServiceHelper sharedInstance] syncService: param];
        NSArray *rtnArr=[SoapXmlParseHelper searchNodeToArray:rtnStr nodeName:@"OutputResult"];
        return [rtnArr objectAtIndex:0];
    }
    @catch (NSException *e) {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                [NSString stringWithFormat:@"%d",-1], RESULT_FLAG,
                @"请检查是否有可用的网络连接", RESULT_MESG,nil];
    }
}

- (CommReportsRtnVO *) getCommReportsRtnVO: (NSDictionary *)dict {
    
    CommReportsRtnVO * rtnVO = [[CommReportsRtnVO alloc] init];
    rtnVO.ResultFlag=[[dict objectForKey:RESULT_FLAG] intValue];
    rtnVO.ResultMesg=[dict objectForKey:RESULT_MESG];
    rtnVO.ReportTitle=[dict objectForKey:REPORT_TITLE];
    rtnVO.ReportHtml=[dict objectForKey:REPORT_HTML];
    rtnVO.ReportHint=[dict objectForKey:REPORT_HINT];
    
    return rtnVO;
}

- (MasterDataRtnVO *) getCommMasterRtnVO: (NSDictionary *)dict {
    
    MasterDataRtnVO * rtnVO = [[MasterDataRtnVO alloc] init];
    rtnVO.ResultFlag=[[dict objectForKey:RESULT_FLAG] intValue];
    rtnVO.ResultMesg=[dict objectForKey:RESULT_MESG];
    rtnVO.Data=[dict objectForKey:HAS_AUTH_MASTER_DATA_STR];
    
    return rtnVO;
}

- (CommMasterAndReportsRtnVO *) getCommMasterAndReportsRtnVO: (NSDictionary *)dict {
    
    CommMasterAndReportsRtnVO * rtnVO = [[CommMasterAndReportsRtnVO alloc] init];
    rtnVO.ResultFlag=[[dict objectForKey:RESULT_FLAG] intValue];
    rtnVO.ResultMesg=[dict objectForKey:RESULT_MESG];
    rtnVO.ReportTitle=[dict objectForKey:REPORT_TITLE];
    rtnVO.ReportHtml=[dict objectForKey:REPORT_HTML];
    rtnVO.ReportHint=[dict objectForKey:REPORT_HINT];
    
    rtnVO.Data=[dict objectForKey:HAS_AUTH_MASTER_DATA_STR];
    
    return rtnVO;
}

- (NSString *) getVal: (NSString *)val {
    return ([@"#" isEqualToString:val] ? @"" : val);
}

@end
