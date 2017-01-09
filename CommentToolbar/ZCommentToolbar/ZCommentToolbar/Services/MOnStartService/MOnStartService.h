//
//   _      ________________ 
//  | | /| / / ___/ ___/ __ \
//  | |/ |/ (__  ) /__/ / / /
//  |__/|__/____/\___/_/ /_/ 
//
//  Created by Micker on 2016/12/10.
//  Copyright © 2016年 WSCN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MMobileFramework/MMobileFramework.h>

// 定义对外公开的接口
@protocol MOnStartService <BGService>

@required


@optional

@end

#pragma mark -- Public

/**
 对外的MOnStartService的对象
 
 @return MOnStartService的对象
 */
id<MOnStartService> MOnStartService();
