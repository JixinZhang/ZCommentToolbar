//
//  UIView+LoadingView.h
//  GoldBaseFramework
//
//  Created by wscn on 2016/11/28.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoldBaseFramework/GoldBaseFramework.h>

@interface UIView (LoadingView)

- (void) showLoadingView:(BOOL )flag;

- (void) showErrors: (NSString *) error block:(void (^)())block;

- (void) setLoadingViewFrameX: (CGFloat )x;

- (void) setLoadingViewFrameY: (CGFloat )y;

- (UIImage *)getLoadingImge;

- (UIImage *)getLoadingErrorImage;

@end
