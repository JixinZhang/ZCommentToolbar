//
// 	 _      ________________ 
// 	| | /| / / ___/ ___/ __ \
//	| |/ |/ (__  ) /__/ / / /
//	|__/|__/____/\___/_/ /_/ 
//
//  Created by Micker on 2016/12/10.
//  Copyright © 2016年 WSCN. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MHomeAppDelegate.h"
#import "MTabBarViewController.h"

@interface MHomeAppDelegate ()

@property (nonatomic, strong) UIViewController *rootController;

@end

@implementation MHomeAppDelegate

- (id)init
{
    self = [super init];
    if (self)
    {
        NSArray *baseImgs = [NSArray arrayWithObjects:
                             @"TabBar_News",
                             @"TabBar_Live",
                             @"TabBar_Market",
                             @"TabBar_Find",nil];
        NSArray *selectImgs = [NSArray arrayWithObjects:
                               @"TabBar_News_Sel",
                               @"TabBar_Live_Sel",
                               @"TabBar_Market_Sel",
                               @"TabBar_Find_Sel",nil];
        
        UIViewController* tab1ViewController = [[BaseViewController alloc] init];
        
        // 这里添加一个按钮，演示进入MDemoApp
        tab1ViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"DemoApp"
                                                                                                style:UIBarButtonItemStylePlain
                                                                                               target:self
                                                                                               action:@selector(btnClick)];
        
        UIViewController* tab2ViewController = [[BaseViewController alloc] init];
        UIViewController* tab3ViewController = [[BaseViewController alloc] init];
        UIViewController* tab4ViewController = [[BaseViewController alloc] init];
        
        NSArray *navArray = @[tab1ViewController, tab2ViewController, tab3ViewController, tab4ViewController];
        NSArray *titles = @[@"资讯", @"直播", @"行情", @"发现"];
        for (int i = 0; i < [navArray count]; i ++)
        {
            UIImage *bImg = [UIImage imageNamed:baseImgs[i]];
            UIImage *selectImg = [UIImage imageNamed:selectImgs[i]];
            
            UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titles[i] image:bImg selectedImage:selectImg];
            item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.tag = i;
            [(UIViewController *)navArray[i] setTabBarItem:item];
            ((UIViewController *)navArray[i]).title = titles[i];
        }
        
        MTabBarViewController *tabBarController = [[MTabBarViewController alloc] init];
        tabBarController.viewControllers = navArray;
        tabBarController.selectedIndex = 0;
        [tabBarController.delegate tabBarController:tabBarController didSelectViewController:tab1ViewController];
        self.rootController = tabBarController;
    }
    return self;
}

- (void)btnClick
{
    [[BGContext sharedInstance] startApplication:@"20000002" parames:@{} animated:YES];
}

- (UIViewController *)rootViewControllerInApplication:(BGMicroApplication *)application {
    return self.rootController;
}


@end
