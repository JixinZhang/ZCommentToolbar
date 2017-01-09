//
//  MLauncherInterfaceImpl.m
//  MLauncherFramework
//
//  Created by Micker on 16/7/13.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "MLauncherInterfaceImpl.h"
#import "SplashWindow.h"

@implementation MLauncherInterfaceImpl {
    SplashWindow* _splashWindow;
}

- (NSString*)appBriefName {
    return @"launcher";
}

- (NSString*)appBundleIdentifier {
    return @"cn.micker.launcher";
}

- (id)appDelegateEvent:(mBullAppEventType)event arguments:(NSDictionary*)arguments {
    
    if (event == mBullAppEventBeforeStartLoader) {
        // 显示闪屏
        _splashWindow = [SplashWindow showSplashWindow:2.0f
                                          dismissBlock:^(SplashWindow *window) {
            [[BGContext sharedInstance].window makeKeyAndVisible];
            [UIView animateWithDuration:0.6 animations:^{
                UIView* view = window.rootViewController.view;
                view.alpha = 0.0f;
                view.transform = CGAffineTransformMakeScale(1.5, 1.5);
            } completion:^(BOOL finished) {
                _splashWindow = nil;
            }];
            
        }];
    }
    else if (event == mBullAppEventAfterFinishLaunching) {
        if (_splashWindow)
            _splashWindow.bootFinished = YES;
        [self _configDebug];
    }
    return nil;
}

- (id) _configDebug {
#ifdef DEBUG
    [MDebug sharedInstance].parentViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [[MDebug sharedInstance] invocationEvent:MDebugInvocationEventBubble];
#endif
    return self;
}

@end
