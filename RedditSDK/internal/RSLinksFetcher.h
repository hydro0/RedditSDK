//
//  RSLinksFetcher.h
//  RedditSDK
//
//  Created by Orest Savchak on 8/4/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSearchConfiguration.h"
#import "RSLinksNetworkFetcher.h"

@interface RSLinksFetcher : NSObject

+ (instancetype)fetcherWithCache:(id<RSLinksCache>)cache andNetworkFetcher:(RSLinksNetworkFetcher *)networkFetcher;

- (instancetype)initWithCache:(id<RSLinksCache>)cache andNetworkFetcher:(RSLinksNetworkFetcher *)networkFetcher;
- (void)fetchLinksWithConfiguration:(RSSearchConfiguration *)configuration andCallback:(RSCallback)callback;

@end
