//
//  main.m
//  Prototype
//
//  Created by shenmo on 7/20/15.
//  Copyright (c) 2015 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLauncherInterfaceImpl.h"
#import <MMobileFramework/MMobileFramework.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        mBullInit(@"WSCN", [MLauncherInterfaceImpl class]);
        return UIApplicationMain(argc, argv, @"UIApplication", @"BGClientDelegate");
    }
}
