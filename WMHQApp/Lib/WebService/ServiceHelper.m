//
//  ServiceHelper.m
//  HttpRequest
//
//  Created by aJia on 2012/10/27.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceHelper.h"
#import "SoapXmlParseHelper.h"

@interface ServiceHelper()
//重设队列
-(void)resetQueue;
/********对于返回soap信息的处理**********/
-(NSString*)soapMessageResult:(ASIHTTPRequest*)request;
@end

@implementation ServiceHelper
@synthesize delegate,httpRequest;
@synthesize requestList,networkQueue;

//单例模式
+ (ServiceHelper *)sharedInstance{
    static dispatch_once_t  onceToken;
    static ServiceHelper * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[ServiceHelper alloc] init];
    });
    return sSharedInstance;
}
#pragma mark -
#pragma mark 初始化操作
-(id)initWithDelegate:(id<ServiceHelperDelegate>)theDelegate
{
	if (self=[super init]) {
		self.delegate=theDelegate;
        if (self.networkQueue) {
            self.networkQueue=[[ASINetworkQueue alloc] init];
        }
        
	}
	return self;
}
#pragma mark -
#pragma mark 获取公有请求的ASIHTTPRequest
-(ASIHTTPRequest*)commonSharedRequest:(ServiceArgs*)args{
   
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:args.webURL];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [args.soapMessage length]];
	
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
	[request addRequestHeader:@"Host" value:[args.webURL host]];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
	[request addRequestHeader:@"Content-Length" value:msgLength];
    [request addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@%@",args.serviceNameSpace,args.methodName]];
    [request setRequestMethod:@"POST"];
    //设置用户信息
    //[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:args.methodName,@"name", nil]];
	//传soap信息
    [request appendPostData:[args.soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:30.0];//表示30秒请求超时
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    return request;
}
+(ASIHTTPRequest*)commonSharedRequest:(ServiceArgs*)args{
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:args.webURL];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [args.soapMessage length]];
	
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
	[request addRequestHeader:@"Host" value:[args.webURL host]];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
	[request addRequestHeader:@"Content-Length" value:msgLength];
    [request addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@%@",args.serviceNameSpace,args.methodName]];
    [request setRequestMethod:@"POST"];
    //设置用户信息
    //[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:methosName,@"name", nil]];
	//传soap信息
    [request appendPostData:[args.soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:30.0];//表示30秒请超时
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    return request;

}
#pragma mark -
#pragma mark 同步请求   
-(NSString*)syncService:(ServiceArgs*)args{
    [self.httpRequest clearDelegatesAndCancel];
   
    [self setHttpRequest:[ASIHTTPRequest requestWithURL:args.webURL]];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [args.soapMessage length]];
	
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
	[self.httpRequest addRequestHeader:@"Host" value:[args.webURL host]];
    [self.httpRequest addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
	[self.httpRequest addRequestHeader:@"Content-Length" value:msgLength];
    [self.httpRequest addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@%@",args.serviceNameSpace,args.methodName]];
    [self.httpRequest setRequestMethod:@"POST"];
    //设置用户信息
    [self.httpRequest setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:args.methodName,@"name", nil]];
	//传soap信息
    [self.httpRequest appendPostData:[args.soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [self.httpRequest setValidatesSecureCertificate:NO];
    [self.httpRequest setTimeOutSeconds:600.0];//表示10分钟请求超时
    [self.httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];

    //设置同步
    [self.httpRequest startSynchronous];
    //处理返回的结果
    return [self soapMessageResult:self.httpRequest];
}
#pragma mark -
#pragma mark 异步请求
-(void)asynService:(ServiceArgs*)args{
    [self.httpRequest clearDelegatesAndCancel];
    [self setHttpRequest:[ASIHTTPRequest requestWithURL:args.webURL]];
   

    NSString *msgLength = [NSString stringWithFormat:@"%d", [args.soapMessage length]];
	
    //或者[self.httpRequest setRequestHeaders:args.headers];

    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
	[self.httpRequest addRequestHeader:@"Host" value:[args.webURL host]];
    [self.httpRequest addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
        [self.httpRequest addRequestHeader:@"Content-Length" value:msgLength];
	
    [self.httpRequest addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@%@",args.serviceNameSpace,args.methodName]];
    [self.httpRequest setRequestMethod:@"POST"];
    //设置用户信息
    //[self.httpRequest setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:args.methodName,@"name", nil]];
	//传soap信息
    [self.httpRequest appendPostData:[args.soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [self.httpRequest setValidatesSecureCertificate:NO];
    [self.httpRequest setTimeOutSeconds:30.0];//表示30秒请求超时
    [self.httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(progressRequest:)]) {
        [self.delegate progressRequest:self.httpRequest];
    }
    if (_progressBlock) {
        _progressBlock(self.httpRequest);
    }
    
    [self.httpRequest setDelegate:self];
    //异步请求
	[self.httpRequest startAsynchronous];
    
    
}
-(void)asynService:(ServiceArgs*)args delegate:(id<ServiceHelperDelegate>)theDelegate{
    
    self.delegate=theDelegate;
    [self asynService:args];
}
-(void)asynService:(ServiceArgs*)args completed:(finishBlockRequest)finish failed:(failedBlockRequest)failed{
    [self asynService:args progress:nil completed:finish failed:failed];
}
-(void)asynService:(ServiceArgs*)args progress:(progressRequestBlock)progress completed:(finishBlockRequest)finish failed:(failedBlockRequest)failed{
        Block_release(_progressBlock);
        _progressBlock=Block_copy(progress);
   
         Block_release(_finishBlock);
        _finishBlock=Block_copy(finish);
   
        Block_release(_failedBlock);
         _failedBlock=Block_copy(failed);
    
    [self asynService:args];
}
#pragma mark -
#pragma mark ASIHTTPRequest delegate Methods
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSString *result=[self soapMessageResult:request];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(finishSoapRequest:userInfo:)]) {
        [self.delegate finishSoapRequest:result userInfo:[request userInfo]];
    }

	if(_finishBlock){
        _finishBlock(result,[request userInfo]);
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
    if(self.delegate&&[self.delegate respondsToSelector:@selector(failedSoapRequest:userInfo:)]){
        [self.delegate failedSoapRequest:error userInfo:[request userInfo]];
    }
    
    if (_failedBlock) {
        _failedBlock(error,[request userInfo]);
    }

}
#pragma mark -
#pragma mark 队列请求
//开始排列
-(void)resetQueue{
    if (!self.networkQueue) {
        self.networkQueue = [[ASINetworkQueue alloc] init];
    }
    [self.networkQueue reset];
    //表示队列操作完成
    [self.networkQueue setQueueDidFinishSelector:@selector(queueFetchComplete:)];
    [self.networkQueue setRequestDidFinishSelector:@selector(requestFetchComplete:)];
    [self.networkQueue setRequestDidFailSelector:@selector(requestFetchFailed:)];
    [self.networkQueue setDelegate:self];
}
-(void)startQueue{
    [self resetQueue];
    for (ASIHTTPRequest *item in self.requestList) {
        [self.networkQueue addOperation:item];
    }
    [self.networkQueue go];
}
//添加队列
-(void)addQueue:(ASIHTTPRequest*)request{
    if (!self.requestList) {
        self.requestList=[[NSMutableArray alloc] init];
    }
    [self.requestList addObject:request];
    
}
//队列请求处理
-(void)queueFetchComplete:(ASIHTTPRequest*)request{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(finishQueueComplete)]){
       [self.delegate finishQueueComplete];
    }    
    if (_finishQueueBlock) {
        _finishQueueBlock();
    }
    if (self.requestList) {
        [self.requestList removeAllObjects];
    }
}
-(void)requestFetchComplete:(ASIHTTPRequest*)request{
   
	NSString *result=[self soapMessageResult:request];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(finishSoapRequest:userInfo:)]) {
        [self.delegate finishSoapRequest:result userInfo:[request userInfo]];
    }
    if (_finishBlock) {
        _finishBlock(result,[request userInfo]);
    }
    
}
-(void)requestFetchFailed:(ASIHTTPRequest*)request{
    
    if(self.delegate&&[self.delegate respondsToSelector:@selector(failedSoapRequest:userInfo:)]){
        [self.delegate failedSoapRequest:[request error] userInfo:[request userInfo]];
    }
    if (_failedBlock) {
        _failedBlock([request error],[request userInfo]);
    }
}
-(void)startQueue:(id<ServiceHelperDelegate>)theDelegate{
    self.delegate=theDelegate;
    [self startQueue:nil failed:nil complete:nil];
}
-(void)startQueue:(finishBlockRequest)finish failed:(failedBlockRequest)failed complete:(finishBlockQueueComplete)finishQueue{
    
    Block_release(_failedBlock);
    Block_release(_finishBlock);
    Block_release(_finishQueueBlock);
    
    _finishBlock=Block_copy(finish);
    _failedBlock=Block_copy(failed);
    _finishQueueBlock=Block_copy(finishQueue);
    
    [self startQueue];

}
#pragma mark -
#pragma mark 对于返回soap信息的处理
/********对于返回soap信息的处理**********/
-(NSString*)soapMessageResult:(ASIHTTPRequest*)request{
    int statusCode = [request responseStatusCode];
    NSError *error=[request error];
    //如果发生错误，就返回空
    if (error||statusCode!=200) {
        return @"";
    }
	NSString *soapAction=[[request requestHeaders] objectForKey:@"SOAPAction"];
    NSString *methodName=@"";
    NSRange range = [soapAction  rangeOfString:@"/" options:NSBackwardsSearch];
    if(range.location!=NSNotFound){
        int pos=range.location;
        methodName=[soapAction stringByReplacingCharactersInRange:NSMakeRange(0, pos+1) withString:@""];
    }
	// Use when fetching text data
	NSString *responseString = [request responseString];
	NSString *result=[SoapXmlParseHelper soapMessageResultXml:responseString serviceMethodName:methodName];
    return result;
    //return responseString;
}
-(void)dealloc{
    Block_release(_failedBlock);
    Block_release(_finishBlock);
    Block_release(_finishQueueBlock);
    Block_release(_progressBlock);
    [requestList release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [networkQueue reset];
    [networkQueue release];
	[super dealloc];
}
@end
