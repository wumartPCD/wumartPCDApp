
#import <Foundation/Foundation.h>
#import "ASICacheDelegate.h"

@interface ASIDownloadCache : NSObject <ASICacheDelegate> {
	
	ASICachePolicy defaultCachePolicy;
	
	// The directory in which cached data will be stored
	// Defaults to a directory called 'ASIHTTPRequestCache' in the temporary directory
	NSString *storagePath;
	
	// Mediates access to the cache
	NSRecursiveLock *accessLock;
	
	// When YES, the cache will look for cache-control / pragma: no-cache headers, and won't reuse store responses if it finds them
	BOOL shouldRespectCacheControlHeaders;
}

+ (id)sharedCache;

+ (BOOL)serverAllowsResponseCachingForRequest:(ASIHTTPRequest *)request;

+ (NSArray *)fileExtensionsToHandleAsHTML;

@property (assign, nonatomic) ASICachePolicy defaultCachePolicy;
@property (retain, nonatomic) NSString *storagePath;
@property (retain) NSRecursiveLock *accessLock;
@property (assign) BOOL shouldRespectCacheControlHeaders;
@end
