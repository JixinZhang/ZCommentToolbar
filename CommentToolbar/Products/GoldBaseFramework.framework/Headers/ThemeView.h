//
//  ThemeView.h
//  GoldThemeFramework
//
//  Created by Micker on 16/5/17.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeManager.h"

@interface ThemeView : UIView

@property (nonatomic, copy) void (^block)(void) ;
@property (nonatomic, copy) void (^themeViewHideBlock)(void);

- (instancetype)initWithAdjustFontFrame:(CGRect)frame;

- (void) hide;

- (void) hideAnimated:(BOOL)animated;

@end
