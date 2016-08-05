//
//  RSRuntimeLinksCache.m
//  RedditSDK
//
//  Created by Orest Savchak on 8/4/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import "RSRuntimeLinksCache.h"

@interface RSRuntimeLinksCache ()

@property (strong, nonatomic) NSCache<NSString *, NSMutableArray<RSLink *> *> *cache;

@end

@implementation RSRuntimeLinksCache

- (NSCache<NSString *,NSMutableArray<RSLink *> *> *)cache {
    if (!_cache) {
        _cache = [NSCache new];
    }
    return _cache;
}

- (NSMutableArray<RSLink *> *)cacheForQuery:(NSString *)query {
    NSMutableArray<RSLink *> *cache = [self.cache objectForKey:query];
    if (cache) {
        return cache;
    }
    return cache = [NSMutableArray new];
}

- (void)addToStartOfCache:(NSArray<RSLink *> *)links forConfiguration:(RSSearchConfiguration *)configuration {
    [[self cacheForQuery:configuration.query] insertObjects:links
                                                  atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, links.count)]];
}

#pragma mark RSLinksCache implementation

- (void)getCachedLinksForConfiguration:(RSSearchConfiguration *)configuration withCallback:(RSCacheCallback)callback {
    NSArray<RSLink *> *cache = [self cacheForQuery:configuration.query];
    NSArray<RSLink *> *requested = [cache subarrayWithRange:NSMakeRange(configuration.batchNumber * configuration.limit, configuration.limit)];
    
    callback(requested);
}

- (void)getFirstAndLastForConfiguration:(RSSearchConfiguration *)configuration withCallback:(RSCacheCallback)callback {
    NSArray<RSLink *> *cache = [self cacheForQuery:configuration.query];
    
    callback([NSArray arrayWithObjects:cache.firstObject, cache.lastObject, nil]);
}

- (void)cacheLinks:(NSArray<RSLink *> *)links forConfiguration:(RSSearchConfiguration *)configuration {
    if (configuration.isTopItemsOnly) {
        [self addToStartOfCache:links forConfiguration:configuration];
    } else {
        [[self cacheForQuery:configuration.query] addObjectsFromArray:links];
    }
}

@end
