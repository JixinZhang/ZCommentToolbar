//
//   _      ________________ 
//  | | /| / / ___/ ___/ __ \
//  | |/ |/ (__  ) /__/ / / /
//  |__/|__/____/\___/_/ /_/ 
//
//  Created by Micker on 2016/12/9.
//  Copyright © 2016年 WSCN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MMobileFramework/MMobileFramework.h>

// 定义对外公开的接口
@protocol MDemoService <BGService>

@required


@optional

@end

#pragma mark -- Public

/**
 对外的MDemoService的对象
 
 @return MDemoService的对象
 */
id<MDemoService> MDemoService();
