//
//  SplashWindow.m
//  MobileFramework
//
//  Created by micker on 15/5/18.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import "SplashWindow.h"
#import <MMobileFramework/MMobileFramework.h>
#import "UIImage+Launch.h"

@interface SplashWindow ()

@property (nonatomic, assign) BOOL canDismiss;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, copy) SplashDismissBlock dismissBlock;

@end

@implementation SplashWindow

+ (SplashWindow*)showSplashWindow:(NSTimeInterval)minTime dismissBlock:(SplashDismissBlock)dismissBlock
{
    BGViewController* viewController = [[BGViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage launchImage];
    [viewController.view addSubview:imageView];
    
    SplashWindow* splashWindow = [[SplashWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if (minTime > 0)
        splashWindow.timer = [NSTimer scheduledTimerWithTimeInterval:minTime
                                                              target:splashWindow
                                                            selector:@selector(shouldDismiss)
                                                            userInfo:nil
                                                             repeats:NO];
    else
        splashWindow.canDismiss = YES;
    splashWindow.dismissBlock = dismissBlock;
    splashWindow.userInteractionEnabled = NO;
    splashWindow.windowLevel = UIWindowLevelStatusBar - 1;
    splashWindow.rootViewController = viewController;
    [splashWindow makeKeyAndVisible];
    return splashWindow;
}

- (void)shouldDismiss
{
    self.timer = nil;
    self.canDismiss = YES;
    if (self.bootFinished)
        _dismissBlock(self);
}

- (void)setBootFinished:(BOOL)bootFinished
{
    _bootFinished = bootFinished;
    if (self.canDismiss)
        _dismissBlock(self);
}

@end
