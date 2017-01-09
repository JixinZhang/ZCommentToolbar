//
//  GoldNetworkConfig.h
//  B5MRPCFramework
//
//  Created bymickeron 15/11/11.
//  Copyright © 2015年 Micker All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoldBaseRequest;
@protocol B5MUrlFilterProtocol <NSObject>
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(GoldBaseRequest *)request;
@end


@protocol GoldRequestHeaderProtocol <NSObject>
- (NSDictionary *)requestHeaderDictionary:(NSDictionary *)dictionary withRequest:(GoldBaseRequest *)request;
@end


@interface GoldNetworkConfig : NSObject

@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, strong) NSString *cdnUrl;
@property (nonatomic, strong, readonly) NSArray *urlFilters;
@property (nonatomic, strong, readonly) NSArray *headerFilters;

+ (GoldNetworkConfig *)sharedInstance;

- (void)addUrlFilters:(id<B5MUrlFilterProtocol>)filter;

- (void)addRequestHeaders:(id<GoldRequestHeaderProtocol>)filter;;

@end
