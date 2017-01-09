//
//  SplashWindow.h
//  MobileFramework
//
//  Created by micker on 15/5/18.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import <UIKit/UIKit.h>

@class SplashWindow;

typedef void (^SplashDismissBlock)(SplashWindow* window);

@interface SplashWindow : UIWindow

@property (nonatomic, assign) BOOL bootFinished; // 启动完成才能消失，即使minTime已经到了

+ (SplashWindow*)showSplashWindow:(NSTimeInterval)minTime dismissBlock:(SplashDismissBlock)dismissBlock;

@end

