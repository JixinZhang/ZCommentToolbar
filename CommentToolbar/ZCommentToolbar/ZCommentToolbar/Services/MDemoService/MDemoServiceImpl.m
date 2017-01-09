//
//   _      ________________ 
//  | | /| / / ___/ ___/ __ \
//  | |/ |/ (__  ) /__/ / / /
//  |__/|__/____/\___/_/ /_/ 
//
//  Created by Micker on 2016/12/9.
//  Copyright © 2016年 WSCN. All rights reserved.
//

#import "MDemoServiceImpl.h"

@interface MDemoServiceImpl ()

@end

@implementation MDemoServiceImpl

#pragma mark -- MDemoService



#pragma mark -- BGService

- (void) start {

}

- (void) didCreate {
    INFOLOG(@"%@", [self debugDescription]);
}

@end

#pragma mark -- Public

id<MDemoService> MDemoService() {
	return [[BGServiceManager sharedInstance] findServiceByName:@"MDemoService"]; 
}
