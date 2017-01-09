//
// 	 _      ________________ 
// 	| | /| / / ___/ ___/ __ \
//	| |/ |/ (__  ) /__/ / / /
//	|__/|__/____/\___/_/ /_/ 
//
//  Created by Micker on 2016/12/9.
//  Copyright © 2016年 WSCN. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MDemoAppDelegate.h"

@interface MDemoAppDelegate ()

@property (nonatomic, strong) UIViewController *rootController;

@end

@implementation MDemoAppDelegate

- (UIViewController *) rootController {
    if (!_rootController) {
        _rootController = [[NSClassFromString(@"MDemoViewController") alloc] init];
    }
    return _rootController;
}

- (UIViewController *)rootViewControllerInApplication:(BGMicroApplication *)application {
    return self.rootController;
}

@end
