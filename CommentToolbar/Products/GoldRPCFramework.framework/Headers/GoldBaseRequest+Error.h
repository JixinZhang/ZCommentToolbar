//
//  GoldBaseRequest+Error.h
//  GoldRPCFramework
//
//  Created by hushaohua on 10/26/16.
//  Copyright © 2016 wallstreetcn. All rights reserved.
//

#import <GoldRPCFramework/GoldRPCFramework.h>
#import "GoldBaseReponse.h"

@interface GoldBaseRequest (Error)

- (GoldErrorResponse *) wscnError;

- (GoldErrorResponse *) finalError;

@end
