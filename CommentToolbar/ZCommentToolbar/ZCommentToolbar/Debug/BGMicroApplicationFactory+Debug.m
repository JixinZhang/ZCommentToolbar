//
//  BGMicroApplicationFactory+Debug.m
//  WSCN
//
//  Created by Micker on 16/7/28.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "BGMicroApplicationFactory+Debug.h"

@implementation BGMicroApplicationFactory (Debug)

#ifdef DEBUG
- (NSString *) debugApplicationName {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"launcher"];
}
#endif

@end
