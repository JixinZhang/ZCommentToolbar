//
//  BaseViewController+Base.m
//  WASRoot
//
//  Created by Micker on 2016/12/10.
//  Copyright © 2016年 WSCN. All rights reserved.
//

#import "BaseViewController+Base.h"

@implementation BaseViewController (Base)

- (void) doViewDidLoad {
    self.view.backgroundColor = [UIColor getColor:@"F0F2F5"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void) doUpdateTheme:(EThemeType) type {
    
}


-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
