//
//   _      ________________ 
//  | | /| / / ___/ ___/ __ \
//  | |/ |/ (__  ) /__/ / / /
//  |__/|__/____/\___/_/ /_/ 
//
//  Created by Micker on 2016/12/10.
//  Copyright © 2016年 WSCN. All rights reserved.
//

#import "MOnStartServiceImpl.h"

@interface MOnStartServiceImpl ()

@end

@implementation MOnStartServiceImpl

#pragma mark -- MOnStartService



#pragma mark -- BGService

- (void) start {

}

- (void) didCreate {
    [[[self __configCache] __configRPC] __configRouter];
}

- (id) __configRPC {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[GoldNetworkAgent sharedInstance] enableLog:NO];
    
    [GoldNetworkConfig sharedInstance].baseUrl = @"https://api.wallstreetcn.com/";

    DEBUGLOG(@"BASE_URL=%@",[GoldNetworkConfig sharedInstance].baseUrl);
    return self;
}

- (id) __configCache {
    int cacheSizeMemory = 50*1024*1024; // 50MB
    int cacheSizeDisk = 400*1024*1024; // 400MB
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory
                                                            diskCapacity:cacheSizeDisk
                                                                diskPath:@"urlCache"];
    [NSURLCache setSharedURLCache:sharedCache];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    return self;
}

- (id) __configRouter {
#ifdef DEBUG
    [[MRouter sharedRouter] enableDebug];
#endif
    [[MRouter sharedRouter] start];
    return self;
}


@end

#pragma mark -- Public

id<MOnStartService> MOnStartService() {
	return [[BGServiceManager sharedInstance] findServiceByName:@"MOnStartService"]; 
}
