//
//  UIImage+Launch.m
//  MLauncherFramework
//
//  Created by Micker on 16/7/13.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "UIImage+Launch.h"

@implementation UIImage (Launch)

+ (UIImage *) launchImage {
    UIImage *image = nil;
    
    int screenWidth = (int)[[UIScreen mainScreen] currentMode].size.width;
    int screenHeight = (int)[[UIScreen mainScreen] currentMode].size.height;
    
    if (screenWidth == 640 && screenHeight == 1136) {
        image = [UIImage imageNamed:@"Default-568h@2x.png"];
    }
    else if (screenWidth == 320 && screenHeight == 480) {
        image = [UIImage imageNamed:@"Default.png"];
    }
    else if (screenWidth == 640 && screenHeight == 960) {
        image = [UIImage imageNamed:@"Default@2x.png"];
    }
    else if (screenWidth == 750 && screenHeight == 1334) {
        image = [UIImage imageNamed:@"LaunchImage-800-667h@2x.png"];
    }
    else if (screenWidth == 1242 && screenHeight == 2208) {
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x.png"];
    }
    else if (screenWidth == 2208 && screenHeight == 1242) {
        image = [UIImage imageNamed:@"LaunchImage-800-Landscape-736h@3x.png"];
    }
    else if (screenWidth == 2048 && screenHeight == 1536) {
        image = [UIImage imageNamed:@"Default-Landscape@2x~ipad.png"];
    }
    else if (screenWidth == 1024 && screenHeight == 768) {
        image = [UIImage imageNamed:@"Default-Landscape~ipad.png"];
    }
    else if (screenWidth == 1536 && screenHeight == 2048) {
        image = [UIImage imageNamed:@"Default-Portrait@2x~ipad.png"];
    }
    else if (screenWidth == 768 && screenHeight == 1024) {
        image = [UIImage imageNamed:@"Default-Portrait~ipad.png"];
    }
    if (!image) {
        image = [UIImage imageNamed:@"LaunchImage"];
    }
    return image;
}
@end
