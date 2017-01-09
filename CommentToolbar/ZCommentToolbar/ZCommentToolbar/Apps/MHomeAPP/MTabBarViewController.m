//
//  MTabBarViewController.m
//  ZCommentToolbar
//
//  Created by Micker on 2016/12/9.
//  Copyright © 2016年 WSCN. All rights reserved.
//

#import "MTabBarViewController.h"

@implementation MTabBarViewController

#pragma mark -- Override
- (void)loadView
{
    [super loadView];
    self.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self m_configViews];
    [self m_configEvents];
    [self m_configDatas];
}

#pragma mark -- Internal

- (void) m_configViews {
    //配置视图
}

- (void) m_configEvents {
    //配置事件
}

- (void) m_configDatas {
    //配置数据
}

#pragma mark -- Action


#pragma mark -- UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    self.title = viewController.title;
    if (!self.title)
        self.title = viewController.navigationItem.title;
    self.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem;
    self.navigationItem.leftBarButtonItems = viewController.navigationItem.leftBarButtonItems;
    self.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItems = viewController.navigationItem.rightBarButtonItems;
}

#pragma mark -- Getter



#pragma mark -- Setter


@end
