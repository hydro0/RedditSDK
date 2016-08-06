//
//  RSProtocols.h
//  RedditSDK
//
//  Created by Orest Savchak on 8/5/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#ifndef RSProtocols_h
#define RSProtocols_h

#import "RSSearchConfiguration.h"

@protocol RSLinksURLProvider <NSObject>

- (NSURL *)searchLinksURLWithConfiguration:(RSSearchConfiguration *)configuration;

@end

@protocol RSLinksSerializer <NSObject>

- (NSArray<RSLink *> *)linksFromSearchResponse:(NSDictionary *)response;

@end

@protocol RSLinksCache <NSObject>

typedef void (^RSCacheCallback)(NSArray<RSLink *> *cached);

- (void)getCachedLinksForConfiguration:(RSSearchConfiguration *)configuration withCallback:(RSCacheCallback)callback;
- (void)cacheLinks:(NSArray<RSLink *> *)links forConfiguration:(RSSearchConfiguration *)configuration;
- (void)getFirstAndLastForConfiguration:(RSSearchConfiguration *)configuration withCallback:(RSCacheCallback)callback;

@end


#endif /* RSProtocols_h */
