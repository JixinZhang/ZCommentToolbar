//
//  NSBundle+Wscn.h
//  GoldBaseFramework
//
//  Created by Micker on 16/8/29.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Wscn)

- (NSString *) appShortVersion;

- (NSString *) appBoundIdentifier;

- (NSString *) appName;

- (NSString *) appContentForKey:(NSString *) key;

@end
