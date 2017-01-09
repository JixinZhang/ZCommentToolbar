//
//  GoldBaseFramework.h
//  GoldBaseFramework
//
//  Created by Micker on 16/5/5.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for GoldBaseFramework.
FOUNDATION_EXPORT double GoldBaseFrameworkVersionNumber;

//! Project version string for GoldBaseFramework.
FOUNDATION_EXPORT const unsigned char GoldBaseFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <GoldBaseFramework/PublicHeader.h>


#if __has_include(<GoldBaseFramework/GoldBaseFramework.h>)

#import <GoldBaseFramework/WSCN_Categories.h>
#import <GoldBaseFramework/BaseViewController.h>
#import <GoldBaseFramework/BaseTableViewController.h>
#import <GoldBaseFramework/BaseNavigationViewController.h>
#import <GoldBaseFramework/ThemeManager.h>
#import <GoldBaseFramework/ThemeManager+FontSize.h>
#import <GoldBaseFramework/ThemeView.h>
#import <GoldBaseFramework/BaseTableViewPresenter.h>
#import <GoldBaseFramework/GoldDefines.h>
#import <GoldBaseFramework/FloatComparison.h>
#import <GoldBaseFramework/BaseEmptyView.h>
#import <GoldBaseFramework/UIView+LoadingView.h>

#else

#import "WSCN_Categories.h"
#import "BaseViewController.h"
#import "BaseTableViewController.h"
#import "BaseNavigationViewController.h"
#import "ThemeManager.h"
#import "ThemeManager+FontSize.h"
#import "ThemeView.h"
#import "BaseTableViewPresenter.h"
#import "GoldDefines.h"
#import "FloatComparison.h"
#import "BaseEmptyView.h"
#import "UIView+LoadingView"

#endif
